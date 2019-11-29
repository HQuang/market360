<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 10 Dec 2011 06:46:54 GMT
 */
if (!defined('NV_MAINFILE')) {
    die('Stop!!!');
}

if (!nv_function_exists('nv_block_market_post')) {

    function nv_block_market_config_post($module, $data_block, $lang_block)
    {
        global $site_mods, $global_config;

        $array_type = array(
            $lang_block['type0'],
            $lang_block['type1']
        );

        $array_template = array(
            $lang_block['template0']
        );

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/market/block_post_config.tpl')) {
            $block_theme = $global_config['module_theme'];
        } else {
            $block_theme = 'default';
        }

        $xtpl = new XTemplate('block_post_config.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/modules/market');
        $xtpl->assign('LANG', $lang_block);
        $xtpl->assign('DATA', $data_block);

        foreach ($array_type as $index => $value) {
            $ck = (isset($data_block['type']) and $index == $data_block['type']) ? 'checked="checked"' : '';
            $xtpl->assign('TYPE', array(
                'index' => $index,
                'value' => $value,
                'checked' => $ck
            ));
            $xtpl->parse('main.type');
        }

        foreach ($array_template as $index => $value) {
            $ck = (isset($data_block['template']) and $index == $data_block['template']) ? 'checked="checked"' : '';
            $xtpl->assign('TEMPLATE', array(
                'index' => $index,
                'value' => $value,
                'checked' => $ck
            ));
            $xtpl->parse('main.template');
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }

    function nv_block_market_config_post_submit($module, $lang_block)
    {
        global $nv_Request;
        $return = array();
        $return['error'] = array();
        $return['config'] = array();
        $return['config']['type'] = $nv_Request->get_int('config_type', 'type', 0);
        $return['config']['template'] = $nv_Request->get_int('config_template', 'post', 0);
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 0);
        $return['config']['title_lenght'] = $nv_Request->get_int('config_title_lenght', 'post', 0);
        return $return;
    }

    function nv_block_market_post($block_config)
    {
        global $db_config, $array_market_cat, $module_array_cat, $module_info, $site_mods, $module_config, $global_config, $nv_Cache, $db, $array_config, $lang_module, $money_config, $module_name;

        $module = $block_config['module'];
        $mod_data = $site_mods[$module]['module_data'];
        $mod_file = $site_mods[$module]['module_file'];
        $mod_upload = $site_mods[$module]['module_upload'];
        $array_config = $module_config[$module];

        if ($module != $module_name) {
            $array_market_cat = $module_array_cat;
            require_once NV_ROOTDIR . '/modules/' . $mod_file . '/language/' . NV_LANG_INTERFACE . '.php';
            require_once NV_ROOTDIR . '/modules/' . $mod_file . '/site.functions.php';
        }

        $order = 'ordertime DESC';
        $where = 'status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ')';
        if ($block_config['type'] == 1) {
            $order = 'countview DESC';
        }

        $db->sqlreset()
            ->select('id, title, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, unitid, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groups_config')
            ->from(NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows')
            ->where($where)
            ->order($order)
            ->limit($block_config['numrow']);
        //         $list = $nv_Cache->db($db->sql(), '', $module);

        $sth = $db->prepare($db->sql());
        $sth->execute();

        $array_data = $array_field_config = $array_custom_field_title = array();

        while ($_row = $sth->fetch()) {
            if (nv_user_in_groups($_row['groupview'])) {
                if (!empty($data = nv_market_data($_row, $module))) {
                    // custom field
                    $data['custom_field'] = array();
                    if (!isset($array_custom_field_title[$_row['catid']])) {
                        if ($array_market_cat[$data['catid']]['form'] != '') {
                            $idtemplate = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_template where alias = "' . preg_replace("/[\_]/", "-", $array_market_cat[$data['catid']]['form']) . '"')->fetchColumn();
                            if ($idtemplate) {
                                $result = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_field ORDER BY weight');
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
            $result = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_" . $site_mods[$module]['module_data'] . "_info WHERE rowid IN (" . implode(',', array_keys($array_data)) . ")");
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

        if (!empty($array_data)) {
            $template = 'block_post_list.tpl';
            if ($block_config['template'] == 1) {
                $template = 'block_post_list_simple.tpl';
            }

            if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/market/' . $template)) {
                $block_theme = $global_config['module_theme'];
            } else {
                $block_theme = 'default';
            }

            if ($module != $module_name) {
                $my_head .= '<link rel="StyleSheet" href="' . NV_BASE_SITEURL . 'themes/' . $block_theme . '/css/market.css' . '">';
            }

            $xtpl = new XTemplate($template, NV_ROOTDIR . '/themes/' . $block_theme . '/modules/market');
            $xtpl->assign('LANG', $lang_module);
            $xtpl->assign('TEMPLATE', $block_theme);
            $home_image_size = explode('x', $array_config['home_image_size']);
            $xtpl->assign('WIDTH', $home_image_size[0]);
            $xtpl->assign('HEIGHT', $home_image_size[1]);

            foreach ($array_data as $data) {
                $xtpl->assign('ROW', $data);
                if (!empty($data['custom_field'])) {
                    foreach ($data['custom_field'] as $field) {
                        if (!empty($field['value']) and in_array(1, $field['show_locations'])) {
                            $xtpl->assign('FIELD', $field);
                            $xtpl->parse('main.loop.field');
                        }
                    }
                }
                $xtpl->parse('main.loop');
            }

            $xtpl->parse('main');
            return $xtpl->text('main');
        }
    }
}
if (defined('NV_SYSTEM')) {
    global $site_mods, $module_name, $array_market_cat, $module_array_cat, $nv_Cache, $db;

    $module = $block_config['module'];

    if (isset($site_mods[$module])) {
        if ($module == $module_name) {
            $module_array_cat = $array_market_cat;
        } else {
            $module_array_cat = array();
            $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_cat WHERE status=1 ORDER BY sort';
            $list = $nv_Cache->db($sql, 'id', $module);
            if (!empty($list)) {
                foreach ($list as $l) {
                    $module_array_cat[$l['id']] = $l;
                    $module_array_cat[$l['id']]['link'] = NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module . "&amp;" . NV_OP_VARIABLE . "=" . $l['alias'];
                }
            }
        }
        $content = nv_block_market_post($block_config);
    }
}
