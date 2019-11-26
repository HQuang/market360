<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2015 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 20 Oct 2015 14:31:37 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) die('Stop!!!');

if ($nv_Request->isset_request('check_type', 'post')) {
    $groupid = $nv_Request->get_int('groupid', 'post', 0);

    if (empty($groupid)) {
        die('NO_' . $lang_module['error_required_groupid']);
    }

    $type = $db->query('SELECT type FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups WHERE id=' . $groupid);
    if ($type->rowCount() > 0) {
        die('OK_' . $type->fetchColumn());
    }

    die('NO_' . $lang_module['error_required_groupid']);
}

$row = array();
$error = array();
$row['id'] = $nv_Request->get_int('id', 'post,get', 0);

if ($row['id'] > 0) {
    $row = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items WHERE id=' . $row['id'])->fetch();
    if (empty($row)) {
        Header('Location: ' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        die();
    }
    $lang_module['items_add'] = $lang_module['items_edit'];
    $row['is_edit'] = 1;
} else {
    $row['id'] = 0;
    $row['title'] = '';
    $row['url'] = '';
    $row['groups_id'] = 0;
    $row['typeid'] = 0;
    $row['catid'] = 0;
    $row['queue'] = 1;
    $row['save_image'] = 1;
    $row['auto_getkeyword'] = 1;
    $row['auto_keyword'] = 0;
    $row['save_limit'] = 5;
    $row['auto_homeimage'] = 1;
    $row['remove_link'] = 1;
    $row['autolink'] = 0;
    $row['addtime'] = 0;
    $row['updatetime'] = 0;
    $row['status'] = 1;
    $row['is_edit'] = 0;
    $row['typeid'] = 1;
    $row['area_p'] = 0;
    $row['area_d'] = 0;
}

if ($nv_Request->isset_request('submit', 'post')) {
    $row['title'] = $nv_Request->get_title('title', 'post', '');
    $row['url'] = $nv_Request->get_title('url', 'post', '');
    $row['groups_id'] = $nv_Request->get_int('groups_id', 'post', 0);
    $row['typeid'] = $nv_Request->get_int('typeid', 'post', 0);
    $row['catid'] = $nv_Request->get_int('catid', 'post', 0);
    $row['area_p'] = $nv_Request->get_int('area_p', 'post', 0);
    $row['area_d'] = $nv_Request->get_int('area_d', 'post', 0);
    $row['queue'] = $nv_Request->get_int('queue', 'post', 0);
    $row['save_image'] = $nv_Request->get_int('save_image', 'post', 0);
    $row['auto_getkeyword'] = $nv_Request->get_int('auto_getkeyword', 'post', 0);
    $row['auto_keyword'] = $nv_Request->get_int('auto_keyword', 'post', 0);
    $row['save_limit'] = $nv_Request->get_int('save_limit', 'post', 0);
    $row['auto_homeimage'] = $nv_Request->get_int('auto_homeimage', 'post', 0);
    $row['remove_link'] = $nv_Request->get_int('remove_link', 'post', 0);
    $row['autolink'] = $nv_Request->get_int('autolink', 'post', 0);
    $row['addtime'] = $nv_Request->get_int('addtime', 'post', 0);
    $row['updatetime'] = $nv_Request->get_int('updatetime', 'post', 0);
    $row['status'] = $nv_Request->get_int('status', 'post', 0);
    $row['typeid'] = $nv_Request->get_int('typeid', 'post', 0);

    if (empty($row['title'])) {
        $error[] = $lang_module['error_required_title'];
    } elseif (empty($row['url'])) {
        $error[] = $lang_module['error_required_url'];
    } elseif (empty($row['typeid'])) {
        $error[] = $lang_module['error_required_typeid'];
    } elseif (empty($row['catid'])) {
        $error[] = $lang_module['error_required_catid'];
    } elseif ($row['typeid'] == 0) {
        $getContent = new NukeViet\Client\UrlGetContents($global_config);
        $xml_source = $getContent->get($row['url']);
        if (!simplexml_load_string($xml_source)) {
            $error[] = $lang_module['error_vaild_rss'];
        }
    }

    if (empty($error)) {
        try {
            if (empty($row['id'])) {
                $data_insert = array();
                $_sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items (title, url, groups_id, typeid, catid, area_p, area_d, queue, save_image, auto_getkeyword, auto_keyword, save_limit, auto_homeimage, remove_link, autolink, addtime, updatetime, status) VALUES (:title, :url, :groups_id, :typeid, :catid, :area_p, :area_d, :queue, :save_image, :auto_getkeyword, :auto_keyword, :save_limit, :auto_homeimage, :remove_link, :autolink, ' . NV_CURRENTTIME . ', 0, 1)';
                $data_insert['title'] = $row['title'];
                $data_insert['url'] = $row['url'];
                $data_insert['groups_id'] = $row['groups_id'];
                $data_insert['typeid'] = $row['typeid'];
                $data_insert['catid'] = $row['catid'];
                $data_insert['area_p'] = $row['area_p'];
                $data_insert['area_d'] = $row['area_d'];
                $data_insert['queue'] = $row['queue'];
                $data_insert['save_image'] = $row['save_image'];
                $data_insert['auto_getkeyword'] = $row['auto_getkeyword'];
                $data_insert['auto_keyword'] = $row['auto_keyword'];
                $data_insert['save_limit'] = $row['save_limit'];
                $data_insert['auto_homeimage'] = $row['auto_homeimage'];
                $data_insert['remove_link'] = $row['remove_link'];
                $data_insert['autolink'] = $row['autolink'];
                $new_id = $db->insert_id($_sql, 'id', $data_insert);
            } else {
                $stmt = $db->prepare('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items SET title = :title, url = :url, groups_id = :groups_id, typeid = :typeid, catid = :catid, area_p = :area_p, area_d = :area_d, queue = :queue, save_image = :save_image, auto_getkeyword = :auto_getkeyword, auto_keyword = :auto_keyword, save_limit = :save_limit, auto_homeimage = :auto_homeimage, remove_link = :remove_link, autolink = :autolink, updatetime = ' . NV_CURRENTTIME . ' WHERE id=' . $row['id']);
                $stmt->bindParam(':title', $row['title'], PDO::PARAM_STR);
                $stmt->bindParam(':url', $row['url'], PDO::PARAM_STR);
                $stmt->bindParam(':groups_id', $row['groups_id'], PDO::PARAM_INT);
                $stmt->bindParam(':typeid', $row['typeid'], PDO::PARAM_INT);
                $stmt->bindParam(':catid', $row['catid'], PDO::PARAM_INT);
                $stmt->bindParam(':area_p', $row['area_p'], PDO::PARAM_INT);
                $stmt->bindParam(':area_d', $row['area_d'], PDO::PARAM_INT);
                $stmt->bindParam(':queue', $row['queue'], PDO::PARAM_INT);
                $stmt->bindParam(':save_image', $row['save_image'], PDO::PARAM_INT);
                $stmt->bindParam(':auto_getkeyword', $row['auto_getkeyword'], PDO::PARAM_INT);
                $stmt->bindParam(':auto_keyword', $row['auto_keyword'], PDO::PARAM_INT);
                $stmt->bindParam(':save_limit', $row['save_limit'], PDO::PARAM_INT);
                $stmt->bindParam(':auto_homeimage', $row['auto_homeimage'], PDO::PARAM_INT);
                $stmt->bindParam(':remove_link', $row['remove_link'], PDO::PARAM_INT);
                $stmt->bindParam(':autolink', $row['autolink'], PDO::PARAM_INT);
                if ($stmt->execute()) {
                    $new_id = $row['id'];
                }
            }
            if ($new_id > 0) {
                $nv_Cache->delMod($module_name);
                Header('Location: ' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=crawler-source');
                die();
            }
        } catch (PDOException $e) {
            trigger_error($e->getMessage());
        }
    }
}

$row['ck_queue'] = $row['queue'] ? 'checked="checked"' : '';
$row['ck_save_image'] = $row['save_image'] ? 'checked="checked"' : '';
$row['ck_auto_getkeyword'] = $row['auto_getkeyword'] ? 'checked="checked"' : '';
$row['ck_auto_keyword'] = $row['auto_keyword'] ? 'checked="checked"' : '';
$row['ck_auto_homeimage'] = $row['auto_homeimage'] ? 'checked="checked"' : '';
$row['ck_remove_link'] = $row['remove_link'] ? 'checked="checked"' : '';
$row['ck_autolink'] = $row['autolink'] ? 'checked="checked"' : '';

$_sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups ORDER BY weight';
$array_crawler_groups = $nv_Cache->db($_sql, 'id', $module_name);

$xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('ROW', $row);

if (!empty($array_crawler_groups)) {
    foreach ($array_crawler_groups as $groups) {
        $groups['selected'] = $groups['id'] == $row['groups_id'] ? 'selected="selected"' : '';
        $xtpl->assign('GROUPS', $groups);
        $xtpl->parse('main.groups');
    }
}

if (!empty($array_market_cat)) {
    foreach ($array_market_cat as $catid => $value) {
        $value['space'] = '';
        if ($value['lev'] > 0) {
            for ($i = 1; $i <= $value['lev']; $i++) {
                $value['space'] .= '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
            }
        }
        $value['selected'] = $catid == $row['catid'] ? ' selected="selected"' : '';

        $xtpl->assign('CAT', $value);
        $xtpl->parse('main.cat');
    }
}

if (!empty($array_type)) {
    $row['typeid'] = !empty($row['typeid']) ? $row['typeid'] : array_keys($array_type)[0];
    foreach ($array_type as $type) {
        $type['checked'] = $type['id'] == $row['typeid'] ? 'checked="checked"' : '';
        $xtpl->assign('TYPE', $type);
        $xtpl->parse('main.type');
    }
}

require_once NV_ROOTDIR . '/modules/location/location.class.php';
$location = new Location();
$location->set('SelectCountryid', $array_config['countryid']);
$location->set('IsDistrict', 1);
$location->set('BlankTitleProvince', 1);
$location->set('BlankTitleDistrict', 1);
$location->set('NameProvince', 'area_p');
$location->set('NameDistrict', 'area_d');
$location->set('SelectProvinceid', $row['area_p']);
$location->set('SelectDistrictid', $row['area_d']);
$xtpl->assign('LOCATION', $location->buildInput());

if (!empty($error)) {
    $xtpl->assign('ERROR', implode('<br />', $error));
    $xtpl->parse('main.error');
}

if (empty($array_config['keywords'])) {
    $xtpl->parse('main.autolink_disable');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

$page_title = $lang_module['items_add'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';