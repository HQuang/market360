<?php

/**
 * @Project NUKEVIET 4.x
 * @Author hongoctrien (hongoctrien@2mit.org)
 * @Copyright (C) 2015 hongoctrien. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 20 Oct 2015 03:55:17 GMT
 */

/**
 * nv_strip_tags_content()
 *
 * @param mixed $text
 * @param mixed $tags
 * @param mixed $invert
 * @return
 *
 *
 */
function nv_strip_tags_content($text, $tags = '', $invert = FALSE)
{
    preg_match_all('/<(.+?)[\s]*\/?[\s]*>/si', trim($tags), $tags);
    $tags = array_unique($tags[1]);

    if (is_array($tags) and count($tags) > 0) {
        if ($invert == FALSE) {
            return preg_replace('@<(?!(?:' . implode('|', $tags) . ')\b)(\w+)\b.*?>.*?</\1>@si', '', $text);
        } else {
            return preg_replace('@<(' . implode('|', $tags) . ')\b.*?>.*?</\1>@si', '', $text);
        }
    } elseif ($invert == FALSE) {
        return preg_replace('@<(\w+)\b.*?>.*?</\1>@si', '', $text);
    }
    return $text;
}

/**
 * nv_convert_unicode()
 *
 * @param mixed $string
 * @return
 *
 */
function nv_convert_unicode($string)
{
    return html_entity_decode($string, ENT_QUOTES, 'UTF-8');
}

/**
 * nv_news_fix_block()
 *
 * @param mixed $module
 * @param mixed $bid
 * @param bool $repairtable
 * @return
 *
 */
function nv_news_fix_block($module, $bid, $repairtable = true)
{
    global $db, $site_mods;

    $bid = intval($bid);
    if ($bid > 0) {
        $sql = 'SELECT id FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_block where bid=' . $bid . ' ORDER BY weight ASC';
        $result = $db->query($sql);
        $weight = 0;
        while ($row = $result->fetch()) {
            ++$weight;
            if ($weight <= 100) {
                $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_block SET weight=' . $weight . ' WHERE bid=' . $bid . ' AND id=' . $row['id'];
            } else {
                $sql = 'DELETE FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_block WHERE bid=' . $bid . ' AND id=' . $row['id'];
            }
            $db->query($sql);
        }
        $result->closeCursor();
        if ($repairtable) {
            $db->query('OPTIMIZE TABLE ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_block');
        }
    }
}

/**
 * nv_detect_redirect()
 *
 * @param mixed $url
 * @return
 *
 */
function nv_detect_redirect($url)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_URL, $url);
    $out = curl_exec($ch);
    $out = str_replace("\r", "", $out);
    $headers_end = strpos($out, "\n\n");
    if ($headers_end !== false) {
        $out = substr($out, 0, $headers_end);
    }
    $headers = explode("\n", $out);
    $pieces = array(
        $url
    );
    foreach ($headers as $header) {
        if (substr($header, 0, 10) == "Location: ") {
            $target = substr($header, 10);
            $pieces = explode("?", $target);
        }
    }
    return $pieces[0];
}

/**
 * nv_get_anchor()
 *
 * @param mixed $element
 * @return
 *
 */
function nv_get_anchor($element)
{
    $return = array(
        'element' => $element,
        'anchor' => 0
    );
    if (preg_match('/\[([0-9]+)\]$/', $element, $m)) {
        $return['element'] = str_replace($m[0], '', $element);
        $return['anchor'] = preg_replace('/[^0-9]/', '', $m[0]);
    }
    return $return;
}

/**
 * nv_getnews_viewImage()
 *
 * @param mixed $fileName
 * @return
 *
 */
function nv_getnews_viewImage($fileName)
{
    global $db;

    $array_thumb_config = array();

    $sql = 'SELECT * FROM ' . NV_UPLOAD_GLOBALTABLE . '_dir ORDER BY dirname ASC';
    $result = $db->query($sql);
    while ($row = $result->fetch()) {
        $array_dirname[$row['dirname']] = $row['did'];
        if ($row['thumb_type']) {
            $array_thumb_config[$row['dirname']] = $row;
        }
    }
    unset($array_dirname['']);

    if (preg_match('/^' . nv_preg_quote(NV_UPLOADS_DIR) . '\/(([a-z0-9\-\_\/]+\/)*([a-z0-9\-\_\.]+)(\.(gif|jpg|jpeg|png|bmp|ico)))$/i', $fileName, $m)) {
        $viewFile = NV_FILES_DIR . '/' . $m[1];

        if (file_exists(NV_ROOTDIR . '/' . $viewFile)) {
            $size = @getimagesize(NV_ROOTDIR . '/' . $viewFile);
            return array(
                $viewFile,
                $size[0],
                $size[1]
            );
        } else {
            $m[2] = rtrim($m[2], '/');

            if (isset($array_thumb_config[NV_UPLOADS_DIR . '/' . $m[2]])) {
                $thumb_config = $array_thumb_config[NV_UPLOADS_DIR . '/' . $m[2]];
            } else {
                $thumb_config = $array_thumb_config[''];
                $_arr_path = explode('/', NV_UPLOADS_DIR . '/' . $m[2]);
                while (sizeof($_arr_path) > 1) {
                    array_pop($_arr_path);
                    $_path = implode('/', $_arr_path);
                    if (isset($array_thumb_config[$_path])) {
                        $thumb_config = $array_thumb_config[$_path];
                        break;
                    }
                }
            }

            $viewDir = NV_FILES_DIR;
            if (!empty($m[2])) {
                if (!is_dir(NV_ROOTDIR . '/' . $m[2])) {
                    $e = explode('/', $m[2]);
                    $cp = NV_FILES_DIR;
                    foreach ($e as $p) {
                        if (is_dir(NV_ROOTDIR . '/' . $cp . '/' . $p)) {
                            $viewDir .= '/' . $p;
                        } else {
                            $mk = nv_mkdir(NV_ROOTDIR . '/' . $cp, $p);
                            if ($mk[0] > 0) {
                                $viewDir .= '/' . $p;
                            }
                        }
                        $cp .= '/' . $p;
                    }
                }
            }
            $image = new NukeViet\Files\Image(NV_ROOTDIR . '/' . $fileName, NV_MAX_WIDTH, NV_MAX_HEIGHT);
            if ($thumb_config['thumb_type'] == 4) {
                $thumb_width = $thumb_config['thumb_width'];
                $thumb_height = $thumb_config['thumb_height'];
                $maxwh = max($thumb_width, $thumb_height);
                if ($image->fileinfo['width'] > $image->fileinfo['height']) {
                    $thumb_config['thumb_width'] = 0;
                    $thumb_config['thumb_height'] = $maxwh;
                } else {
                    $thumb_config['thumb_width'] = $maxwh;
                    $thumb_config['thumb_height'] = 0;
                }
            }
            if ($image->fileinfo['width'] > $thumb_config['thumb_width'] or $image->fileinfo['height'] > $thumb_config['thumb_height']) {
                $image->resizeXY($thumb_config['thumb_width'], $thumb_config['thumb_height']);
                if ($thumb_config['thumb_type'] == 4) {
                    $image->cropFromCenter($thumb_width, $thumb_height);
                }
                $image->save(NV_ROOTDIR . '/' . $viewDir, $m[3] . $m[4], $thumb_config['thumb_quality']);
                $create_Image_info = $image->create_Image_info;
                $error = $image->error;
                $image->close();
                if (empty($error)) {
                    return array(
                        $viewDir . '/' . basename($create_Image_info['src']),
                        $create_Image_info['width'],
                        $create_Image_info['height']
                    );
                }
            } elseif (copy(NV_ROOTDIR . '/' . $fileName, NV_ROOTDIR . '/' . $viewDir . '/' . $m[3] . $m[4])) {
                $return = array(
                    $viewDir . '/' . $m[3] . $m[4],
                    $image->fileinfo['width'],
                    $image->fileinfo['height']
                );
                $image->close();
                return $return;
            } else {
                return false;
            }
        }
    } else {
        $size = @getimagesize(NV_ROOTDIR . '/' . $fileName);
        return array(
            $fileName,
            $size[0],
            $size[1]
        );
    }
    return false;
}

