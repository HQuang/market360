<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2015 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 20 Oct 2015 14:31:20 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) die('Stop!!!');

$table_name = NV_PREFIXLANG . '_' . $module_data . '_crawler_items';

// change status
if ($nv_Request->isset_request('change_status', 'post, get')) {
    $id = $nv_Request->get_int('id', 'post, get', 0);
    $content = 'NO_' . $id;

    $query = 'SELECT status FROM ' . $table_name . ' WHERE id=' . $id;
    $row = $db->query($query)->fetch();
    if (isset($row['status'])) {
        $status = ($row['status']) ? 0 : 1;
        $query = 'UPDATE ' . $table_name . ' SET status=' . intval($status) . ' WHERE id=' . $id;
        $db->query($query);
        $content = 'OK_' . $id;
    }
    $nv_Cache->delMod($module_name);
    include NV_ROOTDIR . '/includes/header.php';
    echo $content;
    include NV_ROOTDIR . '/includes/footer.php';
    exit();
}

if ($nv_Request->isset_request('change_timer', 'post, get')) {
    $items_id = $nv_Request->get_int('items_id', 'post', 0);
    $new_vid = $nv_Request->get_int('new_vid', 'post', 0);
    $content = 'NO_' . $items_id;

    if ($items_id > 0) {
        $items_info = $db->query('SELECT * FROM ' . $table_name . ' WHERE id=' . $items_id)->fetch();
        if (!empty($items_info)) {
            $sql = 'UPDATE ' . $table_name . ' SET autotime=' . $new_vid . ' WHERE id=' . $items_id;
            $db->query($sql);
            $content = 'OK_' . $items_id;
        }
    }

    $nv_Cache->delMod($module_name);
    include NV_ROOTDIR . '/includes/header.php';
    echo $content;
    include NV_ROOTDIR . '/includes/footer.php';
    exit();
}

if ($nv_Request->isset_request('delete_id', 'get') and $nv_Request->isset_request('delete_checkss', 'get')) {
    $id = $nv_Request->get_int('delete_id', 'get');
    $delete_checkss = $nv_Request->get_string('delete_checkss', 'get');
    if ($id > 0 and $delete_checkss == md5($id . NV_CACHE_PREFIX . $client_info['session_id'])) {
        $count = $db->exec('DELETE FROM ' . $table_name . '  WHERE id = ' . $id);
        if ($count) {
            // Xóa tin tức
            //$db->query('DELETE FROM ' . $table_name . '_rows  WHERE items_id=' . $id);
        }
        $nv_Cache->delMod($module_name);
        Header('Location: ' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        die();
    }
} elseif ($nv_Request->isset_request('delete_list', 'post')) {
    $listall = $nv_Request->get_title('listall', 'post', '');
    $array_id = explode(',', $listall);

    if (!empty($array_id)) {
        foreach ($array_id as $id) {
            $count = $db->exec('DELETE FROM ' . $table_name . '  WHERE id = ' . $id);
            if ($result) {
                // Xóa tin tức
                // $db->query('DELETE FROM ' . $table_name . '_rows  WHERE items_id=' . $id);
            }
        }
        $nv_Cache->delMod($module_name);
        die('OK');
    }
    die('NO');
}

if ($nv_Request->isset_request('fetch', 'post, get')) {
    $id = $nv_Request->get_int('id', 'post, get', 0);
    $listid = $nv_Request->get_title('listid', 'post, get', '');
    $content = 'NO_' . $id;

    if ($id > 0) {
        require_once NV_ROOTDIR . '/modules/market/crawler.functions.php';
        $nv_autoget_listnews = nv_autoget_listnews($id);
        if ($nv_autoget_listnews['status']) {
            $array = array(
                'id' => $id,
                'num' => $nv_autoget_listnews['num'],
                'lasttime' => nv_date('H:i d/m/Y', $nv_autoget_listnews['lasttime']),
                'queue' => $nv_autoget_listnews['queue']
            );
            $content = 'OK_' . json_encode($array);
        }
    } elseif (!empty($listid)) {
        $num = 0;
        $listid = explode(',', $listid);
        if (!empty($listid)) {
            foreach ($listid as $id) {
                $nv_autoget_listnews = nv_autoget_listnews($id);
                $num += $nv_autoget_listnews['num'];
            }
            $content = 'OK_' . $num;
        }
    }

    $nv_Cache->delMod($module_name);
    include NV_ROOTDIR . '/includes/header.php';
    echo $content;
    include NV_ROOTDIR . '/includes/footer.php';
    exit();
}

$row = array();
$error = array();

$array_search = array(
    'q' => $nv_Request->get_string('q', 'get'),
    'module_name' => $nv_Request->get_string('module_name', 'get'),
    'catid' => $nv_Request->get_typed_array('catid', 'get', 'int')
);

$where = '';
$per_page = 20;
$page = $nv_Request->get_int('page', 'post,get', 1);
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op;

if (!empty($array_search['q'])) {
    $base_url .= '&q=' . $array_search['q'];
    $where .= ' AND (title LIKE "%' . $array_search['q'] . '%"
        OR url LIKE "%' . $array_search['q'] . '%"
    )';
}

