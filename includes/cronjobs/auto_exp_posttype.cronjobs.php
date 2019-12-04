<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2015 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Wed, 02 Dec 2015 08:26:04 GMT
 */
if (!defined('NV_MAINFILE') or !defined('NV_IS_CRON')) {
    die('Stop!!!');
}

/**
 * cron_auto_exp_posttype()
 *
 * @return
 */
function cron_auto_exp_posttype()
{
    global $db, $db_config, $nv_Cache;

// Duyệt tất cả các ngôn ngữ
    $language_query = $db->query('SELECT lang FROM ' . $db_config['prefix'] . '_setup_language WHERE setup = 1');
    while (list ($lang) = $language_query->fetch(3)) {
        $mquery = $db->query("SELECT title, module_data, module_file, module_upload FROM " . $db_config['prefix'] . "_" . $lang . "_modules WHERE module_file = 'market'");

        while (list ($module_name, $module_data, $module_file, $module_upload) = $mquery->fetch(3)) {
            require_once NV_ROOTDIR . '/modules/' . $module_file . '/site.functions.php';
            require_once NV_ROOTDIR . '/modules/' . $module_file . '/language/admin_' . NV_LANG_DATA . '.php';

            $_sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_post_type where status=1 order by weight ASC';
            $array_post_type = $nv_Cache->db($_sql, 'id', $module_name);

            $result = $db->query('SELECT id, exptime FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows WHERE status=1 AND autopost=0 AND exptime > 0 AND '.NV_CURRENTTIME.' > exptime ');
            while (list ($itemid, $exptime) = $result->fetch(3)) {
                $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_rows SET post_type=' . key($array_post_type));
            }

        }
    }

    return true;
}
