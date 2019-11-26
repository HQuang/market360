<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 10 Dec 2011 06:46:54 GMT
 */
if (! defined('NV_MAINFILE')) {
    die('Stop!!!');
}

if (! nv_function_exists('nv_theme_news_cat_style')) {

    if (! nv_function_exists('nv_resize_crop_images')) {

        function nv_resize_crop_images($img_path, $width, $height, $module_name = '', $id = 0)
        {
            $new_img_path = str_replace(NV_ROOTDIR, '', $img_path);
            if (file_exists($img_path)) {
                $imginfo = nv_is_image($img_path);
                $basename = basename($img_path);
                $basename = preg_replace('/^\W+|\W+$/', '', $basename);
                $basename = preg_replace('/[ ]+/', '_', $basename);
                $basename = strtolower(preg_replace('/\W-/', '', $basename));
                if ($imginfo['width'] > $width or $imginfo['height'] > $height) {
                    $basename = preg_replace('/(.*)(\.[a-zA-Z]+)$/', $module_name . '_' . $id . '_\1_' . $width . '-' . $height . '\2', $basename);
                    if (file_exists(NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . $basename)) {
                        $new_img_path = NV_BASE_SITEURL . NV_TEMP_DIR . '/' . $basename;
                    } else {
                        $img_path = new NukeViet\Files\Image($img_path, NV_MAX_WIDTH, NV_MAX_HEIGHT);

                        $thumb_width = $width;
                        $thumb_height = $height;
                        $maxwh = max($thumb_width, $thumb_height);
                        if ($img_path->fileinfo['width'] > $img_path->fileinfo['height']) {
                            $width = 0;
                            $height = $maxwh;
                        } else {
                            $width = $maxwh;
                            $height = 0;
                        }

                        $img_path->resizeXY($width, $height);
                        $img_path->cropFromCenter($thumb_width, $thumb_height);
                        $img_path->save(NV_ROOTDIR . '/' . NV_TEMP_DIR, $basename);
                        if (file_exists(NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . $basename)) {
                            $new_img_path = NV_BASE_SITEURL . NV_TEMP_DIR . '/' . $basename;
                        }
                    }
                }
            }
            return $new_img_path;
        }
    }

    function nv_theme_ini_news_cat_style($module, $data_block, $lang_block)
    {
        global $nv_Cache, $site_mods, $db_config, $global_config;

        $array_style = array(
            'mainleft' => $lang_block['style_1'],
            'maintop' => $lang_block['style_0']
        );

        $module = $data_block['module_name'];

        $sql = "SELECT title, module_data, custom_title FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_modules WHERE module_file = 'news'";
        $list = $nv_Cache->db($sql, 'title', $module);

        $array_cat = array();
        foreach ($list as $mod) {
            $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $mod['module_data'] . '_cat ORDER BY sort ASC';
            $array_cat[$mod['title']] = $nv_Cache->db($sql, '', $module);
        }

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/theme_news_cat_style.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $array_style = array(
            'maintop' => $lang_block['style_0'],
            'mainleft' => $lang_block['style_1'],
        );

        $xtpl = new XTemplate('theme_news_cat_style.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('TEMPLATE', $block_theme);
        $xtpl->assign('BLOCK_TITLE', $block_config['title']);
        $xtpl->assign('DATA', $data_block);
        $xtpl->assign('LANG', $lang_block);

        if (! empty($list)) {
            foreach ($list as $mod) {
                $mod['selected'] = $data_block['module_name'] == $mod['title'] ? 'selected="selected"' : '';
                $xtpl->assign('MODULE', $mod);
                $xtpl->parse('config.loop');
            }
        }

        if (! empty($list)) {
            foreach ($list as $mod) {
                $xtpl->assign('MODULE', $mod);

                foreach ($array_cat[$mod['title']] as $cat) {
                    $cat['checked'] = in_array($cat['catid'], $data_block['catid']) ? 'checked="checked"' : '';
                    $xtpl->assign('CAT', $cat);
                    $xtpl->parse('config.module.cat_loop');
                }

                $xtpl->assign('HIDDEN', $data_block['module_name'] != $mod['title'] ? 'hidden' : '');

                $xtpl->parse('config.module');
            }
        }

        foreach ($array_style as $index => $value) {
            $xtpl->assign('STYLE', array(
                'index' => $index,
                'value' => $value,
                'selected' => $index == $data_block['style'] ? 'selected="selected"' : ''
            ));
            $xtpl->parse('config.style');
        }

        $xtpl->parse('config');
        return $xtpl->text('config');
    }

    function nv_theme_ini_news_cat_style_submit($module, $lang_block)
    {
        global $nv_Request;
        $return = array();
        $return['error'] = array();
        $return['config'] = array();
        $return['config']['module_name'] = $nv_Request->get_title('config_module_name', 'post', 'news');
        $return['config']['catid'] = $nv_Request->get_array('config_catid', 'post', array());
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 0);
        $return['config']['style'] = $nv_Request->get_title('config_style', 'post', 'mainleft');
        $return['config']['imagesize_w'] = $nv_Request->get_int('config_imagesize_w', 'post', 310);
        $return['config']['imagesize_h'] = $nv_Request->get_int('config_imagesize_h', 'post', 204);
        return $return;
    }

    function nv_theme_news_cat_style($block_config)
    {
        global $nv_Cache, $module_array_cat, $module_info, $site_mods, $module_config, $global_config, $db;

        $module = $block_config['module_name'];
        $show_no_image = $module_config[$module]['show_no_image'];
        $blockwidth = $module_config[$module]['blockwidth'];

        if (empty($block_config['catid'])) {
            return '';
        }

        $catid = implode(',', $block_config['catid']);

        $db->sqlreset()
            ->select('id, catid, title, alias, homeimgfile, homeimgthumb, hometext, publtime')
            ->from(NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows')
            ->where('status= 1 AND catid IN(' . $catid . ')')
            ->order('publtime DESC')
            ->limit($block_config['numrow']);
        $list = $nv_Cache->db($db->sql(), '', $module);
        if (! empty($list)) {
            if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/theme_news_cat_style.tpl')) {
                $block_theme = $global_config['module_theme'];
            } else {
                $block_theme = 'default';
            }

            $xtpl = new XTemplate('theme_news_cat_style.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
            $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
            $xtpl->assign('TEMPLATE', $block_theme);
            $xtpl->assign('BLOCK_TITLE', $block_config['title']);
            $xtpl->assign('MODULE_LINK', $module);

            $style = $block_config['style'];

            $i = 0;
            foreach ($list as $l) {

                $l['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module . '&amp;' . NV_OP_VARIABLE . '=' . $module_array_cat[$l['catid']]['alias'] . '/' . $l['alias'] . '-' . $l['id'] . $global_config['rewrite_exturl'];

                if ($i == 0) {
                    if (! empty($l['homeimgfile']) and file_exists(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $site_mods[$module]['module_upload'] . '/' . $l['homeimgfile'])) {
                        $l['thumb'] = nv_resize_crop_images(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $site_mods[$module]['module_upload'] . '/' . $l['homeimgfile'], $block_config['imagesize_w'], $block_config['imagesize_h'], $module);
                    } else {
                        $l['thumb'] = '';
                    }
                    $xtpl->assign('ROW', $l);

                    if (! empty($l['thumb'])) {
                        $xtpl->parse('main.' . $style . '.newsmain.image');
                    }

                    $xtpl->parse('main.' . $style . '.newsmain');
                } else {
                    if (! empty($l['homeimgfile']) and file_exists(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $site_mods[$module]['module_upload'] . '/' . $l['homeimgfile'])) {
                        $l['thumb'] =  NV_UPLOADS_DIR . '/' . $site_mods[$module]['module_upload'] . '/' . $l['homeimgfile'];
                    } else {
                        $l['thumb'] = '';
                    }
//                     var_dump($l);die;
                    $l['publtime'] = nv_date("H:i d/m/Y", $l['publtime']);
                    $xtpl->assign('ROW', $l);
                    $xtpl->parse('main.' . $style . '.newssub');
                }
                $i ++;
            }

            $xtpl->parse('main.' . $style);

            $xtpl->parse('main');
            return $xtpl->text('main');
        }
    }
}
if (defined('NV_SYSTEM')) {
    global $nv_Cache, $site_mods, $module_name, $global_array_cat, $module_array_cat;
    $module = $block_config['module_name'];
    if (isset($site_mods[$module])) {
        if ($module == $module_name) {
            $module_array_cat = $global_array_cat;
            unset($module_array_cat[0]);
        } else {
            $module_array_cat = array();
            $sql = 'SELECT catid, parentid, title, alias, viewcat, subcatid, numlinks, description, status , keywords, groups_view FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_cat ORDER BY sort ASC';
            $list = $nv_Cache->db($sql, 'catid', $module);
            if (! empty($list)) {
                foreach ($list as $l) {
                    $module_array_cat[$l['catid']] = $l;
                    $module_array_cat[$l['catid']]['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module . '&amp;' . NV_OP_VARIABLE . '=' . $l['alias'];
                }
            }
        }
        $content = nv_theme_news_cat_style($block_config);
    }
}
