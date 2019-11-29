<?php

/**
 * @Project NUKEVIET 4.x
 * @Author mynukeviet (contact@mynukeviet.net)
 * @Copyright (C) 2016 mynukeviet. All rights reserved
 * @Createdate Sun, 20 Nov 2016 07:31:04 GMT
 */
if (!defined('NV_IS_MOD_MARKET')) die('Stop!!!');
$page_title = $module_info['site_title'];
$key_words = $module_info['keywords'];

$array_data = array();
$contents = '';
$cache_file = '';

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name;
$base_url_rewrite = nv_url_rewrite($base_url, true);
$page_url_rewrite = ($page > 1) ? nv_url_rewrite($base_url . '/page-' . $page, true) : $base_url_rewrite;
$request_uri = $_SERVER['REQUEST_URI'];
if (!($home or $request_uri == $base_url_rewrite or $request_uri == $page_url_rewrite or NV_MAIN_DOMAIN . $request_uri == $base_url_rewrite or NV_MAIN_DOMAIN . $request_uri == $page_url_rewrite)) {
    $redirect = '<meta http-equiv="Refresh" content="3;URL=' . $base_url_rewrite . '" />';
    nv_info_die($lang_global['error_404_title'], $lang_global['error_404_title'], $lang_global['error_404_content'] . $redirect, 404);
}

$nv_Request->get_int('sorts', 'session', 0);
$sorts = $nv_Request->get_int('sort', 'post', 0);
$sorts_old = $nv_Request->get_int('sorts', 'session', $pro_config['sortdefault']);
$sorts = $nv_Request->get_int('sorts', 'post', $sorts_old);

$nv_Request->get_string('viewtype', 'session', '');
$viewtype = $nv_Request->get_string('viewtype', 'post', '');
$viewtype_old = $nv_Request->get_string('viewtype', 'session', '');
$viewtype = $nv_Request->get_string('viewtype', 'post', $viewtype_old);

if (!empty($viewtype)) {
    $array_config['hometype'] = $viewtype;
}

if (!defined('NV_IS_MODADMIN') and $page < 5 and !$ajax) {
    $cache_file = NV_LANG_DATA . '_' . $module_info['template'] . '_' . $op . '_' . $catid . '_' . $page . '_' . NV_CACHE_PREFIX . '.cache';
    if (($cache = $nv_Cache->getItem($module_name, $cache_file)) != false) {
        $contents = $cache;
    }
}

if ($sorts == 0) {
    $orderby = 'id DESC ';
} elseif ($sorts == 1) {
    $orderby = 'price ASC, id DESC ';
} else {
    $orderby = ' price DESC, id DESC ';
}


