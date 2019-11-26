<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2015 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 24 Oct 2015 01:59:22 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) die('Stop!!!');

if ($nv_Request->isset_request('change_status', 'post, get')) {
    $id = $nv_Request->get_int('id', 'post, get', 0);
    $listid = $nv_Request->get_title('listid', 'post, get', '');
    $action = $nv_Request->get_title('action', 'post, get', '');

    $content = '';

    if ($id > 0) {
        if ($action == 'acept') {
            require_once NV_ROOTDIR . '/modules/market/crawler.functions.php';
            $nv_autoget_detail = nv_autoget_detail($id);
            if (empty($nv_autoget_detail)) {
                $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows SET applytime=' . NV_CURRENTTIME . ', applyuserid=' . $admin_info['userid'] . ', status=1 WHERE id=' . $id);
                $content = 'OK_' . $id;
            }
        } elseif ($action == 'break') {
            $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows SET applyuserid=' . $admin_info['userid'] . ', status=2 WHERE id=' . $id);
            $content = 'OK_' . $id;
        }
    } elseif (!empty($listid)) {
        $listid = explode(',', $listid);
        if (!empty($listid)) {
            foreach ($listid as $id) {
                if ($action == 'acept') {
                    require_once NV_ROOTDIR . '/modules/market/crawler.functions.php';
                    $nv_autoget_detail = nv_autoget_detail($id);
                    if (empty($nv_autoget_detail)) {
                        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows SET applytime=' . NV_CURRENTTIME . ', applyuserid=' . $admin_info['userid'] . ', status=1 WHERE id=' . $id);
                    }
                } elseif ($action == 'break') {
                    $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows SET applyuserid=' . $admin_info['userid'] . ', status=2 WHERE id=' . $id . ' AND status=0');
                }
            }
        }
        $content = 'OK_' . json_encode($listid);
    }

    $content = !empty($content) ? $content : 'NO_' . $nv_autoget_detail;

    $nv_Cache->delMod($module_name);
    include NV_ROOTDIR . '/includes/header.php';
    echo $content;
    include NV_ROOTDIR . '/includes/footer.php';
    exit();
}

if ($nv_Request->isset_request('delete_list', 'post')) {
    $listall = $nv_Request->get_title('listall', 'post', '');
    $array_id = explode(',', $listall);

    if (!empty($array_id)) {
        foreach ($array_id as $id) {
            nv_crawler_delete_rows($id);
        }
        $nv_Cache->delMod($module_name);
        die('OK');
    }
    die('NO');
}

$row = array();
$error = array();
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=crawler';
$where = '';

$array_search = array(
    'q' => $nv_Request->get_title('q', 'get', ''),
    'groups_id' => $nv_Request->get_int('groups_id', 'get', 0),
    'status' => $nv_Request->get_int('status', 'get', -1),
    'per_page' => $nv_Request->get_int('per_page', 'get', 15)
);

$per_page = $array_search['per_page'];
$page = $nv_Request->get_int('page', 'post,get', 1);
$db->sqlreset()
    ->select('COUNT(*)')
    ->from(NV_PREFIXLANG . '_' . $module_data . '_crawler_rows t1');

if (!empty($array_search['q'])) {
    $base_url .= '&q=' . $array_search['q'];
    $where .= ' AND (t1.title LIKE "%' . $array_search['q'] . '%" OR t1.url LIKE "%' . $array_search['q'] . '%" OR t1.url_md5 LIKE "%' . $array_search['q'] . '%") ';
}

if (!empty($array_search['groups_id'])) {
    $db->join('INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items t2 ON t1.items_id=t2.id');
    $base_url .= '&groups_id=' . $array_search['groups_id'];
    $where .= ' AND t2.groups_id=' . $array_search['groups_id'];
}

if ($array_search['status'] >= 0) {
    $base_url .= '&status=' . $array_search['status'];
    $where .= ' AND t1.status=' . $array_search['status'];
}
$base_url .= '&per_page=' . $array_search['per_page'];

