<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2015 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 20 Oct 2015 04:26:58 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) die('Stop!!!');

$table_name = NV_PREFIXLANG . '_' . $module_data . '_crawler_groups';

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

if ($nv_Request->isset_request('ajax_action', 'post')) {
    $id = $nv_Request->get_int('id', 'post', 0);
    $new_vid = $nv_Request->get_int('new_vid', 'post', 0);
    $content = 'NO_' . $id;
    if ($new_vid > 0) {
        $sql = 'SELECT id FROM ' . $table_name . ' WHERE id!=' . $id . ' ORDER BY weight ASC';
        $result = $db->query($sql);
        $weight = 0;
        while ($row = $result->fetch()) {
            ++$weight;
            if ($weight == $new_vid) ++$weight;
            $sql = 'UPDATE ' . $table_name . ' SET weight=' . $weight . ' WHERE id=' . $row['id'];
            $db->query($sql);
        }
        $sql = 'UPDATE ' . $table_name . ' SET weight=' . $new_vid . ' WHERE id=' . $id;
        $db->query($sql);
        $content = 'OK_' . $id;
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
        nv_crawler_groups_delete($id);
        $nv_Cache->delMod($module_name);
        Header('Location: ' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        die();
    }
} elseif ($nv_Request->isset_request('delete_list', 'post')) {
    $listall = $nv_Request->get_title('listall', 'post', '');
    $array_id = explode(',', $listall);

    if (!empty($array_id)) {
        foreach ($array_id as $id) {
            nv_crawler_groups_delete($id);
        }
        $nv_Cache->delMod($module_name);
        die('OK');
    }
    die('NO');
}

if ($nv_Request->isset_request('rewrite', 'post')) {
    $listid = $nv_Request->get_title('listid', 'get,post');
    $listid = explode(',', $listid);
    if (!empty($listid)) {
        foreach ($listid as $id) {
            $groups_info = $db->query('SELECT * FROM ' . $table_name . ' WHERE id=' . $id)->fetch();
            if (!empty($groups_info)) {
                $array_data = array(
                    'name' => $groups_info['title'],
                    'domain' => $groups_info['url'],
                    'logo' => $groups_info['logo'],
                    'type' => $groups_info['type'],
                    'config' => array(
                        'container_list_outside' => $groups_info['container_list_outside'],
                        'container_list_title' => $groups_info['container_list_title'],
                        'container_list_hometext' => $groups_info['container_list_hometext'],
                        'container_list_homeimage' => $groups_info['container_list_homeimage'],
                        'container_list_url' => $groups_info['container_list_url'],
                        'container_title' => $groups_info['container_title'],
                        'container_homeimage' => $groups_info['container_homeimage'],
                        'container_hometext' => $groups_info['container_hometext'],
                        'container_bodytext' => $groups_info['container_bodytext'],
                        'container_price' => $groups_info['container_price'],
                        'container_maplat' => $groups_info['container_maplat'],
                        'container_maplng' => $groups_info['container_maplng'],
                        'container_contact_fullname' => $groups_info['container_contact_fullname'],
                        'container_contact_email' => $groups_info['container_contact_email'],
                        'container_contact_phone' => $groups_info['container_contact_phone'],
                        'container_contact_address' => $groups_info['container_contact_address'],
                        'container_remove' => $groups_info['container_remove'],
                        'other_remove_string' => $groups_info['other_remove_string'],
                        'note' => $groups_info['other_remove_string']
                    )
                );

                $array_data['config'] = array_map('nv_unhtmlspecialchars', $array_data['config']);
                $xmlfile = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/template/' . $groups_info['titlekey'] . '.ini';
                if (!file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/template')) {
                    nv_mkdir(NV_UPLOADS_REAL_DIR . '/' . $module_upload, 'template');
                }

                $array2XML = new NukeViet\Xml\Array2XML();
                $array2XML->saveXML($array_data, 'template', $xmlfile, $encoding = $global_config['site_charset']);
            }
        }
        die($lang_module['action_rewrite_ok']);
    }

    die($lang_module['action_rewrite_no_ok']);
}

if ($nv_Request->isset_request('reupdate', 'post')) {
    $listid = $nv_Request->get_title('listid', 'get,post');
    $listid = explode(',', $listid);
    if (!empty($listid)) {
        foreach ($listid as $id) {
            nv_update_template($id);
        }
        die($lang_module['action_reupdate_ok']);
    }
}

$row = array();
$error = array();
$row['id'] = $nv_Request->get_int('id', 'post,get', 0);
$row['template'] = $nv_Request->get_title('template', 'post,get', '');

if ($nv_Request->isset_request('submit', 'post')) {
    $row['title'] = $nv_Request->get_title('title', 'post', '');
    $row['url'] = $nv_Request->get_title('url', 'post', '');
    $row['logo'] = $nv_Request->get_title('logo', 'post', '');
    if (is_file(NV_DOCUMENT_ROOT . $row['logo'])) {
        $row['logo'] = substr($row['logo'], strlen(NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/'));
    } else {
        $row['logo'] = '';
    }

    $url_info = @parse_url($row['url']);
    if (isset($url_info['scheme']) and isset($url_info['host'])) {
        $row['url'] = $url_info['scheme'] . '://' . $url_info['host'];
    } else {
        $row['url'] = '';
    }

    $row['type'] = $nv_Request->get_int('type', 'post', 0);
    $row['container_list_outside'] = $nv_Request->get_title('container_list_outside', 'post', '');
    $row['container_list_title'] = $nv_Request->get_title('container_list_title', 'post', '');
    $row['container_list_homeimage'] = $nv_Request->get_title('container_list_homeimage', 'post', '');
    $row['container_list_hometext'] = $nv_Request->get_title('container_list_hometext', 'post', '');
    $row['container_list_url'] = $nv_Request->get_title('container_list_url', 'post', '');
    $row['container_title'] = $nv_Request->get_title('container_title', 'post', '');
    $row['container_homeimage'] = $nv_Request->get_title('container_homeimage', 'post', '');
    $row['container_hometext'] = $nv_Request->get_title('container_hometext', 'post', '');
    $row['container_bodytext'] = $nv_Request->get_title('container_bodytext', 'post', '');
    $row['container_price'] = $nv_Request->get_title('container_price', 'post', '');
    $row['container_maplat'] = $nv_Request->get_title('container_maplat', 'post', '');
    $row['container_maplng'] = $nv_Request->get_title('container_maplng', 'post', '');
    $row['container_contact_fullname'] = $nv_Request->get_title('container_contact_fullname', 'post', '');
    $row['container_contact_email'] = $nv_Request->get_title('container_contact_email', 'post', '');
    $row['container_contact_phone'] = $nv_Request->get_title('container_contact_phone', 'post', '');
    $row['container_contact_address'] = $nv_Request->get_title('container_contact_address', 'post', '');
    $row['container_remove'] = $nv_Request->get_title('container_remove', 'post', '');
    $row['other_remove_string'] = $nv_Request->get_textarea('other_remove_string', '', 'br', 1);
    $row['note'] = $nv_Request->get_textarea('note', '', 'br', 1);

    if (empty($row['title'])) {
        $error[] = $lang_module['error_required_title'];
    } elseif (empty($row['url'])) {
        $error[] = $lang_module['error_required_url'];
    } elseif (!empty($row['url']) and !nv_is_url($row['url'])) {
        $error[] = $lang_module['error_url_url'];
    }

    if (empty($error)) {
        try {
            if (empty($row['id'])) {
                $stmt = $db->prepare('INSERT INTO ' . $table_name . ' (title, url, titlekey, logo, type, container_list_outside, container_list_title, container_list_homeimage, container_list_hometext, container_list_url, container_title, container_homeimage, container_hometext, container_bodytext, container_price, container_maplat, container_maplng, container_contact_fullname, container_contact_email, container_contact_phone, container_contact_address, container_remove, other_remove_string, note, weight, updatetime, status) VALUES (:title, :url, :titlekey, :logo, :type, :container_list_outside, :container_list_title, :container_list_homeimage, :container_list_hometext, :container_list_url, :container_title, :container_homeimage, :container_hometext, :container_bodytext, :container_price, :container_maplat, :container_maplng, :container_contact_fullname, :container_contact_email, :container_contact_phone, :container_contact_address, :container_remove, :other_remove_string, :note, :weight, ' . NV_CURRENTTIME . ', 1)');

                $weight = $db->query('SELECT max(weight) FROM ' . $table_name . '')->fetchColumn();
                $weight = intval($weight) + 1;
                $stmt->bindParam(':weight', $weight, PDO::PARAM_INT);
            } else {
                $stmt = $db->prepare('UPDATE ' . $table_name . ' SET title = :title, url = :url, titlekey = :titlekey, logo = :logo, type = :type, container_list_outside = :container_list_outside, container_list_title = :container_list_title, container_list_hometext = :container_list_hometext, container_list_homeimage = :container_list_homeimage, container_list_url = :container_list_url, container_title = :container_title, container_homeimage = :container_homeimage, container_hometext = :container_hometext, container_bodytext = :container_bodytext, container_price = :container_price, container_maplat = :container_maplat, container_maplng = :container_maplng, container_contact_fullname = :container_contact_fullname, container_contact_email = :container_contact_email, container_contact_phone = :container_contact_phone, container_contact_address = :container_contact_address, container_remove = :container_remove, other_remove_string = :other_remove_string, note = :note, updatetime = ' . NV_CURRENTTIME . ' WHERE id=' . $row['id']);
            }
            $stmt->bindParam(':title', $row['title'], PDO::PARAM_STR);
            $stmt->bindParam(':url', $row['url'], PDO::PARAM_STR);
            $stmt->bindParam(':titlekey', $url_info['host'], PDO::PARAM_STR);
            $stmt->bindParam(':logo', $row['logo'], PDO::PARAM_STR);
            $stmt->bindParam(':type', $row['type'], PDO::PARAM_INT);
            $stmt->bindParam(':container_list_outside', $row['container_list_outside'], PDO::PARAM_STR);
            $stmt->bindParam(':container_list_title', $row['container_list_title'], PDO::PARAM_STR);
            $stmt->bindParam(':container_list_homeimage', $row['container_list_homeimage'], PDO::PARAM_STR);
            $stmt->bindParam(':container_list_hometext', $row['container_list_hometext'], PDO::PARAM_STR);
            $stmt->bindParam(':container_list_url', $row['container_list_url'], PDO::PARAM_STR);
            $stmt->bindParam(':container_title', $row['container_title'], PDO::PARAM_STR);
            $stmt->bindParam(':container_homeimage', $row['container_homeimage'], PDO::PARAM_STR);
            $stmt->bindParam(':container_hometext', $row['container_hometext'], PDO::PARAM_STR);
            $stmt->bindParam(':container_bodytext', $row['container_bodytext'], PDO::PARAM_STR);
            $stmt->bindParam(':container_price', $row['container_price'], PDO::PARAM_STR);
            $stmt->bindParam(':container_maplat', $row['container_maplat'], PDO::PARAM_STR);
            $stmt->bindParam(':container_maplng', $row['container_maplng'], PDO::PARAM_STR);
            $stmt->bindParam(':container_contact_fullname', $row['container_contact_fullname'], PDO::PARAM_STR);
            $stmt->bindParam(':container_contact_email', $row['container_contact_email'], PDO::PARAM_STR);
            $stmt->bindParam(':container_contact_phone', $row['container_contact_phone'], PDO::PARAM_STR);
            $stmt->bindParam(':container_contact_address', $row['container_contact_address'], PDO::PARAM_STR);
            $stmt->bindParam(':container_remove', $row['container_remove'], PDO::PARAM_STR);
            $stmt->bindParam(':other_remove_string', $row['other_remove_string'], PDO::PARAM_STR);
            $stmt->bindParam(':note', $row['note'], PDO::PARAM_STR);

            $exc = $stmt->execute();
            if ($exc) {
                $nv_Cache->delMod($module_name);
                Header('Location: ' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
                die();
            }
        } catch (PDOException $e) {
            trigger_error($e->getMessage());
            die($e->getMessage()); // Remove this line after checks finished
        }
    }
} elseif ($row['id'] > 0) {
    $row = $db->query('SELECT * FROM ' . $table_name . ' WHERE id=' . $row['id'])->fetch();
    if (empty($row)) {
        Header('Location: ' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        die();
    }
} else {
    $row['id'] = 0;
    $row['title'] = '';
    $row['url'] = '';
    $row['logo'] = '';
    $row['type'] = 1;
    $row['container_list_outside'] = '';
    $row['container_list_title'] = '';
    $row['container_list_homeimage'] = '';
    $row['container_list_hometext'] = '';
    $row['container_list_url'] = '';
    $row['container_title'] = '';
    $row['container_homeimage'] = '';
    $row['container_hometext'] = '';
    $row['container_bodytext'] = '';
    $row['container_price'] = '';
    $row['container_maplat'] = '';
    $row['container_maplng'] = '';
    $row['container_contact_fullname'] = '';
    $row['container_contact_phone'] = '';
    $row['container_contact_email'] = '';
    $row['container_contact_address'] = '';
    $row['container_remove'] = '';
    $row['other_remove_string'] = '';
    $row['note'] = '';
}

$array_type = array(
    1 => $lang_module['type_dom']
    //0 => $lang_module['type_rss'],
);

if (!empty($row['template'])) {
    $xmlfile = NV_UPLOADS_REAL_DIR . '/autoget-news/template/' . $row['template'] . '.ini';
    $xml = simplexml_load_file($xmlfile);
    if ($xml !== false) {
        $xmlconfig = $xml->xpath('config');
        $config = $xmlconfig[0];
        $array_config = array();
        $array_config_title = array();

        foreach ($config as $key => $value) {
            $config_lang = $value->attributes();

            if (isset($config_lang[NV_LANG_INTERFACE])) {
                $lang = (string) $config_lang[NV_LANG_INTERFACE];
            } else {
                $lang = $key;
            }

            $array_config[$key] = trim($value);
            $array_config_title[$key] = $lang;
        }

        $row = $array_config;
        $row['title'] = trim($xml->name);
        $row['url'] = trim($xml->domain);
        $row['logo'] = trim($xml->logo);
        $row['type'] = trim($xml->type);

        unset($config, $xmlconfig, $xml);
    }
}

if (!empty($row['logo']) and is_file(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $row['logo'])) {
    $row['logo'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['logo'];
}

$q = $nv_Request->get_title('q', 'post,get');

// Fetch Limit
$show_view = false;
if (!$nv_Request->isset_request('id', 'post,get')) {
    $show_view = true;
    $per_page = 15;
    $page = $nv_Request->get_int('page', 'post,get', 1);
    $db->sqlreset()
        ->select('COUNT(*)')
        ->from($table_name);

    if (!empty($q)) {
        $db->where('title LIKE :q_title OR url LIKE :q_url OR logo LIKE :q_logo
		OR container_list_title LIKE :q_container_list_title OR container_list_homeimage LIKE :q_container_list_homeimage
		OR container_list_hometext LIKE :q_container_list_hometext OR container_list_outside LIKE :q_container_list_outside
		OR container_list_url LIKE :q_container_list_url
		OR container_title LIKE :q_container_title OR container_homeimage LIKE :q_container_homeimage
		OR container_hometext LIKE :q_container_hometext OR container_bodytext LIKE :q_container_bodytext
		OR container_remove LIKE :q_container_remove');
    }
    $sth = $db->prepare($db->sql());

    if (!empty($q)) {
        $sth->bindValue(':q_title', '%' . $q . '%');
        $sth->bindValue(':q_url', '%' . $q . '%');
        $sth->bindValue(':q_logo', '%' . $q . '%');
        $sth->bindValue(':q_container_list_outside', '%' . $q . '%');
        $sth->bindValue(':q_container_list_title', '%' . $q . '%');
        $sth->bindValue(':q_container_list_homeimage', '%' . $q . '%');
        $sth->bindValue(':q_container_list_hometext', '%' . $q . '%');
        $sth->bindValue(':q_container_list_url', '%' . $q . '%');
        $sth->bindValue(':q_container_title', '%' . $q . '%');
        $sth->bindValue(':q_container_homeimage', '%' . $q . '%');
        $sth->bindValue(':q_container_hometext', '%' . $q . '%');
        $sth->bindValue(':q_container_bodytext', '%' . $q . '%');
        $sth->bindValue(':q_container_remove', '%' . $q . '%');
    }
    $sth->execute();
    $num_items = $sth->fetchColumn();

    $db->select('*')
        ->order('weight ASC')
        ->limit($per_page)
        ->offset(($page - 1) * $per_page);
    $sth = $db->prepare($db->sql());

    if (!empty($q)) {
        $sth->bindValue(':q_title', '%' . $q . '%');
        $sth->bindValue(':q_url', '%' . $q . '%');
        $sth->bindValue(':q_logo', '%' . $q . '%');
        $sth->bindValue(':q_container_list_outside', '%' . $q . '%');
        $sth->bindValue(':q_container_list_title', '%' . $q . '%');
        $sth->bindValue(':q_container_list_homeimage', '%' . $q . '%');
        $sth->bindValue(':q_container_list_hometext', '%' . $q . '%');
        $sth->bindValue(':q_container_list_url', '%' . $q . '%');
        $sth->bindValue(':q_container_title', '%' . $q . '%');
        $sth->bindValue(':q_container_homeimage', '%' . $q . '%');
        $sth->bindValue(':q_container_hometext', '%' . $q . '%');
        $sth->bindValue(':q_container_bodytext', '%' . $q . '%');
        $sth->bindValue(':q_container_remove', '%' . $q . '%');
    }
    $sth->execute();
}

if (isset($row['other_remove_string']) and !empty($row['other_remove_string'])) {
    $row['other_remove_string'] = nv_htmlspecialchars(nv_br2nl($row['other_remove_string']));
}

if (isset($row['note']) and !empty($row['note'])) {
    $row['note'] = nv_htmlspecialchars(nv_br2nl($row['note']));
}

$row['dom_required'] = $row['type'] == 1 ? 'required="required"' : '';

$xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('MODULE_UPLOAD', $module_upload);
$xtpl->assign('OP', $op);
$xtpl->assign('ROW', $row);
$xtpl->assign('Q', $q);
$xtpl->assign('BASE_URL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=groups');

if ($show_view) {
    $base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op;
    if (!empty($q)) {
        $base_url .= '&q=' . $q;
    }
    $generate_page = nv_generate_page($base_url, $num_items, $per_page, $page);
    if (!empty($generate_page)) {
        $xtpl->assign('NV_GENERATE_PAGE', $generate_page);
        $xtpl->parse('main.view.generate_page');
    }
    $number = $page > 1 ? ($per_page * ($page - 1)) + 1 : 1;
    while ($view = $sth->fetch()) {
        for ($i = 1; $i <= $num_items; ++$i) {
            $xtpl->assign('WEIGHT', array(
                'key' => $i,
                'title' => $i,
                'selected' => ($i == $view['weight']) ? ' selected="selected"' : ''
            ));
            $xtpl->parse('main.view.loop.weight_loop');
        }
        $xtpl->assign('CHECK', $view['status'] == 1 ? 'checked' : '');
        $view['type'] = $array_type[$view['type']];
        $view['link_edit'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;id=' . $view['id'];
        $view['link_delete'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;delete_id=' . $view['id'] . '&amp;delete_checkss=' . md5($view['id'] . NV_CACHE_PREFIX . $client_info['session_id']);
        $view['updatetime'] = !empty($view['updatetime']) ? nv_date('H:i d/m/Y', $view['updatetime']) : 'N/A';
        $xtpl->assign('VIEW', $view);
        $xtpl->parse('main.view.loop');
    }

    $array_action = array(
        'delete' => $lang_global['delete']
    );
    foreach ($array_action as $key => $value) {
        $xtpl->assign('ACTION', array(
            'key' => $key,
            'value' => $value
        ));
        $xtpl->parse('main.view.action');
    }

    $xtpl->parse('main.view');
}

foreach ($array_type as $index => $value) {
    $ck = $index == $row['type'] ? 'checked="checked"' : '';
    $xtpl->assign('TYPE', array(
        'index' => $index,
        'value' => $value,
        'checked' => $ck
    ));
    $xtpl->parse('main.type');
}

if ($row['type'] == 0) {
    $xtpl->parse('main.dom_hidden');
}

if (!empty($error)) {
    $xtpl->assign('ERROR', implode('<br />', $error));
    $xtpl->parse('main.error');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

$page_title = $lang_module['crawler_groups'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';