function remove_empty_p($content)
{
    $content = preg_replace(array(
        '#<p>\s*<(div|aside|section|article|header|footer)#',
        '#</(div|aside|section|article|header|footer)>\s*</p>#',
        '#</(div|aside|section|article|header|footer)>\s*<br ?/?>#',
        '#<(div|aside|section|article|header|footer)(.*?)>\s*</p>#',
        '#<p>\s*</(div|aside|section|article|header|footer)#'
    ), array(
        '<$1',
        '</$1>',
        '</$1>',
        '<$1$2>',
        '</$1'
    ), $content);

    return preg_replace('#<p>(\s|&nbsp;)*+(<br\s*/*>)*(\s|&nbsp;)*</p>#i', '', $content);
}

function nv_autoget_detail($rows_id, $acept = 0, $module = '')
{
    global $db, $lang_module, $module_name, $module_data, $module_file, $module_upload, $global_config, $array_config, $lang_module, $nv_Cache, $sys_info, $array_config, $admin_info, $module_config;

    if ($sys_info['allowed_set_time_limit']) {
        set_time_limit(0);
    }

    $error = array();
    $rows_info = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows WHERE id=' . $rows_id)->fetch();
    if (!empty($rows_info)) {
        $items_info = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items WHERE id=' . $rows_info['items_id'])->fetch();
        if (nv_is_url($rows_info['url'])) {

            // Xác định lại URL, một số link HTTP 301
            $detect_url = nv_detect_redirect($rows_info['url']);
            if (!empty($detect_url)) {
                $rows_info['url'] = $detect_url;
            }

            $files_path = NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . md5($rows_info['url']) . '.html';

            $userAgents = array( //
                'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5 (.NET CLR 3.5.30729)', //
                'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', //
                'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', //
                'Mozilla/4.8 [en] (Windows NT 6.0; U)', //
                'Opera/9.25 (Windows NT 6.0; U; en)'
            );
            srand((float) microtime() * 10000000);
            $rand = array_rand($userAgents);
            $agent = $userAgents[$rand];

            $agent = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5 (.NET CLR 3.5.30729)';

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $rows_info['url']);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
            $safe_mode = (ini_get('safe_mode') == '1' || strtolower(ini_get('safe_mode')) == 'on') ? 1 : 0;
            $open_basedir = @ini_get('open_basedir') ? true : false;
            if (!$safe_mode and !$open_basedir) {
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
                curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
            }
            curl_setopt($ch, CURLOPT_TIMEOUT, 20);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_USERAGENT, $agent);
            $html = curl_exec($ch);
            curl_close($ch);
            file_put_contents($files_path, $html);

            $groups_info = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups WHERE id=' . $items_info['groups_id'])->fetch();
            if (file_exists($files_path) and !empty($groups_info)) {
                require_once NV_ROOTDIR . '/modules/' . $module_file . '/simple_html_dom.php';
                $html = file_get_html($files_path);

                $module = $module_name;
                $mod_data = $module_data;
                $mod_upload = $module_upload;

                $_sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $mod_data . '_cat WHERE status=1 ORDER BY sort';
                $array_market_cat = $nv_Cache->db($_sql, 'id', $module);

                if (defined('NV_MARKET_CRAWLER')) {
                    $array_config = $module_config[$module];
                }

                // Giải mã ký tự đặc biệt
                $groups_info['container_title'] = nv_unhtmlspecialchars($groups_info['container_title']);
                $groups_info['container_homeimage'] = nv_unhtmlspecialchars($groups_info['container_homeimage']);
                $groups_info['container_hometext'] = nv_unhtmlspecialchars($groups_info['container_hometext']);
                $groups_info['container_bodytext'] = nv_unhtmlspecialchars($groups_info['container_bodytext']);
                $groups_info['container_price'] = nv_unhtmlspecialchars($groups_info['container_price']);
                $groups_info['container_maplat'] = nv_unhtmlspecialchars($groups_info['container_maplat']);
                $groups_info['container_maplng'] = nv_unhtmlspecialchars($groups_info['container_maplng']);
                $groups_info['container_contact_fullname'] = nv_unhtmlspecialchars($groups_info['container_contact_fullname']);
                $groups_info['container_contact_email'] = nv_unhtmlspecialchars($groups_info['container_contact_email']);
                $groups_info['container_contact_phone'] = nv_unhtmlspecialchars($groups_info['container_contact_phone']);
                $groups_info['container_contact_address'] = nv_unhtmlspecialchars($groups_info['container_contact_address']);
                $groups_info['container_remove'] = nv_unhtmlspecialchars($groups_info['container_remove']);

                // Tiêu đề bài viết
                $news_title = '';
                $groups_info['container_title'] = explode(',', $groups_info['container_title']);
                if (!empty($groups_info['container_title'])) {
                    foreach ($groups_info['container_title'] as $container_title) {
                        $news_title = $html->find($container_title, 0) ? trim(nv_convert_unicode($html->find($container_title, 0)->plaintext)) : '';
                        if (!empty($news_title)) break;
                    }
                }

                // Tự động tìm và lấy title từ tag title
                if (empty($news_title)) {
                    $news_title = isset($html->find('title', 0)->plaintext) ? $html->find('title', 0)->plaintext : '';
                }

                // báo lỗi nếu không lấy được tiêu đề
                if (empty($news_title)) {
                    $msg = $items_info['title'] . ': ' . $lang_module['error_empty_title'];
                    nv_item_error_action($rows_info['items_id'], $msg);
                }

                // Giới thiệu ngắn gọn
                $news_hometext = '';
                if (!empty($groups_info['container_hometext'])) {
                    $groups_info['container_hometext'] = explode(',', $groups_info['container_hometext']);
                    foreach ($groups_info['container_hometext'] as $container_hometext) {
                        $news_hometext = $html->find($container_hometext, 0) ? nv_strip_tags_content(nv_convert_unicode($html->find($container_hometext, 0)->innertext())) : '';
                        if (!empty($news_hometext)) break;
                    }
                }

                // Nội dung bài viết
                $news_bodytext = '';
                $groups_info['container_bodytext'] = explode(',', $groups_info['container_bodytext']);
                if (!empty($groups_info['container_bodytext'])) {
                    foreach ($groups_info['container_bodytext'] as $container_bodytext) {
                        $news_bodytext = $html->find($container_bodytext, 0) ? nv_convert_unicode($html->find($container_bodytext, 0)->innertext()) : '';
                        if (!empty($news_bodytext)) break;
                    }
                }

                if (!empty($news_bodytext)) {

                    $news_bodytext = str_get_html($news_bodytext);

                    // Loại bỏ các thẻ trong nội dung (theo cấu hình module)
                    if (!empty($array_config['remove_global_tag'])) {
                        $remove_global_tag = explode(',', $array_config['remove_global_tag']);
                        $remove_global_tag = array_map('trim', $remove_global_tag);
                        $remove_global_tag = array_unique($remove_global_tag);
                        foreach ($remove_global_tag as $remove) {
                            if (!empty($remove)) {
                                foreach ($news_bodytext->find($remove) as $item) {
                                    $item->outertext = '';
                                }
                            }
                        }
                        $news_bodytext->save();
                    }

                    // Lọc các thẻ cần loại bỏ trong nội dung (Cấu hình nguồn tin)
                    if (!empty($groups_info['container_remove'])) {
                        $container_remove = explode(',', $groups_info['container_remove']);
                        $container_remove = array_map('trim', $container_remove);
                        $container_remove = array_unique($container_remove);
                        foreach ($container_remove as $remove) {
                            if (!empty($remove)) {
                                foreach ($news_bodytext->find($remove) as $item) {
                                    $item->outertext = '';
                                }
                            }
                        }
                        $news_bodytext->save();
                    }
                }

                // Tự động tìm và lấy hometext từ tag description
                if (empty($news_hometext)) {
                    $news_hometext = isset($html->find('meta[name=description]', 0)->content) ? $html->find('meta[name=description]', 0)->content : '';
                }

                if (empty($news_hometext)) {
                    $news_hometext = nv_clean60(strip_tags($news_bodytext), 160);
                }

                // Loại bỏ cụm từ trong nội dung
                if (!empty($groups_info['other_remove_string'])) {
                    $remove_string = $groups_info['other_remove_string'];
                    $remove_string = explode('<br />', $remove_string);
                    if (!empty($remove_string)) {
                        $news_hometext = str_replace($remove_string, '', $news_hometext);
                        $news_bodytext = str_replace($remove_string, '', $news_bodytext);
                    }
                }

                // Loại bỏ javascript trong nội dung
                $news_bodytext = preg_replace('/<script\b[^>]*>(.*?)<\/script>/is', "", $news_bodytext);

                // Loại bỏ link trong nội dung
                if ($items_info['remove_link']) {
                    $news_bodytext = preg_replace('#<a.*?>(.*?)</a>#i', '\1', $news_bodytext);
                }

                // loại bỏ thẻ p rỗng trong nội dung
                $news_bodytext = remove_empty_p($news_bodytext);

                // Tìm từ khóa và thêm link theo cấu hình
                if ($items_info['autolink'] and !empty($array_config['keywords'])) {
                    $reg_post = $array_config['casesens'] ? '/(?!(?:[^<\[]+[>\]]|[^>\]]+<\/a>))($news_bodytext)/imsU' : '/(?!(?:[^<\[]+[>\]]|[^>\]]+<\/a>))($news_bodytext)/msU';
                    $array_config['keywords'] = unserialize($array_config['keywords']);
                    foreach ($array_config['keywords'] as $keyword) {
                        $url = $keyword['link'];
                        $regexp = str_replace('$news_bodytext', $keyword['keywords'], $reg_post);
                        $replace = '<a title="$1" href="$$$url$$$" ' . ($keyword['target'] == 1 ? 'target="_blank"' : '') . '>$1</a>';
                        $newtext = preg_replace($regexp, $replace, $news_bodytext, $keyword['limit']);

                        if ($newtext != $keyword['keywords']) {
                            $news_bodytext = str_replace('$$$url$$$', $url, $newtext);
                        }
                    }
                }

                // Tự động thêm tiếp đầu tố
                if (!empty($news_hometext) and !empty($array_config['hometext_prefix'])) {
                    $news_hometext = $array_config['hometext_prefix'] . ' ' . $news_hometext;
                }

                $row = array();
                $row['id'] = 0;
                $row['code'] = '';
                $row['title'] = $news_title;
                $row['catid'] = $items_info['catid'];
                $row['area_p'] = $items_info['area_p'];
                $row['area_d'] = $items_info['area_d'];
                $row['area_w'] = $items_info['area_w'];
                $row['address'] = '';
                $row['typeid'] = $items_info['typeid'];
                $row['description'] = $news_hometext;
                $row['content'] = $news_bodytext;
                $row['pricetype'] = 2;
                $row['price'] = 0;
                $row['price1'] = 0;
                $row['unitid'] = 0;
                $row['note'] = '';
                $row['queue'] = 0;
                $row['queue_reason'] = '';
                $row['queue_reasonid'] = 0;
                $row['userid'] = 0;
                $row['images'] = '';
                $row['remove_link'] = 1;
                $row['custom_field'] = '';
                $row['maps'] = array();
                $row['display_maps'] = 0;
                $row['groupview'] = 6;
                $row['groupcomment'] = 6;
                $row['groupid'] = '';
                $row['exptime'] = 0;
                $row['auction'] = 0;
                $row['auction_begin'] = 0;
                $row['auction_end'] = 0;
                $row['auction_price_begin'] = 0;
                $row['auction_price_step'] = 0;
                $row['maps'] = $row['custom_field'] = $row['images'] = array();
                $row['display_maps'] = 0;

                $row['contact_fullname'] = '';
                $row['contact_email'] = '';
                $row['contact_phone'] = '';
                $row['contact_address'] = '';

                $row['alias'] = change_alias($row['title']);
                $stmt = $db->prepare('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows WHERE id !=' . $row['id'] . ' AND alias = :alias');
                $stmt->bindParam(':alias', $row['alias'], PDO::PARAM_STR);
                $stmt->execute();

                if ($stmt->fetchColumn()) {
                    $weight = $db->query('SELECT MAX(id) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows')->fetchColumn();
                    $weight = intval($weight) + 1;
                    $row['alias'] = $row['alias'] . '-' . $weight;
                }

                // lấy thông tin bản đồ
                if (!empty($groups_info['container_maplat']) && !empty($groups_info['container_maplng'])) {
                    $lat = $html->find($groups_info['container_maplat'], 0) ? $html->find($groups_info['container_maplat'], 0)->value : '';
                    $lng = $html->find($groups_info['container_maplng'], 0) ? $html->find($groups_info['container_maplng'], 0)->value : '';
                    if (!empty($lat) && !empty($lng)) {
                        $row['display_maps'] = 1;
                        $row['maps'] = array(
                            'maps_mapcenterlat' => $lat,
                            'maps_mapcenterlng' => $lng,
                            'maps_maplat' => $lat,
                            'maps_maplng' => $lng,
                            'maps_mapzoom' => 17
                        );
                    }
                }

                if (!empty($groups_info['container_price'])) {
                    $row['price'] = $html->find($groups_info['container_price'], 0) ? $html->find($groups_info['container_price'], 0)->plaintext : '';
                    if (!empty($row['price'])) {
                        $row['price'] = nv_market_money_string_to_number($row['price']);
                        $row['pricetype'] = 0;
                    }
                }

                // lấy thông tin liên hệ
                if (!empty($groups_info['container_contact_fullname'])) {
                    $row['contact_fullname'] = $html->find($groups_info['container_contact_fullname'], 0) ? $html->find($groups_info['container_contact_fullname'], 0)->plaintext : '';
                }
                if (!empty($groups_info['container_contact_email'])) {
                    $row['contact_email'] = $html->find($groups_info['container_contact_email'], 0) ? $html->find($groups_info['container_contact_email'], 0)->plaintext : '';
                }
                if (!empty($groups_info['container_contact_phone'])) {
                    $row['contact_phone'] = $html->find($groups_info['container_contact_phone'], 0) ? $html->find($groups_info['container_contact_phone'], 0)->plaintext : '';
                }
                if (!empty($groups_info['container_contact_address'])) {
                    $row['contact_address'] = $html->find($groups_info['container_contact_address'], 0) ? $html->find($groups_info['container_contact_address'], 0)->plaintext : '';
                }

                // KIểm tra dữ liệu thu được
                if (empty($row['title'])) {
                    $error[] = $lang_module['error_post_title'];
                }
                if (empty($row['description'])) {
                    $error[] = $lang_module['error_post_hometext'];
                }
                if (empty($row['content'])) {
                    $error[] = $lang_module['error_post_bodytext'];
                }

                // Thêm bản tin
                if (empty($error)) {
                    // Tự động tạo từ khóa bài viết
                    if ($items_info['auto_getkeyword']) {
                        $row['keywords'] = isset($html->find('meta[name=keywords]', 0)->content) ? $html->find('meta[name=keywords]', 0)->content : '';
                    }
                    if ($items_info['auto_keyword'] and $row['keywords'] == '') {
                        $keywords = ($row['description'] != '') ? $row['description'] : $row['content'];
                        $keywords = nv_get_keywords($keywords, 100);
                        $keywords = explode(',', $keywords);

                        // Ưu tiên lọc từ khóa theo các từ khóa đã có trong tags thay vì đọc từ từ điển
                        $keywords_return = array();
                        foreach ($keywords as $keyword_i) {
                            $sth = $db->prepare('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $mod_data . '_tags_id where keyword = :keyword');
                            $sth->bindParam(':keyword', $keyword_i, PDO::PARAM_STR);
                            $sth->execute();
                            if ($sth->fetchColumn()) {
                                $keywords_return[] = $keyword_i;
                                if (sizeof($keywords_return) > 20) {
                                    break;
                                }
                            }
                        }

                        if (sizeof($keywords_return) < 20) {
                            foreach ($keywords as $keyword_i) {
                                if (!in_array($keyword_i, $keywords_return)) {
                                    $keywords_return[] = $keyword_i;
                                    if (sizeof($keywords_return) > 20) {
                                        break;
                                    }
                                }
                            }
                        }
                        $row['keywords'] = implode(',', $keywords_return);
                    }

                    // Xử lý hình ảnh
                    $upload = new NukeViet\Files\Upload($global_config['file_allowed_ext'], $global_config['forbid_extensions'], $global_config['forbid_mimes'], NV_UPLOAD_MAX_FILESIZE, NV_MAX_WIDTH, NV_MAX_HEIGHT);
                    $lu = strlen(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $mod_upload . '/');

                    $username_alias = change_alias($admin_info['username']);
                    $currentpath = nv_upload_user_path($username_alias);

                    if (file_exists(NV_ROOTDIR . '/' . $currentpath)) {
                        $upload_real_dir_page = NV_ROOTDIR . '/' . $currentpath;
                    } else {
                        $upload_real_dir_page = NV_UPLOADS_REAL_DIR . '/' . $module;
                        $e = explode('/', $currentpath);
                        if (!empty($e)) {
                            $cp = '';
                            foreach ($e as $p) {
                                if (!empty($p) and !is_dir(NV_UPLOADS_REAL_DIR . '/' . $cp . $p)) {
                                    $mk = nv_mkdir(NV_UPLOADS_REAL_DIR . '/' . $cp, $p);
                                    if ($mk[0] > 0) {
                                        $upload_real_dir_page = $mk[2];
                                        $db->query("INSERT INTO " . NV_UPLOAD_GLOBALTABLE . "_dir (dirname, time) VALUES ('" . NV_UPLOADS_DIR . "/" . $cp . $p . "', 0)");
                                    }
                                } elseif (!empty($p)) {
                                    $upload_real_dir_page = NV_UPLOADS_REAL_DIR . '/' . $cp . $p;
                                }
                                $cp .= $p . '/';
                            }
                        }
                        $upload_real_dir_page = str_replace('\\', '/', $upload_real_dir_page);
                    }

                    // Xử lý ảnh minh họa
                    $row['homeimgthumb'] = 0;
                    if (!empty($groups_info['container_homeimage'])) {
                        $rows_info['homeimage'] = isset($html->find($groups_info['container_homeimage'], 0)->src) ? $html->find($groups_info['container_homeimage'], 0)->src : $rows_info['homeimage']; // Lấy ảnh minh họa
                    }

                    // Loại bỏ https trong đường dẫn ảnh
                    if (!empty($rows_info['homeimage'])) {
                        $parsed = parse_url($rows_info['homeimage']);
                        if (isset($parsed['host'])) {
                            if (isset($parsed['scheme']) && strtolower($parsed['scheme']) == 'https') {
                                $rows_info['homeimage'] = 'http://' . substr($rows_info['homeimage'], 8);
                            }
                        } else {
                            $rows_info['homeimage'] = $groups_info['url'] . $rows_info['homeimage'];
                        }

                        $upload_info = $upload->save_urlfile($rows_info['homeimage'], $upload_real_dir_page, false, $global_config['nv_auto_resize']);
                        if (empty($upload_info['error'])) {
                            $row['homeimgfile'] = substr($upload_info['name'], $lu);
                            nv_getnews_viewImage(NV_UPLOADS_DIR . '/' . $mod_upload . '/' . $row['homeimgfile']);
                        }
                    }

                    //neu co the data-src thi se loai bo src va thay the bang data-src
                    if (preg_match_all("/\<img[^\>]*data-src=\"([^\"]*)\"[^\>]*\>/is", $row['content'], $match)) {
                        //loai bo atribute src va class chuyen data-src thanh src
                        $row['content'] = preg_replace('/\\<(.*?)(src="(.*?)")(.*?)(class="(.*?)")(.*?)\\>/i', '<$1$4$7>', $row['content']);
                        $row['content'] = preg_replace('~<img[^>]*\Kdata-src(?=)~i', 'src', $row['content']);
                    }

                    if (preg_match_all("/\<img[^\>]*src=\"([^\"]*)\"[^\>]*\>/is", $row['content'], $match)) {
                        foreach ($match[0] as $key => $_m) {
                            $image_url = $image_url_tmp = $match[1][$key];
                            $str_replace = 0;

                            // Loại bỏ https trong đường dẫn ảnh
                            $parsed = parse_url($image_url);
                            if (isset($parsed['scheme']) && strtolower($parsed['scheme']) == 'https') {
                                $str_replace = 1;
                                $image_url = 'http://' . substr($image_url, 8);
                            }

                            if (!empty($image_url) and !isset($parsed['host']) and !preg_match('/^\/\//', $image_url)) {
                                $str_replace = 1;
                                $image_url = $groups_info['url'] . $image_url;
                            }

                            if ($str_replace) {
                                $row['content'] = str_replace($image_url_tmp, $image_url, $row['content']);
                            }

                            // Lưu ảnh về host
                            if ($items_info['save_image']) {
                                $parsed = parse_url($image_url);
                                if (isset($parsed['host']) and isset($parsed['path'])) {
                                    $_image_url = 'http://' . $parsed['host'] . $parsed['path'];
                                }

                                $upload_info = $upload->save_urlfile($_image_url, $upload_real_dir_page, true, $global_config['nv_auto_resize']);
                                if (empty($upload_info['error'])) {
                                    $image = NV_UPLOADS_DIR . '/' . $mod_upload . '/' . substr($upload_info['name'], $lu);
                                    $row['content'] = str_replace($image_url, NV_BASE_SITEURL . $image, $row['content']);
                                    nv_getnews_viewImage($image);
                                }
                            }
                        }
                    }

                    // Tự động lấy ảnh minh họa (nếu rỗng)
                    if ($items_info['auto_homeimage'] and empty($row['homeimgfile'])) {
                        if (preg_match_all("/\<img[^\>]*src=\"([^\"]*)\"[^\>]*\>/is", $row['content'], $match)) {
                            if (sizeof($match[0]) > 0) {
                                foreach ($match[0] as $key => $_m) {
                                    $image_url = $match[1][$key];
                                    if (!$items_info['save_image']) {
                                        $parsed = parse_url($image_url);
                                        if (isset($parsed['host']) and isset($parsed['path'])) {
                                            $_image_url = 'http://' . $parsed['host'] . $parsed['path'];
                                        }
                                        $upload_info = $upload->save_urlfile($_image_url, $upload_real_dir_page, false, $global_config['nv_auto_resize']);
                                        if (empty($upload_info['error'])) {
                                            $row['homeimgfile'] = substr($upload_info['name'], $lu);
                                            nv_getnews_viewImage(NV_UPLOADS_DIR . '/' . $mod_upload . '/' . $row['homeimgfile']);
                                            break;
                                        }
                                    } else {
                                        list ($width, $height) = getimagesize(NV_ROOTDIR . $image_url);
                                        if ($width > 300 || $height > 150) {
                                            $row['homeimgfile'] = str_replace(NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $mod_upload . '/', '', $image_url);
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Thiết lập loại ảnh đại diện
                    $row['homeimgthumb'] = 0;
                    if (!nv_is_url($row['homeimgfile']) and nv_is_file(NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $mod_upload . '/' . $row['homeimgfile'], NV_UPLOADS_DIR . '/' . $mod_upload) === true) {
                        if (file_exists(NV_ROOTDIR . '/' . NV_FILES_DIR . '/' . $mod_upload . '/' . $row['homeimgfile'])) {
                            $row['homeimgthumb'] = 1;
                        } else {
                            $row['homeimgthumb'] = 2;
                        }
                    } elseif (nv_is_url($row['homeimgfile'])) {
                        $row['homeimgthumb'] = 3;
                    } else {
                        $row['homeimgfile'] = '';
                    }

                    $_sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $mod_data . '_rows (code, title, alias, catid, groupid, area_p, area_d, area_w, address, typeid, description, pricetype, price, price1, unitid, addtime, exptime, auction, auction_begin, auction_end, auction_price_begin, auction_price_step, groupview, userid, ordertime) VALUES (:code, :title, :alias, :catid, :groupid, :area_p, :area_d, :area_w, :address, :typeid, :description, :pricetype, :price, :price1, :unitid, ' . NV_CURRENTTIME . ', :exptime, :auction, :auction_begin, :auction_end, :auction_price_begin, :auction_price_step, :groupview, :userid, ' . NV_CURRENTTIME . ')';
                    $data_insert = array();
                    $data_insert['code'] = $row['code'];
                    $data_insert['title'] = $row['title'];
                    $data_insert['alias'] = $row['alias'];
                    $data_insert['catid'] = $row['catid'];
                    $data_insert['groupid'] = $row['groupid'];
                    $data_insert['area_p'] = $row['area_p'];
                    $data_insert['area_d'] = $row['area_d'];
                    $data_insert['area_w'] = $row['area_w'];
                    $data_insert['address'] = $row['address'];
                    $data_insert['typeid'] = $row['typeid'];
                    $data_insert['description'] = $row['description'];
                    $data_insert['pricetype'] = $row['pricetype'];
                    $data_insert['price'] = $row['price'];
                    $data_insert['price1'] = $row['price1'];
                    $data_insert['unitid'] = $row['unitid'];
                    $data_insert['exptime'] = $row['exptime'];
                    $data_insert['auction'] = $row['auction'];
                    $data_insert['auction_begin'] = $row['auction_begin'];
                    $data_insert['auction_end'] = $row['auction_end'];
                    $data_insert['auction_price_begin'] = $row['auction_price_begin'];
                    $data_insert['auction_price_step'] = $row['auction_price_step'];
                    $data_insert['groupview'] = $row['groupview'];
                    $data_insert['userid'] = $row['userid'];
                    $new_id = $db->insert_id($_sql, 'id', $data_insert);

                    if ($new_id > 0) {

                        if ($array_config['allow_auto_code']) {
                            $auto_code = '';
                            if (empty($row['code'])) {
                                $i = 1;
                                $format_code = !empty($array_config['code_format']) ? $array_config['code_format'] : 'T%06s';
                                $auto_code = vsprintf($format_code, $new_id);

                                $stmt = $db->prepare('SELECT id FROM ' . NV_PREFIXLANG . '_' . $mod_data . '_rows WHERE code= :code');
                                $stmt->bindParam(':code', $auto_code, PDO::PARAM_STR);
                                $stmt->execute();
                                while ($stmt->rowCount()) {
                                    $i++;
                                    $auto_code = vsprintf($format_code, ($new_id + $i));
                                }

                                $stmt = $db->prepare('UPDATE ' . NV_PREFIXLANG . '_' . $mod_data . '_rows SET code= :code WHERE id=' . $new_id);
                                $stmt->bindParam(':code', $auto_code, PDO::PARAM_STR);
                                $stmt->execute();
                            }
                        }

                        $sth = $db->prepare('INSERT INTO ' . NV_PREFIXLANG . '_' . $mod_data . '_images (rowsid, path, description, is_main, weight) VALUES(:rowsid, :path, "", 1, :weight)');
                        $sth->bindParam(':rowsid', $new_id, PDO::PARAM_INT);
                        $sth->bindParam(':path', $row['homeimgfile'], PDO::PARAM_STR);

                        $weight = $db->query('SELECT max(weight) FROM ' . NV_PREFIXLANG . '_' . $mod_data . '_images WHERE rowsid=' . $new_id)->fetchColumn();
                        $weight = intval($weight) + 1;
                        $sth->bindParam(':weight', $weight, PDO::PARAM_INT);
                        $sth->execute();

                        // cập nhật ảnh đại diện
                        list ($row['homeimgfile'], $row['homeimgalt']) = $db->query('SELECT path, description FROM ' . NV_PREFIXLANG . '_' . $mod_data . '_images WHERE rowsid=' . $new_id . ' AND is_main=1')->fetch(3);
                        if ($row['homeimgfile']) {
                            $row['homeimgthumb'] = 0;
                            if (!nv_is_url($row['homeimgfile']) and nv_is_file(NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $mod_upload . '/' . $row['homeimgfile'], NV_UPLOADS_DIR . '/' . $module_upload) === true) {
                                if (file_exists(NV_ROOTDIR . '/' . NV_FILES_DIR . '/' . $mod_upload . '/' . $row['homeimgfile'])) {
                                    $row['homeimgthumb'] = 1;
                                } else {
                                    $row['homeimgthumb'] = 2;
                                }
                            } elseif (nv_is_url($row['homeimgfile'])) {
                                $row['homeimgthumb'] = 3;
                            } else {
                                $row['homeimgfile'] = '';
                            }
                            $sth = $db->prepare('UPDATE ' . NV_PREFIXLANG . '_' . $mod_data . '_rows SET homeimgfile=:homeimgfile, homeimgalt=:homeimgalt, homeimgthumb=:homeimgthumb WHERE id=' . $new_id);
                            $sth->bindParam(':homeimgfile', $row['homeimgfile'], PDO::PARAM_STR);
                            $sth->bindParam(':homeimgalt', $row['homeimgalt'], PDO::PARAM_STR);
                            $sth->bindParam(':homeimgthumb', $row['homeimgthumb'], PDO::PARAM_INT);
                            $sth->execute();
                        }

                        // thêm vào tùy biến dữ liệu
                        if (isset($array_market_cat[$row['catid']]) and $array_market_cat[$row['catid']]['form'] != '') {
                            $db->query('INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_info (rowid) VALUES (' . $new_id . ')');
                        }

                        // thêm vào bảng detail
                        $maps = !empty($row['maps']) ? serialize($row['maps']) : '';
                        $stmt = $db->prepare('INSERT INTO ' . NV_PREFIXLANG . '_' . $mod_data . '_detail (id, content, maps, display_maps, note, groupcomment, contact_fullname, contact_email, contact_phone, contact_address) VALUES (:id, :content, :maps, :display_maps, :note, :groupcomment, :contact_fullname, :contact_email, :contact_phone, :contact_address)');
                        $stmt->bindParam(':id', $new_id, PDO::PARAM_INT);
                        $stmt->bindParam(':content', $row['content'], PDO::PARAM_STR, strlen($row['content']));
                        $stmt->bindParam(':maps', $maps, PDO::PARAM_STR);
                        $stmt->bindParam(':display_maps', $row['display_maps'], PDO::PARAM_INT);
                        $stmt->bindParam(':note', $row['note'], PDO::PARAM_STR);
                        $stmt->bindParam(':groupcomment', $row['groupcomment'], PDO::PARAM_STR);
                        $stmt->bindParam(':contact_fullname', $row['contact_fullname'], PDO::PARAM_STR);
                        $stmt->bindParam(':contact_email', $row['contact_email'], PDO::PARAM_STR);
                        $stmt->bindParam(':contact_phone', $row['contact_phone'], PDO::PARAM_STR);
                        $stmt->bindParam(':contact_address', $row['contact_address'], PDO::PARAM_STR);
                        $stmt->execute();

                        // Xóa cache module
                        $nv_Cache->delMod($module);
                    } else {
                        $error[] = $lang_module['error_post_save'];
                    }
                }
            }
        }
    }

    return implode(', ', $error);
}

function nv_autoget_listnews($items_id, $module = '', $is_auto = 0)
{
    global $db, $db_config, $lang_module, $module_name, $module_data, $module_file, $module_upload, $site_mods, $sys_info, $global_config;

    if (empty($items_id)) return false;

    if ($sys_info['allowed_set_time_limit']) {
        set_time_limit(0);
    }

    $items_info = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items WHERE id=' . $items_id . ' AND status=1')->fetch();
    $get_info = array(
        'status' => 0,
        'num' => 0,
        'queue' => $items_info['queue'],
        'lasttime' => $items_info['lasttime']
    );

    if (!empty($items_info)) {
        $array_data = array();
        $groups_info = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_groups WHERE id=' . $items_info['groups_id'])->fetch();
        if ($groups_info['type'] == 0) {
            $getContent = new NukeViet\Client\UrlGetContents($global_config);
            $xml_source = $getContent->get($items_info['url']);
            $allowed_html_tags = array_map('trim', explode(',', NV_ALLOWED_HTML_TAGS));
            $allowed_html_tags = '<' . implode('><', $allowed_html_tags) . '>';
            if ($xml = simplexml_load_string($xml_source)) {
                $i = 0;
                $array = array();
                if (isset($xml->channel)) {
                    foreach ($xml->channel->item as $item) {
                        // kiểm tra url đã lấy tin chưa
                        $array['container_list_url'] = strip_tags($item->link);
                        $count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows WHERE url_md5=' . $db->quote(md5($array['container_list_url'])))
                            ->fetchColumn();
                        if ($count > 0) {
                            continue;
                        }

                        $array['container_list_title'] = strip_tags($item->title);
                        $array['container_list_hometext'] = strip_tags($item->description);

                        $array['container_list_homeimage'] = '';
                        $array['container_list_homeimagealt'] = '';

                        /*
                         * if (preg_match('/< *img[^>]*src *= *["\']?([^"\']*)/i', $item->description, $m)) {
                         * $array['container_list_homeimage'] = $m[1];
                         * }
                         */

                        $array = array_map('trim', $array);
                        $array_data[$i] = $array;

                        ++$i;
                        if ($i >= $items_info['save_limit']) {
                            break;
                        }
                    }
                } elseif (isset($xml->entry)) {
                    foreach ($xml->entry as $item) {
                        $urlAtt = $item->link->attributes();

                        // kiểm tra url đã lấy tin chưa
                        $array['container_list_url'] = strip_tags($urlAtt['href']);
                        $count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows WHERE url_md5=' . $db->quote(md5($array['container_list_url'])))
                            ->fetchColumn();
                        if ($count > 0) {
                            continue;
                        }

                        $array['container_list_title'] = strip_tags($item->title);
                        $array['container_list_hometext'] = strip_tags($item->content, $allowed_html_tags);

                        $array['container_list_homeimage'] = '';
                        $array['container_list_homeimagealt'] = '';

                        /*
                         * if (preg_match('/< *img[^>]*src *= *["\']?([^"\']*)/i', $item->description, $m)) {
                         * $array['container_list_homeimage'] = $m[1];
                         * }
                         */

                        $array = array_map('trim', $array);
                        $array_data[$i] = $array;

                        ++$i;
                        if ($i >= $items_info['save_limit']) {
                            break;
                        }
                    }
                }
            }
        } elseif ($groups_info['type'] == 1) {
            $files_path = NV_ROOTDIR . '/' . NV_TEMP_DIR . '/' . md5($items_info['url']) . '.html';
            if (!filter_var($items_info['url'], FILTER_VALIDATE_URL) === false) {
                $userAgents = array( //
                    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5 (.NET CLR 3.5.30729)', //
                    'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', //
                    'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)', //
                    'Mozilla/4.8 [en] (Windows NT 6.0; U)', //
                    'Opera/9.25 (Windows NT 6.0; U; en)'
                );
                srand((float) microtime() * 10000000);
                $rand = array_rand($userAgents);
                $agent = $userAgents[$rand];

                $agent = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1) Gecko/20090624 Firefox/3.5 (.NET CLR 3.5.30729)';

                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $items_info['url']);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
                $safe_mode = (ini_get('safe_mode') == '1' || strtolower(ini_get('safe_mode')) == 'on') ? 1 : 0;
                $open_basedir = @ini_get('open_basedir') ? true : false;
                if (!$safe_mode and !$open_basedir) {
                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
                    curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
                }
                curl_setopt($ch, CURLOPT_TIMEOUT, 20);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_USERAGENT, $agent);
                $html = curl_exec($ch);
                $curl_error = trim(curl_error($ch));
                curl_close($ch);
                file_put_contents($files_path, $html);

                if (file_exists($files_path) and !empty($groups_info)) {
                    require_once NV_ROOTDIR . '/modules/' . $module_file . '/simple_html_dom.php';
                    $html = file_get_html($files_path);
                    if (empty($html)) {
                        $msg = $items_info['title'] . ': ' . $lang_module['error_empty_html'];
                        nv_item_error_action($items_id, $msg);
                    } else {
                        // Giải mã ký tự đặc biệt
                        $groups_info['container_list_outside'] = nv_unhtmlspecialchars($groups_info['container_list_outside']);
                        $groups_info['container_list_title'] = nv_unhtmlspecialchars($groups_info['container_list_title']);
                        $groups_info['container_list_hometext'] = nv_unhtmlspecialchars($groups_info['container_list_hometext']);
                        $groups_info['container_list_homeimage'] = nv_unhtmlspecialchars($groups_info['container_list_homeimage']);
                        $groups_info['container_list_url'] = nv_unhtmlspecialchars($groups_info['container_list_url']);

                        // Nhận diện Thẻ bao ngoài
                        $i = 0;
                        foreach ($html->find($groups_info['container_list_outside']) as $key => $container_list_outside) {
                            ++$i;
                            $array = array();

                            // So sánh URL trong CSDL, nếu chưa có thì mới lấy thông tin
                            $container = nv_get_anchor($groups_info['container_list_url']);
                            $array['container_list_url'] = $container_list_outside->find($container['element'], $container['anchor'])->href;
             if (!preg_match('/^http(.*?)$/', $array['container_list_url'], $m)) {
                                if (preg_match('/^\/(.*?)$/', $array['container_list_url'])) {
                                    $array['container_list_url'] = $groups_info['url'] . $array['container_list_url'];
                                } else {
                                    $array['container_list_url'] = $groups_info['url'] . '/' . $array['container_list_url'];
                                }
                            }

                            $count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows WHERE url_md5=' . $db->quote(md5($array['container_list_url'])))
                                ->fetchColumn();
                            if ($count == 0) {
                                $container = nv_get_anchor($groups_info['container_list_title']);
                                $array['container_list_title'] = $container_list_outside->find($container['element'], $container['anchor']) ? strip_tags(nv_convert_unicode($container_list_outside->find($container['element'], $container['anchor'])->innertext())) : ''; // Lấy tiêu đề
                                if (!empty($array['container_list_title'])) {
                                    $array['container_list_hometext'] = '';
                                    $array['container_list_homeimage'] = '';
                                    $array['container_list_homeimagealt'] = '';
                                    if (!empty($groups_info['container_list_hometext'])) {
                                        $container = nv_get_anchor($groups_info['container_list_hometext']);
                                        $array['container_list_hometext'] = $container_list_outside->find($container['element'], $container['anchor']) ? nv_strip_tags_content(nv_convert_unicode($container_list_outside->find($container['element'], $container['anchor'])->innertext())) : ''; // Lấy giới thiệu ngắn gọn

                                        // Lọc bỏ html trong giới thiệu ngắn gọn
                                        $array['container_list_hometext'] = strip_tags($array['container_list_hometext']);
                                    }

                                    if (!empty($groups_info['container_list_homeimage'])) {
                                        $container = nv_get_anchor($groups_info['container_list_homeimage']);
                                        $array['container_list_homeimage'] = isset($container_list_outside->find($container['element'], $container['anchor'])->src) ? $container_list_outside->find($container['element'], $container['anchor'])->src : ''; // Lấy ảnh minh họa
                                        $parse = parse_url($array['container_list_homeimage']);
                                        if (!empty($array['container_list_homeimage']) and !isset($parse['host'])) {
                                            $array['container_list_homeimage'] = $groups_info['url'] . $array['container_list_homeimage'];
                                        }

                                        $array['container_list_homeimagealt'] = isset($container_list_outside->find($container['element'], $container['anchor'])->alt) ? nv_convert_unicode($container_list_outside->find($container['element'], $container['anchor'])->alt) : ''; // Mô tả ảnh minh họa
                                    }

                                    $array = array_map('trim', $array);
                                    $array_data[$key] = $array;
                                } else {
                                    --$i;
                                }
                            }
                            if ($i == $items_info['save_limit']) {
                                break;
                            }
                        }
                    }
                }
            }
        }

        if (!empty($array_data)) {
            $get_info['num'] = sizeof($array_data);
            $array_data = array_reverse($array_data);
            foreach ($array_data as $data) {
                // Thêm vào CSDL
                if (!empty($data['container_list_url']) and !empty($data['container_list_title'])) {
                    try {
                        $status = 1;
                        if ($items_info['queue']) {
                            $status = 0;
                        }
                        $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows
								(title, url, url_md5, items_id, addtime, status) VALUES(:title, :url, :url_md5, :items_id, ' . NV_CURRENTTIME . ', :status)';

                        $data_insert = array();
                        $data_insert['title'] = $data['container_list_title'];
                        $data_insert['url'] = $data['container_list_url'];
                        $data_insert['url_md5'] = md5($data['container_list_url']);
                        $data_insert['items_id'] = $items_id;
                        $data_insert['status'] = $status;
                        $data['id'] = $db->insert_id($sql, 'id', $data_insert);
                        if ($data['id']) {
                            // Đăng tin nếu cấu hình là không kiểm duyệt tin
                            if ($status) {
                                $nv_autoget_detail = nv_autoget_detail($data['id']);
                                if (empty($nv_autoget_detail)) {
                                    $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_rows SET status=1 WHERE id=' . $data['id']);
                                    $get_info['status'] = 1;
                                }
                            }
                            $get_info['status'] = 1;
                        }
                    } catch (PDOException $e) {
                        trigger_error($e->getMessage());
                    }
                }
            }

            // Thêm thông báo kiểm duyệt
            if (!$status and $is_auto) {
                nv_insert_notification($module_name, 'news_queue', array(
                    'num' => $get_info['num']
                ));
            }
        } else {
            $get_info['status'] = 1;
        }

        // Cập nhật thời gian thực hiện
        $get_info['lasttime'] = NV_CURRENTTIME;
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_crawler_items SET lasttime=' . NV_CURRENTTIME . ' WHERE id=' . $items_id);
    }

    return $get_info;
}

function nv_item_error_action($itemid, $msg)
{
    global $db, $module_data, $module_name, $array_config;

    // thêm vào thông báo
    nv_insert_notification($module_name, 'item_error', array(
        'content' => $msg
    ), $itemid);

    // ngưng kích hoạt nguồn tin
    if ($array_config['stop_if_error']) {
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_items SET status=0 WHERE id=' . $itemid);
    }
}
