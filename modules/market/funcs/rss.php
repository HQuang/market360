<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Apr 20, 2010 10:47:41 AM
 */
if (!defined('NV_IS_MOD_MARKET')) {
    die('Stop!!!');
}

$channel = array();
$items = array();

$channel['title'] = $module_info['custom_title'];
$channel['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name;
$channel['description'] = !empty($module_info['description']) ? $module_info['description'] : $global_config['site_description'];

$catid = 0;
if (isset($array_op[1])) {
    $alias_cat_url = $array_op[1];
    $cattitle = '';
    foreach ($array_market_cat as $catid_i => $array_cat_i) {
        if ($alias_cat_url == $array_cat_i['alias']) {
            $catid = $catid_i;
            break;
        }
    }
}

$db_slave->sqlreset()
    ->select('id, catid, addtime, title, alias, description, homeimgthumb, homeimgfile')
    ->order('addtime DESC')
    ->limit(30);

if (!empty($catid)) {
    $channel['title'] = $module_info['custom_title'] . ' - ' . $array_market_cat[$catid]['title'];
    $channel['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $alias_cat_url;
    $channel['description'] = $array_market_cat[$catid]['description'];
    $db_slave->from(NV_PREFIXLANG . '_' . $module_data . '_rows')->where('catid=' . $catid . ' AND status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ')');
} else {
    $db_slave->from(NV_PREFIXLANG . '_' . $module_data . '_rows')->where('status=1 AND status_admin=1 AND is_queue=0 AND (exptime=0 OR exptime >= ' . NV_CURRENTTIME . ')');
}
if ($module_info['rss']) {
    $result = $db_slave->query($db_slave->sql());
    while (list ($id, $catid_i, $addtime, $title, $alias, $description, $homeimgthumb, $homeimgfile) = $result->fetch(3)) {
        $catalias = $array_market_cat[$catid_i]['alias'];

        if ($homeimgthumb == 1) {
            // image thumb
            $rimages = NV_MY_DOMAIN . NV_BASE_SITEURL . NV_FILES_DIR . '/' . $module_upload . '/' . $homeimgfile;
        } elseif ($homeimgthumb == 2) {
            // image file
            $rimages = NV_MY_DOMAIN . NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $homeimgfile;
        } elseif ($homeimgthumb == 3) {
            // image url
            $rimages = $homeimgfile;
        } else {
            // no image
            $rimages = '';
        }
        $rimages = (!empty($rimages)) ? '<img src="' . $rimages . '" width="100" align="left" border="0">' : '';

        $items[] = array(
            'title' => $title,
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $catalias . '/' . $alias . '-' . $id . $global_config['rewrite_exturl'], //
            'guid' => $module_name . '_' . $id,
            'description' => $rimages . $description,
            'pubdate' => $addtime
        );
    }
}
nv_rss_generate($channel, $items);
die();