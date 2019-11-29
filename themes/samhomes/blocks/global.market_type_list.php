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

if (!nv_function_exists('nv_block_market_type_list')) {

    function nv_block_config_market_type_list($module, $data_block, $lang_block)
    {
        global $db_config, $nv_Cache, $site_mods;
        $module = 'market';
        $array_template = array(
            '0' => $lang_block['template_0'],
            '1' => $lang_block['template_1']
        );
        $html_input = '';
        $html = '';

        $html = '<tr>';
        $html .= '<td>' . $lang_block['typeid'] . ':</td>';

        $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_type';
        $list = $nv_Cache->db($sql, '', $module);

        if (!is_array($data_block['typeid'])) {
            $data_block['typeid'] = array(
                $data_block['typeid']
            );
        }

        $html .= '<td>';
        foreach ($list as $type) {
            if ($type['status'] == 1) {
                $html .= '<label><input type="checkbox" name="config_typeid[]" value="' . $type['id'] . '" ' . ((in_array($type['id'], $data_block['typeid'])) ? ' checked="checked"' : '') . '</input>' . $type['title'] . '</label><br />';
            }
        }
        $html .= '</td>';
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

    function nv_block_config_market_type_list_submit($module, $lang_block)
    {
        global $nv_Request;
        $return = array();
        $return['error'] = array();
        $return['config'] = array();
        $return['config']['typeid'] = $nv_Request->get_array('config_typeid', 'post', array());
        $return['config']['template'] = $nv_Request->get_int('config_template', 'post', 0);
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 0);
        $return['config']['title_lenght'] = $nv_Request->get_int('config_title_lenght', 'post', 0);
        return $return;
    }

    function nv_block_market_type_list($block_config)
    {
        global $db_config, $lang_module, $module_array_cat, $array_market_cat, $module_info, $site_mods, $module_config, $global_config, $nv_Cache, $db, $module_name, $module_data, $module_file, $module_upload, $my_head;

        $module = 'market';
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

        $template = 'market_type_1.tpl';
        if ($block_config['template'] == 1) {
            $template = 'market_type_2.tpl';
        }

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/' . $template)) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/' . $template)) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        if ($module != $module_name) {
            $my_head .= '<link rel="StyleSheet" href="' . NV_BASE_SITEURL . 'themes/' . $block_theme . '/css/market.css' . '">';
        }

        $typeid = implode(',', $block_config['typeid']);

        $xtpl = new XTemplate($template, NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('LANG', $lang_module);
        $xtpl->assign('TEMPLATE', $block_theme);
        $xtpl->assign('BLOCK_TITLE', $block_config['title']);
        $home_image_size = explode('x', $array_config['home_image_size']);
        $xtpl->assign('WIDTH', $home_image_size[0]);
        $xtpl->assign('HEIGHT', $home_image_size[1]);

        $n = 0;
        $db->sqlreset()
            ->select('*')
            ->from(NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_type')
            ->where('id IN (' . $typeid . ')');
        $list_type = $nv_Cache->db($db->sql(), '', $module);

        foreach ($list_type as $type) {
            $n++;
            if ($n == 1) {
                $xtpl->assign('active', 'active');
            } else {
                $xtpl->assign('active', '');
            }
            $xtpl->assign('STT', $n);
            $xtpl->assign('GROUP_TITLE', $type);
            $xtpl->parse('main.group_title');
            require_once NV_ROOTDIR . '/modules/location/location.class.php';
            $location = new Location();

            $db->sqlreset()
                ->select('t1.id, t1.title, t1.description, t1.alias, t1.catid, t1.area_p, t1.area_d, t1.typeid, t1.pricetype, t1.price, t1.price1, t1.unitid, t1.homeimgfile, t1.homeimgalt, t1.homeimgthumb, t1.countview, t1.countcomment, t1.groupview, t1.addtime, t1.auction, t1.auction_begin, t1.auction_end, t1.auction_price_begin, t1.auction_price_step, t1.groups_config')
                ->from(NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows t1')
                ->join('INNER JOIN ' . $db_config['prefix'] . '_vi_market_type t2 ON t2.id = t1.typeid')
                ->where('t2.id= ' . $type['id'] . ' ')
                ->order('ordertime DESC')
                ->limit($block_config['numrow']);

            $list = $nv_Cache->db($db->sql(), '', $module);

            if (!empty($list)) {
                foreach ($list as $l) {
                    if (nv_user_in_groups($l['groupview'])) {
                        if (!empty($data = nv_market_data($l, $module))) {
                            $data['location'] = $location->locationString($data['area_p'], $data['area_d'], $data['area_w'], ' » ');
                            $data['location_link'] = nv_market_build_search_url($module_name, $data['typeid'], $data['catid'], $data['area_p'], $data['area_d'], $data['area_w']);
                            $lang_module['price'] = $lang_module['pricetype_cat_title_' . $array_market_cat[$l['catid']]['pricetype']];
                            $xtpl->assign('LANG', $lang_module);
                            $xtpl->assign('ROW', $data);

                            if (!empty($data['color'])) {
                                $xtpl->parse('main.group_content.loop.color');
                            }

                            if (!is_array($list_type['id'])) {
                                $list_type[$type['id']]['alias'] = NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module . "&amp;" . NV_OP_VARIABLE . "=" . $type['alias'];
                                $list_type[$type['id']] = $type;
                                $xtpl->assign('CAT', $list_type[$type['id']]);
                            }

                            $xtpl->parse('main.group_content.loop');
                        }
                    }
                }

                $xtpl->parse('main.group_content');
            }
        }
        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}
if (defined('NV_SYSTEM')) {
    global $site_mods, $module_name, $array_market_cat, $module_array_cat, $nv_Cache, $db;

    $module = 'market';

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
        $content = nv_block_market_type_list($block_config);
    }
}