$where = !empty($where) ? $where : ' AND status!=2';

if (!empty($where)) {
    $db->where('1=1' . $where);
}

$sth = $db->prepare($db->sql());

if (!empty($array_search['q'])) {
    $sth->bindValue(':q_title', '%' . $array_search['q'] . '%');
}
$sth->execute();
$num_items = $sth->fetchColumn();

$db->select('t1.*')
    ->order('t1.id DESC')
    ->limit($per_page)
    ->offset(($page - 1) * $per_page);
$sth = $db->prepare($db->sql());

if (!empty($array_search['q'])) {
    $sth->bindValue(':q_title', '%' . $array_search['q'] . '%');
}
$sth->execute();

$_sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups ORDER BY weight';
$array_crawler_groups = $nv_Cache->db($_sql, 'id', $module_name);

$xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('MODULE_UPLOAD', $module_upload);
$xtpl->assign('OP', $op);
$xtpl->assign('ROW', $row);
$xtpl->assign('SEARCH', $array_search);
$xtpl->assign('BASE_URL', $base_url);

$generate_page = nv_generate_page($base_url, $num_items, $per_page, $page);
if (!empty($generate_page)) {
    $xtpl->assign('NV_GENERATE_PAGE', $generate_page);
    $xtpl->parse('main.generate_page');
}
$number = $page > 1 ? ($per_page * ($page - 1)) + 1 : 1;
while ($view = $sth->fetch()) {
    list ($view['groups_title'], $view['groups_url']) = $db->query('SELECT title, url FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups WHERE id=(SELECT groups_id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items WHERE id=' . $view['items_id'] . ')')->fetch(3);
    $view['addtime'] = nv_date('H:i d/m/Y', $view['addtime']);
    $view['status_str'] = $lang_module['status_' . $view['status']];

    $xtpl->assign('VIEW', $view);

    if ($view['status'] == 0) {
        $xtpl->parse('main.loop.break');
        $xtpl->parse('main.loop.acept');
        $xtpl->parse('main.loop.warning');
    } elseif ($view['status'] == 2) {
        $xtpl->parse('main.loop.acept');
        $xtpl->parse('main.loop.success');
    } else {
        $xtpl->parse('main.loop.break');
    }

    $xtpl->parse('main.loop');
}

if (!empty($array_crawler_groups)) {
    foreach ($array_crawler_groups as $groups) {
        $groups['selected'] = $groups['id'] == $array_search['groups_id'] ? 'selected="selected"' : '';
        $xtpl->assign('GROUPS', $groups);
        $xtpl->parse('main.groups');
    }
}

$array_status = array(
    '0' => $lang_module['status_0'],
    '1' => $lang_module['status_1'],
    '2' => $lang_module['status_2']
);
foreach ($array_status as $key => $value) {
    $sl = $key == $array_search['status'] ? 'selected="selected"' : '';
    $xtpl->assign('STATUS', array(
        'key' => $key,
        'value' => $value,
        'selected' => $sl
    ));
    $xtpl->parse('main.status');
}

for ($i = 10; $i <= 100; $i += 5) {
    $sl = $array_search['per_page'] == $i ? 'selected="selected"' : '';
    $xtpl->assign('PER_PAGE', array(
        'key' => $i,
        'selected' => $sl
    ));
    $xtpl->parse('main.per_page');
}

$array_action = array(
    'acept' => $lang_module['action_acept'],
    'break' => $lang_module['action_break'],
    'delete_list_id' => $lang_global['delete']
);
foreach ($array_action as $key => $value) {
    $xtpl->assign('ACTION', array(
        'key' => $key,
        'value' => $value
    ));
    $xtpl->parse('main.action_top');
    $xtpl->parse('main.action_bottom');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

$page_title = $lang_module['container_list'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
