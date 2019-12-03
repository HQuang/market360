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

if (!nv_function_exists('nv_block_market_posttype')) {

    function nv_block_config_market_posttype($module, $data_block, $lang_block)
    {
        global $db_config, $nv_Cache, $site_mods;

        $html_input = '';

        $array_template = array(
            '0' => $lang_block['template_0'],
            '1' => $lang_block['template_1'],
            '2' => $lang_block['template_2'],
            '3' => $lang_block['template_3'],
            '4' => $lang_block['template_4'],
            '5' => $lang_block['template_5']

        );

        $html = '';
        $html .= '<tr>';
        $html .= '<td>' . $lang_block['blockid'] . '</td>';
        $html .= '<td><select name="config_blockid" class="form-control w200">';
        $html .= '<option value="0"> -- </option>';
        $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_post_type ORDER BY weight ASC';
        $list = $nv_Cache->db($sql, '', $module);
        foreach ($list as $l) {
//         die('1');
// var_dump($list);die;
            $html .= '<option value="' . $l['id'] . '" ' . (($data_block['blockid'] == $l['id']) ? ' selected="selected"' : '') . '>' . $l['title'] . '</option>';
        }
        $html .= '</select>';
        $html .= '</tr>';
        $html .= '<tr>';
        $html .= '<td>' . $lang_block['template'] . '</td>';
        $html .= '<td><select class="form-control w200" name="config_template">';
        foreach ($array_template as $index => $value) {
            $sl = $index == $data_block['template'] ? 'selected="selected"' : '';
            $html .= '<option value="' . $index . '" ' . $sl . ' >' . $value . '</option>';
        }
        $html .= '</select></td>';
        $html .= '</tr>';
        $html .= '<tr>';
        $html .= '<td>' . $lang_block['numrow'] . '</td>';
        $html .= '<td><input type="text" class="form-control w200" name="config_numrow" size="5" value="' . $data_block['numrow'] . '"/></td>';
        $html .= '</tr>';
        $html .= '<tr>';
        $html .= '<td>' . $lang_block['title_lenght'] . '</td>';
        $html .= '<td><input type="text" class="form-control w200" name="config_title_lenght" size="5" value="' . $data_block['title_lenght'] . '"/></td>';
        $html .= '</tr>';
        return $html;
    }

    function nv_block_config_market_posttype_submit($module, $lang_block)
    {
        global $nv_Request;
        $return = array();
        $return['error'] = array();
        $return['config'] = array();
        $return['config']['blockid'] = $nv_Request->get_int('config_blockid', 'post', 0);
        $return['config']['template'] = $nv_Request->get_int('config_template', 'post', 0);
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 0);
        $return['config']['title_lenght'] = $nv_Request->get_int('config_title_lenght', 'post', 0);
        return $return;
    }

    function nv_block_market_posttype($block_config)
    {
        global $db_config, $lang_module, $module_array_cat, $array_market_cat, $module_info, $site_mods, $module_config, $global_config, $nv_Cache, $db, $module_name, $module_data, $module_file, $module_upload, $my_head, $user_info;

        $module = $block_config['module'];
        $mod_data = $site_mods[$module]['module_data'];
        $mod_file = $site_mods[$module]['module_file'];
        $mod_upload = $site_mods[$module]['module_upload'];

        $array_config = $module_config[$module];

        if ($module != $module_name) {
            $array_market_cat = $module_array_cat;

            $module_name_tmp = $module_name;
            $module_data_tmp = $module_data;
            $module_file_tmp = $module_file;
            $module_upload_tmp = $module_upload;

            $module_name = $module;
            $module_data = $mod_data;
            $module_file = $mod_file;
            $module_upload = $mod_upload;

            require_once NV_ROOTDIR . '/modules/' . $mod_file . '/language/' . NV_LANG_INTERFACE . '.php';
            require_once NV_ROOTDIR . '/modules/' . $mod_file . '/site.functions.php';

            $module_name = $module_name_tmp;
            $module_data = $module_data_tmp;
            $module_file = $module_file_tmp;
            $module_upload = $module_upload_tmp;
        }
        $db->sqlreset()
            ->select('id, title, description, alias, catid, area_p, area_d, area_w, typeid, pricetype, price, price1, unitid, homeimgfile, homeimgalt, homeimgthumb, countview, countcomment, groupview, addtime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groups_config, post_type')
            ->from(NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows')
            ->where('post_type= ' . $block_config['blockid'] . ' AND status=1')
            ->order('ordertime DESC')
            ->limit($block_config['numrow']);

        $list = $nv_Cache->db($db->sql(), '', $module);

//             var_dump($list);die;
        if (!empty($list)) {


            $template = 'block_post_type_1.tpl';
            if ($block_config['template'] == 1) {
                $template = 'block_post_type_2.tpl';
            }
            if ($block_config['template'] == 2) {
                $template = 'block_post_type_3.tpl';
            }
            if ($block_config['template'] == 3) {
                $template = 'block_post_type_4.tpl';
            }
            if ($block_config['template'] == 4) {
                $template = 'block_post_type_5.tpl';
            }
            if ($block_config['template'] == 5) {
                $template = 'block_post_type_6.tpl';
            }

            if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/market/' . $template)) {
                $block_theme = $global_config['module_theme'];
            } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/market/' . $template)) {
                $block_theme = $global_config['site_theme'];
            } else {
                $block_theme = 'default';
            }


            if ($module != $module_name) {
                $my_head .= '<link rel="StyleSheet" href="' . NV_BASE_SITEURL . 'themes/' . $block_theme . '/css/market.css' . '">';
            }

            $xtpl = new XTemplate($template, NV_ROOTDIR . '/themes/' . $block_theme . '/modules/market');
            $xtpl->assign('LANG', $lang_module);
            $xtpl->assign('TEMPLATE', $block_theme);
            $xtpl->assign('BLOCK_TITLE', $block_config['title']);
            $home_image_size = explode('x', $array_config['home_image_size']);
            $xtpl->assign('WIDTH', $home_image_size[0]);
            $xtpl->assign('HEIGHT', $home_image_size[1]);



            require_once NV_ROOTDIR . '/modules/location/location.class.php';
            $location = new Location();

            foreach ($list as $l) {
                if (nv_user_in_groups($l['groupview'])) {
                    if (!empty($data = nv_market_data($l, $module))) {
                            $data['is_user'] = 0;

                            $data['style_save'] = $data['style_saved'] = '';
                            if (defined('NV_IS_USER')) {

                                $data['is_user'] = 1;
                                $count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_saved WHERE rowsid=' . $data['id'] . ' AND userid=' . $user_info['userid'])->fetchColumn();
                                if ($count) {
                                    $data['style_save'] = 'style="display: none"';
                                } else {
                                    $data['style_saved'] = 'style="display: none"';
                                }
                            } else {
                                $data['style_saved'] = 'style="display: none"';
                            }

                        $data['count_image'] = $db->query('SELECT  COUNT(path) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_images WHERE rowsid=' . $data['id'] )->fetchColumn();
                        $data['location'] = $location->locationString($data['area_p'], $data['area_d'], $data['area_w'], ' » ');
                        $data['location_link'] = nv_market_build_search_url($module_name, $data['typeid'], $data['catid'], $data['area_p'], $data['area_d'], $data['area_w']);
                        $lang_module['price'] = $lang_module['pricetype_cat_title_' . $array_market_cat[$l['catid']]['pricetype']];
                        $xtpl->assign('LANG', $lang_module);
                        $xtpl->assign('ROW', $data);

                        if (!empty($data['color'])) {
                            $xtpl->parse('main.loop.color');
                        }
                        if ($data['count_image'] > 1) {
                            $xtpl->parse('main.loop.count_image');
                        }
//                         if (!is_array($listcat[$block_config['blockid']])) {
//                             $listcat[$block_config['blockid']]['alias'] = NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module . "&amp;" . NV_OP_VARIABLE . "=" . $site_mods[$module]['alias']['groups'] . "/" . $cat['alias'];
//                             $listcat[$block_config['blockid']] = $cat;
//                             $xtpl->assign('BLOCKCAT', $listcat[$block_config['blockid']]);
//                         }

                        $xtpl->parse('main.loop');
                    }
                }
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
        $content = nv_block_market_posttype($block_config);
    }
}
