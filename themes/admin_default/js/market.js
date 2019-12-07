/**
 * @Project NUKEVIET 4.x
 * @Author mynukeviet (contact@mynukeviet.net)
 * @Copyright (C) 2016 mynukeviet. All rights reserved
 * @Createdate Sun, 20 Nov 2016 07:31:04 GMT
 */

$(document).ready(function() {
    $('.loading').click(function() {
        if ($.validator) {
            var valid = $(this).closest('form').valid();
            if (valid) {
                $('body').append('<div class="ajax-load-qa"></div>');
            }
        } else {
            var valid = $(this).closest('form').find('input:invalid').length;
            if (valid == 0) {
                $('body').append('<div class="ajax-load-qa"></div>');
            }
        }
    });
    
    $('.action').click(function() {
        var id = $(this).data('id');
        var action = $(this).data('action');
        if (confirm(nv_is_change_act_confirm[0])) {
            $('#ajax_loader').css('display', 'block');
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler&nocache=' + new Date().getTime(), 'change_status=1&action=' + action + '&id=' + id, function(res) {
                var r_split = res.split('_');
                if (r_split[0] != 'OK') {
                    alert(nv_is_change_act_confirm[2]);
                } else {
                    if (action == 'acept') {
                        $('#rows_' + r_split[1]).removeAttr('class');
                        $('#status_' + r_split[1]).html(LANG['status_1']);
                        $('#action_' + r_split[1]).html('<a href="#" data-id="{VIEW.id}" class="action" data-action="acept" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_repost}"><em class="fa fa-circle-o-notch fa-lg fa-point">&nbsp;</em></a>');
                    } else {
                        $('#rows_' + r_split[1]).removeAttr('class');
                        $('#rows_' + r_split[1]).addClass('success');
                        $('#status_' + r_split[1]).html(LANG['status_2']);
                        $('#action_' + r_split[1]).html('<a href="#" data-id="{VIEW.id}" class="action" data-action="acept" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_acept}"><em class="fa fa-save fa-lg fa-point">&nbsp;</em></a>');
                    }
                }
                window.location.href = window.location.href;
            });
        }
        return false;
    });
    
    $('.fetch').click(function() {
        var id = $(this).data('id');
        if (confirm(LANG.action_fetch_confirm)) {
            $('#ajax_loader').css('display', 'block');
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler-source&nocache=' + new Date().getTime(), 'fetch=1&id=' + id, function(res) {
                var r_split = res.split('_');
                if (r_split[0] != 'OK') {
                    alert(LANG.action_fetch_error);
                } else {
                    var obj = jQuery.parseJSON(r_split[1]);
                    if (obj['num'] == 0) {
                        alert(LANG.action_fetch_success_empty);
                    } else {
                        alert(LANG.action_fetch_success_ok + ': ' + obj['num']);
                        window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&status=' + (obj['queue'] == 0 ? 1 : 0);
                    }
                }
                $('#ajax_loader').css('display', 'none');
            });
        }
        return false;
    });
});

