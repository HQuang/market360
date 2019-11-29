<?php

/**
 * @Project NUKEVIET 4.x
 * @Author mynukeviet (contact@mynukeviet.net)
 * @Copyright (C) 2016 mynukeviet. All rights reserved
 * @Createdate Sun, 20 Nov 2016 07:31:04 GMT
 */
if (!defined('NV_IS_MOD_MARKET')) die('Stop!!!');

if (!defined('NV_IS_MODADMIN') and $page < 5) {
    $cache_file = NV_LANG_DATA . '_' . $module_info['template'] . '_' . $op . '_' . $catid . '_' . $page . '_' . NV_CACHE_PREFIX . '.cache';
    if (($cache = $nv_Cache->getItem($module_name, $cache_file)) != false) {
        $contents = $cache;
    }
}

$page_title = !empty($array_market_cat[$catid]['custom_title']) ? $array_market_cat[$catid]['custom_title'] : $array_market_cat[$catid]['title'];
$key_words = $array_market_cat[$catid]['keywords'];
$description = $array_market_cat[$catid]['description'];

$nv_Request->get_string('viewtype', 'session', 'viewlist');
$viewtype = $nv_Request->get_string('viewtype', 'post', 'viewlist');
$viewtype_old = $nv_Request->get_string('viewtype', 'session', 'viewlist');
$viewtype = $nv_Request->get_string('viewtype', 'post', $viewtype_old);

if (empty($contents)) {

    $array_config['hometype'] = $viewtype;

    if (!empty($array_market_cat[$catid]['image']) and file_exists(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $array_market_cat[$catid]['image'])) {
        $meta_property['og:image'] = NV_MY_DOMAIN . NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $array_market_cat[$catid]['image'];
    }

    $base_url = $array_market_cat[$catid]['link'];
    $array_data = $array_subcat_data = array();
    $array_catid = nv_GetCatidInParent($catid);

    if (!empty($array_market_cat[$catid]['subid'])) {
        $subid = explode(',', $array_market_cat[$catid]['subid']);
        foreach ($subid as $_catid) {
            $array_subcat_data[$_catid] = $array_market_cat[$_catid];
        }
    }

    $db->sqlreset()
        ->select('COUNT(*)')
        ->from(NV_PREFIXLANG . '_' . $module_data . '_rows')
        ->where('status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ') AND catid IN (' . implode(',', $array_catid) . ')');

    $sth = $db->prepare($db->sql());

    $sth->execute();
    $num_items = $sth->fetchColumn();

    $db->select('id, title, description, groupid, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, unitid, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groups_config')
        ->order('prior DESC, ordertime DESC')
        ->limit($per_page)
        ->offset(($page - 1) * $per_page);

    $sth = $db->prepare($db->sql());
    $sth->execute();

    $array_field_config = array();
    $array_custom_field_title = array();

//     $block_cat = $nv_Cache->db('SELECT  bid, title, description, alias FROM ' . NV_PREFIXLANG . '_' . $module_data . '_block_cat', '', $module);
    while ($_row = $sth->fetch()) {

        //         Đếm số lượng ảnh
        $_row['count_image'] = $db->query('SELECT  COUNT(path) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_images WHERE rowsid=' . $_row['id'])->fetchColumn();
        //         Nhận diện nhóm tin

        //         lưu tin
        $_row['is_user'] = 0;
        $_row['style_save'] = $_row['style_saved'] = '';
        if (defined('NV_IS_USER')) {

            $_row['is_user'] = 1;
            $count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_saved WHERE rowsid=' . $_row['id'] . ' AND userid=' . $user_info['userid'])->fetchColumn();
            if ($count) {
                $_row['style_save'] = 'style="display: none"';
            } else {
                $_row['style_saved'] = 'style="display: none"';
            }
        } else {
            $_row['style_saved'] = 'style="display: none"';
        }
        //         lưu tin
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
                if (in_array(5, $row['show_locations'])) {
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

    if ($page > 1) {
        $page_title = $page_title . ' - ' . $lang_global['page'] . ' ' . $page;
    }
    $page = nv_alias_page($page_title, $base_url, $num_items, $per_page, $page);

    $contents = nv_theme_market_viewcat($array_data, $array_subcat_data, $array_config['hometype'], $page);

    if (!defined('NV_IS_MODADMIN') and $contents != '' and $cache_file != '') {
        $nv_Cache->setItem($module_name, $cache_file, $contents);
    }
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';