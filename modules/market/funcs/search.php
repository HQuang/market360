<?php

/**
 * @Project NUKEVIET 4.x
 * @Author mynukeviet (contact@mynukeviet.net)
 * @Copyright (C) 2016 mynukeviet. All rights reserved
 * @Createdate Sun, 20 Nov 2016 07:31:04 GMT
 */
if (!defined('NV_IS_MOD_MARKET')) die('Stop!!!');

$page = $nv_Request->get_int('page', 'get', 1);
$array_title = $array_alias = $array_data = array();
$where = '';
$is_search = 0;

$array_data = array();
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '/';
$base_url_rewrite = $request_uri = urldecode($_SERVER['REQUEST_URI']);

$array_search = array(
    'type' => $nv_Request->get_int('type', 'post,get', $array_search_params['typeid']),
    'q' => $nv_Request->get_title('q', 'post,get', ''),
    'catid' => $nv_Request->get_int('catid', 'post,get', $array_search_params['catid']),
    'area_p' => $nv_Request->get_int('area_p', 'post,get', $array_search_params['provinceid']),
    'area_d' => $nv_Request->get_int('area_d', 'post,get', $array_search_params['districtid']),
    'area_w' => $nv_Request->get_int('area_w', 'post,get', $array_search_params['wardid'])
);

if (!empty($array_search['type'])) {
    $where .= ' AND typeid=' . $array_search['type'];
    $array_alias[] = $array_type[$array_search['type']]['alias'];
    $array_title['type'] = $array_type[$array_search['type']]['title'];
} else {
    $array_alias[] = 'all';
    $array_title['type'] = $lang_module['all'];
}

if (!empty($array_search['catid'])) {
    $_array_cat = nv_GetCatidInParent($array_search['catid']);
    $where .= ' AND catid IN (' . implode(',', $_array_cat) . ')';
    $array_title['typeid'] = $array_title['typeid'] . ' ' . $array_market_cat[$array_search['catid']]['title'];
    $array_alias[] = $array_market_cat[$array_search['catid']]['alias'];
}

if (!empty($array_search['area_w'])) {
    $where .= ' AND area_w = ' . $array_search['area_w'];
    $search_ward = $db->query('SELECT title, alias, type FROM ' . $db_config['prefix'] . '_location_ward WHERE wardid=' . $db->quote($array_search['area_w']))
        ->fetch();
    $array_title[] = $search_ward['type'] . ' ' . $search_ward['title'];
    $array_alias[] = change_alias($search_ward['type']) . '-' . $search_ward['alias'];
}
if (!empty($array_search['area_d'])) {
    $where .= ' AND area_d = ' . $array_search['area_d'];
    $search_district = $db->query('SELECT title, alias, type FROM ' . $db_config['prefix'] . '_location_district WHERE districtid=' . $db->quote($array_search['area_d']))
        ->fetch();
    $array_title[] = $search_district['type'] . ' ' . $search_district['title'];
    $array_alias[] = change_alias($search_district['type']) . '-' . $search_district['alias'];
}

if (!empty($array_search['area_p'])) {
    $where .= ' AND area_p=' . $array_search['area_p'];
    $search_province = $db->query('SELECT title, alias, type FROM ' . $db_config['prefix'] . '_location_province WHERE provinceid=' . $db->quote($array_search['area_p']))
        ->fetch();
    $array_alias[] = change_alias($search_province['type']) . '-' . $search_province['alias'];
    $array_title[] = $search_province['type'] . ' ' . $search_province['title'];
}

if (!empty($array_search['q'])) {
    $where .= ' AND (code LIKE ' . $db->quote("%" . $array_search['q'] . "%") . '
    	OR title LIKE ' . $db->quote("%" . $array_search['q'] . "%") . '
    	OR content LIKE ' . $db->quote("%" . $array_search['q'] . "%") . '
    	OR note LIKE ' . $db->quote("%" . $array_search['q'] . "%") . ')';
}

if (!empty($array_search['q'])) {
    $array_title[] = $array_search['q'];
}

if ($nv_Request->isset_request('is_search', 'get')) {
    $base_url .= !empty($array_alias) ? implode('-', $array_alias) : '';
    if (!empty($array_search['q'])) {
        $base_url .= '&q=' . $array_search['q'];
    }
    nv_redirect_location(strtolower($base_url));
}

if (!empty($where) || empty($array_search['type'])) {
    $is_search = 1;
}

$viewtype = $array_config['hometype'];

$db->sqlreset()
    ->select('COUNT(*)')
    ->from(NV_PREFIXLANG . '_' . $module_data . '_rows t1')
    ->join(' INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_detail t2 ON t1.id=t2.id')
    ->where('status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ')' . $where);
$sth = $db->prepare($db->sql());

$sth->execute();
$num_items = $sth->fetchColumn();

$db->select('t1.id, title, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, unitid, description, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, groups_config, t2.maps')
    ->order('ordertime DESC')
    ->limit($per_page)
    ->offset(($page - 1) * $per_page);
$sth = $db->prepare($db->sql());
$sth->execute();

$array_json = array();
$array_field_config = array();
$array_custom_field_title = array();