function nv_list_action(action, url_action, del_confirm_no_post) {
    var listall = [];
    $('input.post:checked').each(function() {
        listall.push($(this).val());
    });
    if (listall.length < 1) {
        alert(del_confirm_no_post);
        return false;
    }
    if (action == 'delete_list_id') {
        if (confirm(nv_is_del_confirm[0])) {
            $.ajax({
                type : 'POST',
                url : url_action,
                data : 'delete_list=1&listall=' + listall,
                success : function(data) {
                    var r_split = data.split('_');
                    if (r_split[0] == 'OK') {
                        window.location.href = window.location.href;
                    } else {
                        alert(nv_is_del_confirm[2]);
                    }
                }
            });
        }
    } else if (action == 'is_queue') {
        if (confirm(nv_is_queue_confirm)) {
            $.ajax({
                type : 'POST',
                url : url_action,
                data : 'change_queue=1&listall=' + listall,
                success : function(data) {
                    var r_split = data.split('_');
                    if (r_split[0] == 'OK') {
                        window.location.href = window.location.href;
                    } else {
                        alert(nv_is_queue_confirm_2);
                    }
                }
            });
        }
    } else if (confirm(nv_is_change_act_confirm[0])) {
        $('#ajax_loader').css('display', 'block');
        $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler&nocache=' + new Date().getTime(), 'change_status=1&action=' + action + '&listid=' + listall, function(res) {
            var r_split = res.split('_');
            if (r_split[0] != 'OK') {
                alert(nv_is_change_act_confirm[2]);
            } else {
                var obj = jQuery.parseJSON(r_split[1]);
                $.each(obj, function(index, value) {
                    if (action == 'acept') {
                        $('#rows_' + value).removeAttr('class');
                        $('#status_' + value).html(LANG['status_1']);
                        $('#action_' + value).html('<a href="#" data-id="{VIEW.id}" class="action" data-action="acept" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_repost}"><em class="fa fa-circle-o-notch fa-lg fa-point">&nbsp;</em></a>');
                    } else {
                        $('#rows_' + value).removeAttr('class');
                        $('#rows_' + value).addClass('success');
                        $('#status_' + value).html(lang_status_2);
                        $('#action_' + value).html('<a href="#" data-id="{VIEW.id}" class="action" data-action="acept" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_acept}"><em class="fa fa-save fa-lg fa-point">&nbsp;</em></a>');
                    }
                    $('input[type=checkbox]').prop('checked', false);
                });
            }
            $('#ajax_loader').css('display', 'none');
        });
    }
    return false;
}

function nv_chang_cat(catid, mod) {
    var nv_timer = nv_settimeout_disable('id_' + mod + '_' + catid, 5000);
    var new_vid = $('#id_' + mod + '_' + catid).val();
    $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=change_cat&nocache=' + new Date().getTime(), 'catid=' + catid + '&mod=' + mod + '&new_vid=' + new_vid, function(res) {
        var r_split = res.split('_');
        if (r_split[0] != 'OK') {
            alert(nv_is_change_act_confirm[2]);
        }
        clearTimeout(nv_timer);
        return;
    });
    return;
}

function nv_del_block_cat(bid) {
    if (confirm(nv_is_del_confirm[0])) {
        $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=groups&nocache=' + new Date().getTime(), 'del_block_cat=1&bid=' + bid, function(res) {
            var r_split = res.split('_');
            if (r_split[0] == 'OK') {
                nv_show_list_block_cat();
            } else if (r_split[0] == 'ERR') {
                alert(r_split[1]);
            } else {
                alert(nv_is_del_confirm[2]);
            }
        });
    }
    return false;
}

function nv_chang_block_cat(bid, mod) {
    var nv_timer = nv_settimeout_disable('id_' + mod + '_' + bid, 5000);
    var new_vid = $('#id_' + mod + '_' + bid).val();
    $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=chang_block_cat&nocache=' + new Date().getTime(), 'bid=' + bid + '&mod=' + mod + '&new_vid=' + new_vid, function(res) {
        var r_split = res.split('_');
        if (r_split[0] != 'OK') {
            alert(nv_is_change_act_confirm[2]);
        }
        clearTimeout(nv_timer);
        nv_show_list_block_cat();
    });
    return;
}

function nv_show_list_block_cat() {
    if (document.getElementById('module_show_list')) {
        $('#module_show_list').load(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=list_block_cat&nocache=' + new Date().getTime());
    }
    return;
}

function nv_chang_block(bid, id, mod) {
    if (mod == 'delete' && !confirm(nv_is_del_confirm[0])) {
        return false;
    }
    var nv_timer = nv_settimeout_disable('id_weight_' + id, 5000);
    var new_vid = $('#id_weight_' + id).val();
    $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=change_block&nocache=' + new Date().getTime(), 'id=' + id + '&bid=' + bid + '&mod=' + mod + '&new_vid=' + new_vid, function(res) {
        nv_chang_block_result(res);
    });
    return;
}