if (empty($contents)) {
    // hien thi tat ca
    if ($array_config['homedata'] == 1) {

        $db->sqlreset()
            ->select('COUNT(*)')
            ->from(NV_PREFIXLANG . '_' . $module_data . '_rows t1')
            ->join(' INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_detail t2 ON t1.id = t2.id')
            ->where('status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ')');

        $sth = $db->prepare($db->sql());

        $sth->execute();
        $num_items = $sth->fetchColumn();

        $db->select('t1.id, title, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, unitid, description, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groups_config, t2.contact_fullname, t2.contact_phone, t2.contact_email, t2.contact_address')
        ->order($orderby)
            ->limit($per_page)
            ->offset(($page - 1) * $per_page);

        $sth = $db->prepare($db->sql());
        $sth->execute();

        $array_field_config = array();
        $array_custom_field_title = array();
        while ($_row = $sth->fetch()) {
            if (nv_user_in_groups($_row['groupview'])) {
                if (!empty($data = nv_market_data($_row, $module_name))) {
                    // custom field
                    $data['custom_field'] = array();

                    if (!isset($array_custom_field_title[$_row['catid']])) {
                        if ($array_market_cat[$data['catid']]['form'] != '') {
                            $idtemplate = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_template where alias = "' . preg_replace("/[\_]/", "-", $array_market_cat[$data['catid']]['form']) . '"')->fetchColumn();
                            if ($idtemplate) {
                                $result = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_field ORDER BY weight');
                                while ($row_field = $result->fetch()) {
                                    $listtemplate = explode(',', $row_field['listtemplate']);
                                    if (in_array($idtemplate, $listtemplate)) {
                                        $language = unserialize($row_field['language']);
                                        $row_field['title'] = (isset($language[NV_LANG_DATA])) ? $language[NV_LANG_DATA][0] : $row_field['field'];
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
                    $array_data[$_row['id']] = $data;
                }
            }
        }

        if (!empty($array_field_config)) {
            $result = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_info WHERE rowid IN (" . implode(',', array_keys($array_data)) . ")");
            while ($custom_fields = $result->fetch()) {
                foreach ($array_field_config as $row) {
                    $row['show_locations'] = explode(',', $row['show_locations']);
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

        if ($page > 1) {
            $page_title = $page_title . ' - ' . $lang_global['page'] . ' ' . $page;
        }
        $page = nv_alias_page($page_title, $base_url, $num_items, $per_page, $page);

        $contents = nv_theme_market_main($array_data, $array_config['hometype'], $page);

        if (!defined('NV_IS_MODADMIN') and $contents != '' and $cache_file != '') {
            $nv_Cache->setItem($module_name, $cache_file, $contents);
        }
    } elseif ($array_config['homedata'] == 2) {
        if (!empty($array_market_cat)) {
            foreach ($array_market_cat as $catid_i => $array_info_i) {
                if ($array_info_i['parentid'] == 0 and $array_info_i['inhome']) {
                    $array_market_cat_id = nv_GetCatidInParent($catid_i);

                    $db->sqlreset()
                        ->select('COUNT(*)')
                        ->from(NV_PREFIXLANG . '_' . $module_data . '_rows t1')
                        ->join(' INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_detail t2 ON t1.id = t2.id')
                        ->where('status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ') AND catid IN (' . implode(',', $array_market_cat_id) . ')');

                    $sth = $db->prepare($db->sql());

                    $sth->execute();
                    $num_items = $sth->fetchColumn();
                    $db->select('t1.id, title, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, description, unitid, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groups_config, t2.contact_fullname, t2.contact_phone, t2.contact_email, t2.contact_address')
                        ->order('prior DESC, ordertime DESC')
                        ->limit($per_page)
                        ->offset(($page - 1) * $per_page);

                    $sth = $db->prepare($db->sql());
                    $sth->execute();

                    $data = array();
                    $array_field_config = array();
                    $array_custom_field_title = array();
                    while ($_row = $sth->fetch()) {
                        if (nv_user_in_groups($_row['groupview'])) {
                            if (!empty($_row = nv_market_data($_row, $module_name))) {
                                // custom field
                                $_row['custom_field'] = array();

                                if (!isset($array_custom_field_title[$_row['catid']])) {
                                    if ($array_market_cat[$_row['catid']]['form'] != '') {
                                        $idtemplate = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_template where alias = "' . preg_replace("/[\_]/", "-", $array_market_cat[$_row['catid']]['form']) . '"')->fetchColumn();
                                        if ($idtemplate) {
                                            $result = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_field ORDER BY weight');
                                            while ($row_field = $result->fetch()) {
                                                $listtemplate = explode(',', $row_field['listtemplate']);
                                                if (in_array($idtemplate, $listtemplate)) {
                                                    $language = unserialize($row_field['language']);
                                                    $row_field['title'] = (isset($language[NV_LANG_DATA])) ? $language[NV_LANG_DATA][0] : $row_field['field'];
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
                                                    $array_custom_field_title[$_row['catid']] = $array_field_config;
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    $array_field_config = $array_custom_field_title[$_row['catid']];
                                }

                                $data[$_row['id']] = $_row;
                            }
                        }
                    }

                    if (!empty($array_field_config)) {
                        $result = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_info WHERE rowid IN (" . implode(',', array_keys($data)) . ")");
                        while ($custom_fields = $result->fetch()) {
                            foreach ($array_field_config as $row) {
                                $row['show_locations'] = explode(',', $row['show_locations']);
                                if (in_array(4, $row['show_locations'])) {
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
                                    $data[$custom_fields['rowid']]['custom_field'][$row['field']] = $row;
                                }
                            }
                        }
                    }

                    $array_data[$catid_i] = array(
                        'title' => $array_info_i['title'],
                        'link' => $array_info_i['link'],
                        'viewtype' => $array_info_i['viewtype'],
                        'numlinks' => $array_info_i['numlinks'],
                        'count' => $num_items,
                        'subid' => $array_info_i['subid'],
                        'data' => $data
                    );
                }
            }
        }

        $contents = nv_theme_market_main_cat($array_data, $array_config['hometype']);

        if (!defined('NV_IS_MODADMIN') and $contents != '' and $cache_file != '') {
            $nv_Cache->setItem($module_name, $cache_file, $contents);
        }
    }
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';