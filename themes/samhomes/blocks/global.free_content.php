<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 3/25/2010 18:6
 */
if (! defined('NV_MAINFILE')) {
    die('Stop!!!');
}

if (! nv_function_exists('nv_theme_block_freecontent')) {

    /**
     * nv_theme_block_config_freecontent()
     *
     * @param mixed $module
     * @param mixed $data_block
     * @param mixed $lang_block
     * @return
     */
    function nv_theme_block_config_freecontent($module, $data_block, $lang_block)
    {
        global $site_mods, $nv_Cache;

        $module = 'freecontent';

        $array_style = array(
            'high' => $lang_block['style_high'],
            'price' => $lang_block['style_price'],
            'monney' => $lang_block['style_monney'],
            'images' => $lang_block['style_images'],
            'customer' => $lang_block['style_customer'],
            'service' => $lang_block['style_service'],
            'detailcart' => $lang_block['style_detailcart'],
            'freecontent1' => $lang_block['style_freecontent1'],
            'freecontent2' => $lang_block['style_freecontent2'],
            'freecontent3' => $lang_block['style_freecontent3'],
            'freecontent4' => $lang_block['style_freecontent4'],
            'freecontent5' => $lang_block['style_freecontent5'],
            'freecontent6' => $lang_block['style_freecontent6'],
            'freecontent7' => $lang_block['style_freecontent7'],
            'freecontent8' => $lang_block['style_freecontent8'],
            'freecontent9' => $lang_block['style_freecontent9'],
            'freecontent10' => $lang_block['style_freecontent10'],
        );

        $html = '';
        $html .= '<tr>';
        $html .= '	<td>' . $lang_block['blockid'] . '</td>';
        $html .= '	<td>';
        $html .= '		<select name="config_blockid" class="form-control">';

        $sql = 'SELECT bid, title FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_blocks ORDER BY title ASC';
        $list = $nv_Cache->db($sql, '', $module);

        foreach ($list as $row) {
            $html .= '	<option value="' . $row['bid'] . '"' . ($row['bid'] == $data_block['blockid'] ? ' selected="selected"' : '') . '>' . $row['title'] . '</option>';
        }

        $html .= '		</select>';
        $html .= '	</td>';
        $html .= '</tr>';

        $html .= '<tr>';
        $html .= '	<td>' . $lang_block['numrows'] . '</td>';
        $html .= '	<td>';
        $html .= '		<select name="config_numrows" class="form-control">';

        for ($i = 1; $i <= 50; $i ++) {
            $html .= '	<option value="' . $i . '"' . ($i == $data_block['numrows'] ? ' selected="selected"' : '') . '>' . $i . '</option>';
        }

        $html .= '		</select>';
        $html .= '	</td>';
        $html .= '</tr>';

        $html .= '<tr>';
        $html .= '	<td>' . $lang_block['style'] . '</td>';
        $html .= '	<td>';
        $html .= '		<select name="config_style" class="form-control">';
        foreach ($array_style as $index => $value) {
            $sl = $index == $data_block['style'] ? 'selected="selelcted"' : '';
            $html .= '<option value="' . $index . '" ' . $sl . '>' . $value . '</option>';
        }
        $html .= '		</select>';
        $html .= '	</td>';
        $html .= '</tr>';

        return $html;
    }

    /**
     * nv_theme_block_config_freecontent_submit()
     *
     * @param mixed $module
     * @param mixed $lang_block
     * @return
     */
    function nv_theme_block_config_freecontent_submit($module, $lang_block)
    {
        global $nv_Request;
        $return = array();
        $return['error'] = array();
        $return['config'] = array();
        $return['config']['blockid'] = $nv_Request->get_int('config_blockid', 'post', 0);
        $return['config']['numrows'] = $nv_Request->get_int('config_numrows', 'post', 2);
        $return['config']['style'] = $nv_Request->get_title('config_style', 'post', 'price');
        return $return;
    }

    /**
     * nv_theme_block_freecontent()
     *
     * @return
     */
    function nv_theme_block_freecontent($block_config)
    {
        global $global_config, $site_mods, $module_config, $nv_Cache, $db;

        $module = 'freecontent';

        // Set content status
        if (! empty($module_config[$module]['next_execute']) and $module_config[$module]['next_execute'] <= NV_CURRENTTIME) {
            $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows SET status = 2 WHERE end_time > 0 AND end_time < ' . NV_CURRENTTIME;
            $db->query($sql);

            // Get next execute
            $sql = 'SELECT MIN(end_time) next_execute FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows WHERE end_time > 0 AND status = 1';
            $result = $db->query($sql);
            $next_execute = intval($result->fetchColumn());
            $sth = $db->prepare("UPDATE " . NV_CONFIG_GLOBALTABLE . " SET config_value = :config_value WHERE lang = '" . NV_LANG_DATA . "' AND module = :module_name AND config_name = 'next_execute'");
            $sth->bindParam(':module_name', $module, PDO::PARAM_STR);
            $sth->bindParam(':config_value', $next_execute, PDO::PARAM_STR);
            $sth->execute();

            $nv_Cache->delMod('settings');
            $nv_Cache->delMod($module);

            unset($next_execute);
        }

        if (! isset($site_mods[$module]) or empty($block_config['blockid'])) {
            return '';
        }

        $sql = 'SELECT id, title, description, image, link, target FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_rows WHERE status = 1 AND bid = ' . $block_config['blockid'];
        $list = $nv_Cache->db($sql, 'id', $module);

        $template = 'block.free_content_' . $block_config['style'] . '.tpl';

        if (! empty($list)) {
            if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/' . $template)) {
                $block_theme = $global_config['module_theme'];
            } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/' . $template)) {
                $block_theme = $global_config['site_theme'];
            } else {
                $block_theme = 'default';
            }

            $xtpl = new XTemplate($template, NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
            $xtpl->assign('TEMPLATE', $block_theme);
            $xtpl->assign('BLOCK_TITLE', $block_config['title']);

            if ($block_config['numrows'] <= sizeof($list)) {
                $list = array_slice($list, 0, $block_config['numrows']);
            }

            $i = 0;
            foreach ($list as $row) {
                if (! empty($row['image'])) {
                    $row['image'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $site_mods[$module]['module_upload'] . '/' . $row['image'];
                }

                $xtpl->assign('ROW', $row);

                if (! empty($row['link'])) {
                    if (! empty($row['target'])) {
                        $xtpl->parse('main.loop.title_link.target');
                    }

                    $xtpl->parse('main.loop.title_link');
                } else {
                    $xtpl->parse('main.loop.title_text');
                }

                if (! empty($row['image'])) {
                    if (! empty($row['link'])) {
                        if (! empty($row['target'])) {
                            $xtpl->parse('main.loop.image_link.target');
                        }

                        $xtpl->parse('main.loop.image_link');
                    } else {
                        $xtpl->parse('main.loop.image_only');
                    }
                }
                if($block_config['style'] == 'freecontent4'){
                    if($i == 0){
                        $xtpl->assign('active', 'active');
                    }else{
                        $xtpl->assign('active', '');
                    }
                    $xtpl->assign('index', $i);
                }
                if($block_config['style'] == 'freecontent2'){
                    if($i == 0){
                        $xtpl->assign('active', 'active');
                    }else{
                        $xtpl->assign('active', '');
                    }
                    $xtpl->assign('index', $i);
                }
                if($block_config['style'] == 'customer'){
                    if($i == 0){
                        $xtpl->assign('active', 'active');
                    }else{
                        $xtpl->assign('active', '');
                    }
                    $xtpl->assign('index', $i);
                }
                if($block_config['style'] == 'monney'){
                    if($i == 0){
                        $xtpl->assign('active', 'active');
                    }else{
                        $xtpl->assign('active', '');
                    }
                    $xtpl->assign('index', $i);
                }

                if($block_config['style'] == 'customer'){
                    if($i == 0){
                        $xtpl->assign('active', 'active');
                    }else{
                        $xtpl->assign('active', '');
                    }
                    $xtpl->assign('index', $i);
                }

                $xtpl->parse('main.loop');
                $xtpl->parse('main.button');
                $i++;
            }

            $xtpl->parse('main');
            return $xtpl->text('main');
        }

        return '';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_theme_block_freecontent($block_config);
}