function nv_chang_block_result(res) {
    var r_split = res.split('_');
    if (r_split[0] != 'OK') {
        alert(nv_is_change_act_confirm[2]);
    }
    var bid = parseInt(r_split[1]);
    nv_show_list_block(bid);
    return;
}

function nv_show_list_block(bid) {
    if (document.getElementById('module_show_list')) {
        $('#module_show_list').load(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=list_block&bid=' + bid + '&nocache=' + new Date().getTime());
    }
    return;
}

function nv_del_block_list(oForm, bid, del_confirm_no_post) {
    var del_list = '';
    var fa = oForm['idcheck[]'];
    if (fa.length) {
        for (var i = 0; i < fa.length; i++) {
            if (fa[i].checked) {
                del_list = del_list + ',' + fa[i].value;
            }
        }
    } else {
        if (fa.checked) {
            del_list = del_list + ',' + fa.value;
        }
    }
    
    if (del_list != '') {
        if (confirm(nv_is_del_confirm[0])) {
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=change_block&nocache=' + new Date().getTime(), 'del_list=' + del_list + '&bid=' + bid, function(res) {
                nv_chang_block_result(res);
            });
        }
    } else {
        alert(del_confirm_no_post);
    }
}

function nv_chang_cat(catid, mod) {
    var nv_timer = nv_settimeout_disable('id_' + mod + '_' + catid, 5000);
    var new_vid = $('#id_' + mod + '_' + catid).val();
    $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=change_cat&nocache=' + new Date().getTime(), 'catid=' + catid + '&mod=' + mod + '&new_vid=' + new_vid, function(res) {
        var r_split = res.split('_');
        if (r_split[0] != 'OK') {
            alert(nv_is_change_act_confirm[2]);
        }
        
        clearTimeout(nv_timer);
        return;
    });
    return;
}

function nv_search_tag(tid) {
    $("#module_show_list").html('<p class="text-center"><img src="' + nv_base_siteurl + 'assets/images/load_bar.gif" alt="Waiting..."/></p>').load(script_name + "?" + nv_lang_variable + "=" + nv_lang_data + "&" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=tags&q=" + rawurlencode($("#q").val()) + "&num=" + nv_randomPassword(10));
    return false;
}

function nv_del_tags(tid) {
    if (confirm(nv_is_del_confirm[0])) {
        $("#module_show_list").html('<p class="text-center"><img src="' + nv_base_siteurl + 'assets/images/load_bar.gif" alt="Waiting..."/></p>').load(script_name + "?" + nv_lang_variable + "=" + nv_lang_data + "&" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=tags&del_tid=" + tid + "&num=" + nv_randomPassword(10));
    }
    return false;
}

function nv_del_check_tags(oForm, checkss, msgnocheck) {
    var fa = oForm['idcheck[]'];
    var listid = '';
    if (fa.length) {
        for (var i = 0; i < fa.length; i++) {
            if (fa[i].checked) {
                listid = listid + fa[i].value + ',';
            }
        }
    } else {
        if (fa.checked) {
            listid = listid + fa.value + ',';
        }
    }
    
    if (listid != '') {
        if (confirm(nv_is_del_confirm[0])) {
            $("#module_show_list").html('<p class="text-center"><img src="' + nv_base_siteurl + 'assets/images/load_bar.gif" alt="Waiting..."/></p>').load(script_name + "?" + nv_lang_variable + "=" + nv_lang_data + "&" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=tags&q=" + rawurlencode($("#q").val()) + "&del_listid=" + listid + "&checkss=" + checkss + "&num=" + nv_randomPassword(10));
        }
    } else {
        alert(msgnocheck);
    }
    
    return false;
}

function nv_post_facebook(id) {
    if (confirm(facebook_post_confirm)) {
        $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(), 'facebook=1&id=' + id, function(res) {
            var r_split = res.split('_');
            if (r_split[0] != 'OK') {
                alert(r_split[1]);
            } else {
                alert(post_facebook_success);
            }
        });
    }
}

function nv_refresh(rowsid, checkss) {
    if (confirm(lang_refresh_confirm)) {
        $.post(nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(), 'refresh=1&id=' + rowsid + '&checkss=' + checkss, function(res) {
            var r_split = res.split('_');
            if (r_split[0] != 'OK') {
                alert(r_split[1]);
            } else {
                alert(r_split[1]);
                window.location.href = window.location.href;
            }
        });
    }
}

function nv_price_control() {
    if ($('#pricetype').val() != 0) {
        $('#price, #price1, #unitid').prop('disabled', true);
    } else {
        $('#price, #price1, #unitid').prop('disabled', false);
    }
}

function nv_market_cat_change(id, catid) {
    // hiển thị các trường tùy biến dữ liệu cho chủ đề
    $.ajax({
        type : 'POST',
        data : 'get_custom_field=1&id=' + id + '&catid=' + catid,
        url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
        success : function(html) {
            $('#custom_form').html(html);
        }
    });
}

function nv_list_groups_action(action, url_action, del_confirm_no_post) {
    var listall = [];
    $('input.post:checked').each(function() {
        listall.push($(this).val());
    });
    
    if (listall.length < 1) {
        alert(del_confirm_no_post);
        return false;
    }
    
    if (action == 'delete') {
        if (confirm(nv_is_del_confirm[0])) {
            $.ajax({
                type : 'POST',
                url : url_action,
                data : 'delete_list=1&listall=' + listall,
                success : function(data) {
                    var r_split = data.split('_');
                    if (r_split[0] == 'OK') {
                        window.location.href = window.location.href;
                    } else {
                        alert(nv_is_del_confirm[2]);
                    }
                }
            });
        }
    } else if (action == 'rewrite' || action == 'reupdate') {
        $('#ajax_loader').css('display', 'block');
        $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=groups&nocache=' + new Date().getTime(), action + '=1&listid=' + listall, function(res) {
            alert(res);
            window.location.href = window.location.href;
        });
        $('#ajax_loader').css('display', 'none');
    }
    
    return false;
}

