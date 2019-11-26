<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2015 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Wed, 02 Dec 2015 08:26:04 GMT
 */
define('NV_SYSTEM', true);
define('NV_MARKET_CRAWLER', true);

// Xac dinh thu muc goc cua site
define('NV_ROOTDIR', pathinfo(str_replace(DIRECTORY_SEPARATOR, '/', __file__), PATHINFO_DIRNAME));

require NV_ROOTDIR . '/includes/mainfile.php';
require NV_ROOTDIR . '/includes/core/user_functions.php';
$site_mods = nv_site_mods();

// Duyệt tất cả các ngôn ngữ
$language_query = $db->query('SELECT lang FROM ' . $db_config['prefix'] . '_setup_language WHERE setup = 1');
while (list ($lang) = $language_query->fetch(3)) {
    $mquery = $db->query("SELECT title, module_data, module_file, module_upload FROM " . $db_config['prefix'] . "_" . $lang . "_modules WHERE module_file = 'market'");
    while (list ($module_name, $module_data, $module_file, $module_upload) = $mquery->fetch(3)) {
        require_once NV_ROOTDIR . '/modules/' . $module_file . '/site.functions.php';
        require_once NV_ROOTDIR . '/modules/' . $module_file . '/crawler.functions.php';
        require_once NV_ROOTDIR . '/modules/' . $module_file . '/language/admin_' . NV_LANG_DATA . '.php';
        $result = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items WHERE status=1 AND autotime > 0 AND ' . NV_CURRENTTIME . '-lasttime >= autotime * 60');
        while (list ($itemid) = $result->fetch(3)) {
            nv_autoget_listnews($itemid, $module_name, 1);
        }
    }
}