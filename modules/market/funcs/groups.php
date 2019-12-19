<?php

/**
 * @Project NUKEVIET 4.x
 * @Author mynukeviet (contact@mynukeviet.net)
 * @Copyright (C) 2016 mynukeviet. All rights reserved
 * @Createdate Sun, 20 Nov 2016 07:31:04 GMT
 */
if (!defined('NV_IS_MOD_MARKET')) die('Stop!!!');

if (isset($array_op[1])) {
    $alias = trim($array_op[1]);
    $page = (isset($array_op[2]) and substr($array_op[2], 0, 5) == 'page-') ? intval(substr($array_op[2], 5)) : 1;

    $stmt = $db->prepare('SELECT bid, title, alias, image, description, keywords FROM ' . NV_PREFIXLANG . '_' . $module_data . '_block_cat WHERE alias= :alias');
    $stmt->bindParam(':alias', $alias, PDO::PARAM_STR);
    $stmt->execute();
    list ($bid, $page_title, $alias, $image_group, $description, $key_words) = $stmt->fetch(3);
    if ($bid > 0) {
        $base_url_rewrite = $base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $module_info['alias']['groups'] . '/' . $alias;
        $array_data = array();

        if ($page > 1) {
            $page_title .= ' ' . NV_TITLEBAR_DEFIS . ' ' . $lang_global['page'] . ' ' . $page;
            $base_url_rewrite .= '/page-' . $page;
        }
        $base_url_rewrite = nv_url_rewrite($base_url_rewrite, true);
        if ($_SERVER['REQUEST_URI'] != $base_url_rewrite and NV_MAIN_DOMAIN . $_SERVER['REQUEST_URI'] != $base_url_rewrite) {
            Header('Location: ' . $base_url_rewrite);
            die();
        }

        $array_mod_title[] = array(
            'catid' => 0,
            'title' => $page_title,
            'link' => $base_url
        );

        $db->sqlreset()
            ->select('COUNT(*)')
            ->from(NV_PREFIXLANG . '_' . $module_data . '_rows t1')
            ->join('INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_block t2 ON t1.id = t2.id')
            ->where('t2.bid= ' . $bid . ' AND (t2.exptime = 0 OR t2.exptime >= ' . NV_CURRENTTIME . ') AND status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ')')
            ->where('status=1 AND t2.bid= ' . $bid);

        $all_page = $db->query($db->sql())
            ->fetchColumn();

        $db->select('t1.id, title, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, unitid, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groups_config')
            ->order('t1.prior DESC, t1.ordertime DESC')
            ->limit($per_page)
            ->offset(($page - 1) * $per_page);

        $sth = $db->prepare($db->sql());
        $sth->execute();

        while ($row = $sth->fetch()) {
            //         lưu tin
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
            //         lưu tin
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
                                            $row_field['icon'] = $row_field['icon'];
                                        } else {
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
        }
        if (!empty($array_field_config)) {
            $result = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_info WHERE rowid IN (" . implode(',', array_keys($array_data)) . ")");
            while ($custom_fields = $result->fetch()) {
                foreach ($array_field_config as $row) {
                    $row['show_locations'] = explode(',', $row['show_locations']);
                    if (in_array(8, $row['show_locations'])) {

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

        if (!empty($image_group) and file_exists(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $image_group)) {
            $image_group = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $image_group;
            $meta_property['og:image'] = NV_MY_DOMAIN . $image_group;
        }

        $groups_data = array(
            'title' => $page_title,
            'image' => $image_group,
            'description' => $description
        );

        $generate_page = nv_alias_page($page_title, $base_url, $all_page, $per_page, $page);

        $contents = nv_theme_market_viewgroup($groups_data, $array_data, $array_config['style_default'], $generate_page);
    }
} else {
    Header('Location: ' . nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name, true));
    die();
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';