function nv_list_items_action(action, url_action, del_confirm_no_post) {
    var listall = [];
    $('input.post:checked').each(function() {
        listall.push($(this).val());
    });
    
    if (listall.length < 1) {
        alert(del_confirm_no_post);
        return false;
    }
    
    if (action == 'delete') {
        if (confirm(nv_is_del_confirm[0])) {
            $.ajax({
                type : 'POST',
                url : url_action,
                data : 'delete_list=1&listall=' + listall,
                success : function(data) {
                    var r_split = data.split('_');
                    if (r_split[0] == 'OK') {
                        window.location.href = window.location.href;
                    } else {
                        alert(nv_is_del_confirm[2]);
                    }
                }
            });
        }
    } else if (action == 'fetch') {
        if (confirm(LANG.action_fetch_confirm)) {
            $('#ajax_loader').css('display', 'block');
            $.post(url_action + '&nocache=' + new Date().getTime(), 'fetch=1&listid=' + listall, function(res) {
                var r_split = res.split('_');
                if (r_split[0] != 'OK') {
                    alert(LANG.action_fetch_error);
                } else {
                    if (r_split[1] == 0) {
                        alert(LANG.action_fetch_success_empty);
                    } else {
                        alert(LANG.action_fetch_success_ok + ': ' + r_split[1]);
                        window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name;
                    }
                }
                $('#ajax_loader').css('display', 'none');
            });
        }
    }
    
    return false;
}

function nv_items_change_timer(items_id) {
    var nv_timer = nv_settimeout_disable('id_timer_' + items_id, 5000);
    var new_vid = $('#id_timer_' + items_id).val();
    $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler-source&change_timer=1&nocache=' + new Date().getTime(), 'items_id=' + items_id + '&new_vid=' + new_vid, function(res) {
        var r_split = res.split('_');
        if (r_split[0] != 'OK') {
            alert(r_split[1]);
        }
        clearTimeout(nv_timer);
    });
    return;
}