<?php

/**
 * @Project NUKEVIET 4.x
 * @Author mynukeviet (contact@mynukeviet.net)
 * @Copyright (C) 2016 mynukeviet. All rights reserved
 * @Createdate Sun, 20 Nov 2016 07:31:04 GMT
 */
if (!defined('NV_ADMIN')) die('Stop!!!');

$submenu['content'] = $lang_module['content_add'];
$submenu['queue'] = $lang_module['queue'];
$submenu['auction'] = $lang_module['auction_list'];
$submenu['news'] = $lang_module['news'];
$submenu['groups'] = $lang_module['groups'];
$submenu['cat'] = $lang_module['cat'];
$submenu['unit'] = $lang_module['unit'];
$submenu['type'] = $lang_module['type'];
$submenu['post-type'] = $lang_module['post_type'];
$submenu['tags'] = $lang_module['tags'];
$submenu['reason'] = $lang_module['reason'];
$submenu['freelance'] = $lang_module['freelance'];
$submenu['econtent'] = $lang_module['econtent'];
$submenu['template'] = $lang_module['custom_fields'];
$menu_setting = array(
    'crawler-source' => $lang_module['crawler_source'],
    'crawler-groups' => $lang_module['crawler_groups']
);
$submenu['crawler'] = array(
    'title' => $lang_module['crawler'],
    'submenu' => $menu_setting
);
$submenu['widget'] = $lang_module['widget'];
$submenu['facilities'] = $lang_module['facilities'];
$submenu['packages'] = $lang_module['packages'];
$submenu['package-websites'] = $lang_module['package-websites'];
$submenu['config'] = $lang_module['config'];