while ($row = $sth->fetch()) {

    $row['count_image'] = $db->query('SELECT  COUNT(path) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_images WHERE rowsid=' . $row['id'])->fetchColumn();
    $row['is_user'] = 0;
    $row['style_save'] = $row['style_saved'] = '';
    if (defined('NV_IS_USER')) {

        $row['is_user'] = 1;
        $count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_saved WHERE rowsid=' . $row['id'] . ' AND userid=' . $user_info['userid'])->fetchColumn();
        if ($count) {
            $row['style_save'] = 'style="display: none"';
        } else {
            $row['style_saved'] = 'style="display: none"';
        }
    } else {
        $row['style_saved'] = 'style="display: none"';
    }
    if (nv_user_in_groups($row['groupview'])) {
        if (!empty($data = nv_market_data($row, $module_name))) {
            // custom field
            $data['custom_field'] = array();

            if (!isset($array_custom_field_title[$row['catid']])) {
                if ($array_market_cat[$data['catid']]['form'] != '') {
                    $idtemplate = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_template where alias = "' . preg_replace("/[\_]/", "-", $array_market_cat[$data['catid']]['form']) . '"')->fetchColumn();
                    if ($idtemplate) {
                        $result = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_field ORDER BY weight');
                        while ($row_field = $result->fetch()) {
                            $listtemplate = explode(',', $row_field['listtemplate']);
                            if (in_array($idtemplate, $listtemplate)) {
                                $language = unserialize($row_field['language']);
                                $row_field['title'] = (isset($language[NV_LANG_DATA])) ? $language[NV_LANG_DATA][0] : $row_field['field'];
                                if (!empty($row_field['icon'])) {
                                    $row_field['icon'] =  $row_field['icon'];
                                }else {
                                    $row_field['icon'] = NV_BASE_SITEURL . 'themes/default/images/no_icon.png';
                                }
                                $row_field['description'] = (isset($language[NV_LANG_DATA])) ? nv_htmlspecialchars($language[NV_LANG_DATA][1]) : '';
                                if (!empty($row_field['field_choices'])) {
                                    $row_field['field_choices'] = unserialize($row_field['field_choices']);
                                } elseif (!empty($row_field['sql_choices'])) {
                                    $row_field['field_choices'] = array();
                                    $row_field['sql_choices'] = explode(',', $row_field['sql_choices']);
                                    $query = 'SELECT ' . $row_field['sql_choices'][2] . ', ' . $row_field['sql_choices'][3] . ' FROM ' . $row_field['sql_choices'][1];
                                    $result = $db->query($query);
                                    $weight = 0;
                                    while (list ($key, $val) = $result->fetch(3)) {
                                        $row_field['field_choices'][$key] = $val;
                                    }
                                }
                                $array_field_config[$row_field['field']] = $row_field;
                                $array_custom_field_title[$data['catid']] = $array_field_config;
                            }
                        }
                    }
                }
            } else {
                $array_field_config = $array_custom_field_title[$data['catid']];
            }
            $array_data[$row['id']] = $data;
        }
    }
    if (!empty($array_field_config)) {
        $result = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_info WHERE rowid IN (" . implode(',', array_keys($array_data)) . ")");
        while ($custom_fields = $result->fetch()) {
            foreach ($array_field_config as $row) {
                $row['show_locations'] = explode(',', $row['show_locations']);
                if (in_array(7, $row['show_locations'])) {

                    $row['value'] = (isset($custom_fields[$row['field']])) ? $custom_fields[$row['field']] : $row['default_value'];
                    if (empty($display_empty) && empty($row['value'])) continue;
                    if ($row['field_type'] == 'date') {
                        if (!preg_match('/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/', $row['value'], $m)) {
                            $row['value'] = (empty($row['value'])) ? '' : date('d/m/Y', $row['value']);
                        }
                    } elseif ($row['field_type'] == 'textarea') {
                        $row['value'] = nv_htmlspecialchars(nv_br2nl($row['value']));
                    } elseif ($row['field_type'] == 'editor') {
                        $row['value'] = htmlspecialchars(nv_editor_br2nl($row['value']));
                    } elseif ($row['field_type'] == 'select' || $row['field_type'] == 'radio') {
                        $row['value'] = isset($row['field_choices'][$row['value']]) ? $row['field_choices'][$row['value']] : '';
                    } elseif ($row['field_type'] == 'checkbox' || $row['field_type'] == 'multiselect') {
                        $row['value'] = !empty($row['value']) ? explode(',', $row['value']) : array();
                        $str = array();
                        if (!empty($row['value'])) {
                            foreach ($row['value'] as $value) {
                                if (isset($row['field_choices'][$value])) {
                                    $str[] = $row['field_choices'][$value];
                                }
                            }
                        }
                        $row['value'] = implode(', ', $str);
                    }
                    $array_data[$custom_fields['rowid']]['custom_field'][$row['field']] = $row;

                }
            }
        }
    }

    if ($row['maps']) {
        $row['maps'] = unserialize($row['maps']);
        $json['lat'] = $row['maps']['maps_mapcenterlat'];
        $json['lng'] = $row['maps']['maps_mapcenterlng'];
        $json['title'] = $row['title'];
        $array_json[] = $json;
    }
}

$lang_module['search_result_number'] = sprintf($lang_module['search_result_number'], $num_items);

if ($page > 1) {
    $page_title = $page_title . ' - ' . $lang_global['page'] . ' ' . $page;
}
$generate_page = '';
if ($num_items > $per_page) {
    $url_link = $_SERVER['REQUEST_URI'];
    if (strpos($url_link, '&page=') > 0) {
        $url_link = substr($url_link, 0, strpos($url_link, '&page='));
    } elseif (strpos($url_link, '?page=') > 0) {
        $url_link = substr($url_link, 0, strpos($url_link, '?page='));
    }
    $_array_url = array(
        'link' => $url_link,
        'amp' => '&page='
    );
    $generate_page = nv_generate_page($_array_url, $num_items, $per_page, $page);
}

$page_title = implode(', ', $array_title);
$array_mod_title[] = array(
    'title' => $page_title
);

$contents = nv_theme_market_search($array_data, $is_search, $array_config['style_default'], $generate_page, $array_json);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';