$db->sqlreset()
    ->select('COUNT(*)')
    ->from($table_name)
    ->where('1=1' . $where);
$sth = $db->prepare($db->sql());

$sth->execute();
$num_items = $sth->fetchColumn();

$db->select('*')
    ->order('id DESC')
    ->limit($per_page)
    ->offset(($page - 1) * $per_page);
$sth = $db->prepare($db->sql());
$sth->execute();

$_sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups ORDER BY weight';
$array_crawler_groups = $nv_Cache->db($_sql, 'id', $module_name);

$xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('MODULE_UPLOAD', $module_upload);
$xtpl->assign('OP', $op);
$xtpl->assign('ROW', $row);
$xtpl->assign('Q', $array_search['q']);
$xtpl->assign('BASE_URL', $base_url);
$xtpl->assign('URLADD', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=crawler-content');

if (!empty($q)) {
    $base_url .= '&q=' . $q;
}
$generate_page = nv_generate_page($base_url, $num_items, $per_page, $page);
if (!empty($generate_page)) {
    $xtpl->assign('NV_GENERATE_PAGE', $generate_page);
    $xtpl->parse('main.generate_page');
}

$number = $page > 1 ? ($per_page * ($page - 1)) + 1 : 1;

$array_timer = array();
$array_timer[0] = $lang_global['no'];
for ($i = 30; $i <= 2880; $i += 30) {
    $array_timer[$i] = $i / 60 . ' ' . $lang_global['hour'];
}

while ($view = $sth->fetch()) {
    $view['number'] = $number++;
    $xtpl->assign('CHECK', $view['status'] == 1 ? 'checked' : '');
    $view['link_edit'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=crawler-content&amp;id=' . $view['id'];
    $view['link_delete'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;delete_id=' . $view['id'] . '&amp;delete_checkss=' . md5($view['id'] . NV_CACHE_PREFIX . $client_info['session_id']);
    $view['lasttime'] = !empty($view['lasttime']) ? nv_date('H:i d/m/Y', $view['lasttime']) : '-';
    $view['groups'] = $array_crawler_groups[$view['groups_id']]['title'];

    $xtpl->assign('VIEW', $view);

    foreach ($array_timer as $key => $value) {
        $sl = $key == $view['autotime'] ? 'selected="selected"' : '';
        $xtpl->assign('TIMER', array(
            'key' => $key,
            'value' => $value,
            'selected' => $sl
        ));
        $xtpl->parse('main.loop.timer');
    }

    if ($view['status']) {
        $xtpl->parse('main.loop.getnews');
    }

    $xtpl->parse('main.loop');
}

if (!empty($array_module_name)) {
    foreach ($array_module_name as $module) {
        $xtpl->assign('MODULE', $module);
        $xtpl->parse('main.module');
    }

    if (!empty($global_array_cat)) {
        foreach ($global_array_cat as $catid => $value) {
            $value['space'] = '';
            if ($value['lev'] > 0) {
                for ($i = 1; $i <= $value['lev']; $i++) {
                    $value['space'] .= '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                }
            }
            $value['selected'] = in_array($catid, $array_search['catid']) ? 'selected="selected"' : '';
            $xtpl->assign('CAT', $value);
            $xtpl->parse('main.cat');
        }
    }
}

$array_action = array(
    'fetch' => $lang_module['action_fetch'],
    'delete' => $lang_global['delete']
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

$page_title = $lang_module['crawler_source'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';