var CITIES = WARDS = DISTRICTS = null;
var activityTimeout = null;

$(document).ready(function() {
    // iOS web app full screen hacks.
    if(window.navigator.standalone == true) {
        $("a:not([href^='#'],[rel='fancybox'])").click(function() {
            window.location = $(this).attr('href');
            return false;
        });
    }
    $('#menu-bar').click(function(e){
        e.preventDefault();
        $('#nav-menu-container').toggleClass('open');
        $('#overlay-mn').toggleClass('show');
    });
    $('#overlay-mn').click(function(e){
        $('#nav-menu-container').removeClass('open');
        $('#overlay-mn').removeClass('show');
    });
 

    $('img.lazy:not(src)').lazy();

    $('form').each(function() {
        var $frm = $(this);
        $('.inputmask', $frm).inputmask();
        $('.btn-group-toggle label', $frm).click(function() {
            $(this).parent().find('label').removeClass('active');
            $(this).addClass('active');
        });
        $('.input-file input[type=file]', $frm).change(function () {
            var input = $(this);
            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            parent = $(input).closest('.input-file');
            $('input[type=text]', parent).val(label);
        });
    });

  
    if(typeof FRONT_END != "undefined" && FRONT_END==true) {
        $('#user_menu').load(ROOT_URL + '/checkauth');
        initBoxSearch();
        $.ajax({
            cache: true,
            type: "GET",
            dataType: "script",
            url:'https://cdn.onesignal.com/sdks/OneSignalSDK.js',
            success: function() {
                var OneSignal = window.OneSignal || [];
                OneSignal.push(function() {
                    OneSignal.init({
                        autoResubscribe: true,
                        appId: "89b702d8-e8bc-482b-bd3c-1c9427c526fa"
                    });
                    reg = $.cookie('reg_notify');
                    if(!reg) {
                        OneSignal.getUserId(function(userId) {
                            $.ajax({
                                type: 'GET',
                                url:  ROOT_URL + '/checkauth?token='+userId
                            });
                        });
                        $.cookie('reg_notify', 1, { expires: 2 });
                    }
                });
            }
        });
        // delay load dynamic ads after 3 seconds
        setTimeout(function() {
            $('#product_box_ads').load(BASE_URL+'/frontend/product/ads?'+$('#product_box_ads').data('url'));
            $('#popup_slideup').load(BASE_URL+'/frontend/product/popupslideup');
        }, 2000);


        $('#regionCity').click(function () {
            $('#regionLocation').toggleClass('hidden');
        });

        var $menu = $('#stack-menu');
        if($menu) {
            $menu.stackMenu();
            focus_id = $('#input_region').val();
            if(focus_id) {
                if($select = $('a[data-id='+focus_id+']', $menu)) {
                    $sp = $select.closest('.stack-menu__list').prev('a');
                    if($sp1 = $sp.closest('.stack-menu__list').prev('a')) {
                        $sp1.trigger('click');
                        $sp.trigger('click');
                    } else {
                        $sp.trigger('click');
                    }
                }
            }
            $('a', $menu).click(function () {
                var regionName = $(this).text();
                $(this).addClass('active');
                if ($(this).hasClass('item_end')) {
                    $('#regionLocation').toggleClass('hidden');
                    if ($(this).data('name'))
                        regionName = $(this).data('name');
                    $('#regionCity .city-name').text(regionName);
                    var form_name = $(this).data('key');
                    var id_val = $(this).data('id');
                    $('#input_region').attr('name', form_name);
                    $('#input_region').val(id_val);
                } else {
                    $('.stack-menu__link--back', $menu).text(regionName);
                }
            });
        }
    }

    $('.nav-tabs-custom').each(function() {
        $tab = $(this);
        $tab.on('click','.nav-tabs a',function (e) {
            e.preventDefault();
            var url = $(this).attr("data-url");
            if (typeof url !== "undefined") {
                var pane = $(this);
                var $div_content = $(this.hash);
                // ajax load from data-url
                $div_content.load(url,function(result){
                    initAjaxNav($div_content);
                    pane.tab('show');
                    return false;
                });
            } else {
                $(this).tab('show');
            }
            return false;
        });
        $('.nav-tabs .active a', $tab).trigger('click');
    });
    $('#scrollTopButton').click(function () {
        $('body,html').animate({scrollTop: 0}, 500);
        return false;
    });
});

$( document ).resize(function() {
    initMyScrollNav();
})

$( document ).ajaxComplete(function() {
    if(window.navigator.standalone == true) {
        $("a:not([href^='#'],[rel='fancybox'])").click(function() {
            window.location = $(this).attr('href');
            return false;
        });
    }
    $('img.lazy:not(src)').lazy({combined: true, delay:4000});
});

var frmSubmit = false;
function submitCustomer(frm) {
    $.ajax({
        method: 'POST',
        url: $(frm).attr('action'),
        dataType: 'JSON',
        data: $(frm).serialize()
    }).done(function(res) {
        if (res.success) {
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        closeFormInquiry();
                        if (popUp = $.fancybox.getInstance())
                            popUp.close();
                        reloadCustomer(res.url);
                    }
                }
            });

        } else if (res.error){
            $.alert(res.message);
        }
    });
    return false;
}

function delCustomer(action, id, pid) {
    var url = '';
    if (pid != 0)
        url = '?pid='+pid;
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/my/customers'+url,
        dataType: 'JSON',
        data: {'id':id, 'action': action, 'pid': pid}
    }).done(function(res) {
        if(res.status) {
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        reloadCustomer(res.url);
                    }
                }
            });
        }
    });
    return false;
}

function reloadCustomer(url) {
    var $div = $('#project #tab2');
    if ($div.length > 0) {
        $div.load(url, function () {
            $('#project a[href="#tab2"]').tab('show');
            return false;
        });
    } else {
        location.reload();
    }
}

function loadFormImportCustomer(pid) {
    $.fancybox.open({
        src: BASE_URL+'/my/customers?popup=2&pid='+pid,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
    });
}

function loadFormAddCustomer (id, pid, phone) {
    $.fancybox.open({
        src: BASE_URL+'/my/customers?popup=1&customer='+id+'&pid='+pid+'&phone=0'+phone,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
    });
}

function fancyboxLoadMap (id) {
    $.fancybox.open({
        src: BASE_URL+'/frontend/product/loadmap?id='+id,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
        touch: false
    });
}

function loadFormSendMail (url) {
    $.fancybox.open({
        src: BASE_URL+'/send-mail-friend?url='+url,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
        touch: false
    });
}
function tinChinhChu (id) {
    $.fancybox.open({
        src: BASE_URL+'/my/tinchinhchu?id='+id,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
    });
}
function loadFancyboxForm (url) {
    $.fancybox.open({
        src: url,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
        touch: false,
    });
}
function loadFormChat(post_id) {
    $.fancybox.open({
        src: BASE_URL+'/frontend/product/chatwithmember?post_id='+post_id,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
        touch: false
    });
}
function sendChat(frm) {
    $.ajax({
        method: 'POST',
        url: $(frm).attr('action'),
        dataType: 'JSON',
        data: $(frm).serialize()
    }).done(function(res) {
        if (res.success) {
            if (frmSubmit == true) return false;
            frmSubmit = true;
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        location.reload();
                    }
                }
            });

        } else if (res.error){
            $.alert(res.message);
        }
    });
    return false;
}

function sendMailFriend(frm) {
    $.ajax({
        method: 'POST',
        url: $(frm).attr('action'),
        dataType: 'JSON',
        data: $(frm).serialize()
    }).done(function(res) {
        if (res.success) {
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        location.reload();
                    }
                }
            });

        } else if (res.error){
            $.alert(res.message);
        }
    });
    return false;
}

function saveClipboard(input) {
    $input = $(input);
    $input.focus();
    $input.select();
    document.execCommand('copy');
    $("#copiedText").show().fadeOut(1200);
}

function initAjaxNav(div) {
    $div = $(div);
    $('.pagination a', $div).click(function() {
        url = $(this).attr('href');
        $div.load(url, function () {
            initAjaxNav($div);
        });
        return false;
    });
    return false;
}

function joinProject(frm) {
    $frm = $(frm);
    $.ajax({
        url: BASE_URL + '/my/dang-ky-cong-tac-vien',
        dataType: 'JSON',
        method: 'POST',
        data: $frm.serialize()
    }).done(function (res) {
        if (res.success) {
            if (frmSubmit == true) return false;
            frmSubmit = true;
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        window.location.href = res.url;
                    }
                }
            });
        } else if (res.error) {
            $.alert(res.message);
        }
    });
    return false;
}

function loadFormRegisterMoneyBorrow () {
    $.fancybox.open({
        src: BASE_URL+'/register-money-borrow?popup=1',
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
    });
}

function initMyScrollNav() {
    if($('#my_actions').length < 1)
        return;
    var outerBottomHeight = 0;
    if ($(window).width() >= 767)
        outerBottomHeight = 65;
    my_h = $(window).height() -   $('#my_navbar').outerHeight() - outerBottomHeight;
    $('#main_menu').slimscroll({
        size: '10px',
        height: my_h+'px',
        position: 'right',
        color: '#ffcc00',
        alwaysVisible: false,
        distance: '0',
        railVisible: true,
        railColor: '#222',
        railOpacity: 0.3,
        wheelStep: 10,
        allowPageScroll: false,
        disableFadeOut: false
    });
}

function inviteFriend() {
    $frm = $('#frmInviteReferral');
    $.ajax({
        method: 'POST',
        url: $frm.attr('action'),
        dataType: 'JSON',
        data: $frm.serialize()
    }).done(function(res) {
        if(res.status==1) {
            // reload member area
            $frm.trigger('reset');
            notifyMessage(res.message);
            $.alert(res.message);
        } else {
            $.alert(res.message);
        }
        return false;
    });
    return false;
}

function searchHousePrice() {
    $frm = $('#frmSearchHousePrice');
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/frontend/product/rehouseprice',
        dataType: 'JSON',
        data: $frm.serialize()
    }).done(function(res) {
        if (res.success) {
            window.location.href = res.url;
        }
        return false;
    });
    return false;
}

function initHomepage() {
    if($('#banner_home').length < 1)
        return;
    $('#banner_slider').owlCarousel({
        items:1,
        loop: true,
        autoplay: true,
        dots: false,
        autoplayTimeout: 3000,
        animateOut: 'fadeOut',
        lazyLoad: true,
        autoHeight: false,
        navText: ["", ""]
    });
    $('.search_form input[name="q"]').click(function(){
        $('#box_search .advance_option').removeClass('hidden');
    });

    $('#box_search select[name=type]').on('change', function () {
        if ($('#box_search select[name=type]').val() == 1) {
            $('#frmBoxSearch').attr('action', BASE_URL+'/thue');
            $.each($('#banner_home .item_types a'), function (url) {
                var href = $(this).attr('href');
                $(this).attr('href', href.replace('mua', 'thue'));
            });
        } else {
            $('#frmBoxSearch').attr('action', BASE_URL+'/mua');
            $.each($('#banner_home .item_types a'), function (url) {
                var href = $(this).attr('href');
                $(this).attr('href', href.replace('thue', 'mua'));
            });
        }
    });
}

function initBoxSearch() {
    if($('#box_product_search').length)
        var $box = $('#box_product_search');
    else if($('#box_search').length)
        $box = $('#box_search');
    else
        return;
    $('.dropdown-menu a', $box).click(function() {
        text = $(this).text();
        value = $(this).data('value');
        bind = $(this).data('bind');
        lbl = $(this).data('text');
        $(lbl).text(text);
        $(bind).val(value);
        $(this).closest('.input-group-btn').removeClass('open');
        return false;
    });
    $('.dropdown-menu').on('click', function(e) {
        $(this).parent().is(".open") && e.stopPropagation();
    });

    $.ajaxSetup({cache:true});
    $.getJSON(ROOT_URL+'/plocations.json', function(data) {
        _CITIES = data.cities;

        // fill data district
        var $objCity = $('[data-bind="city"]', $box);
        var $objDistrict = $('[data-bind="district"]', $box);
        var $objWard = $('[data-bind="ward"]', $box);

        str = "";
        $.each(_CITIES, function(id, ct) {
            str+= '<option value="'+ct.id+'">'+ct.name+'</option>';
        });
        $objCity.append(str).change(function() {
            var cid = $(this).val();
            $objDistrict.find('option:not(:first)').remove();
            $objWard.find('option:not(:first)').remove();
            getLocation(cid, $objDistrict);
        });
        $objDistrict.change(function() {
            var did = $(this).val();
            $objWard.find('option:not(:first)').remove();
            getLocation(did, $objWard);
        });
        if(ctid=$objCity.attr('rel')) {
            $('option[value='+ctid+']', $objCity).attr('selected','selected').trigger('chosen:updated');
            $objCity.trigger('change');
            if(dtid = $objDistrict.attr('rel')) {
                $('option[value='+dtid+']', $objDistrict).attr('selected','selected').trigger('chosen:updated');
                $objDistrict.trigger('change');
            }
            if(wdid = $objWard.attr('rel')) {
                $('option[value='+wdid+']', $objWard).attr('selected','selected').trigger('chosen:updated');
            }
        }
        $('.chosen', $box).chosen({
            width: '100%',
            no_results_text: "Không tìm thấy kết quả",
            disable_search_threshold: 12
        });
    });
}

function loadDBCities() {
    // init db storage
    if(window.localStorage!==undefined) {
        if (CITIES = localStorage.getItem('CITIES'))
            CITIES = JSON.parse(CITIES);
    }
    refresh = $.cookie('db_refresh_locations1');
    if(CITIES === null) {
        $.ajaxSetup({cache:true});
        $.getJSON(ROOT_URL+'/locations.json', function(data) {
            CITIES = data.cities;
            // store data to local storage
            localStorage.setItem('CITIES', JSON.stringify(data.cities));
        });
        $.cookie('db_refresh_locations1', 1, { expires: 7 });
    }
}


function initLocationSelect(frm) {
    var $frm = $(frm);
    var $objCity = $('[data-bind="city"]', $frm);
    var $objDistrict = $('[data-bind="district"]', $frm);
    var $objWard = $('[data-bind="ward"]', $frm);
    loadDBCities();
    if($objCity.find('option').length < 2) {
        str = "";
        $.each(CITIES, function(id, city) {
            str+= '<option value="'+city.id+'">'+city.name+'</option>';
        });
        $objCity.append(str);
        var cid = $objCity.attr('rel');
        if(cid) $('option[value='+cid+']', $objCity).prop('selected', true);
    }

    $objCity.change(function() {
        var cid = $(this).val();
        $objDistrict.find('option:not(:first)').remove();
        $objWard.find('option:not(:first)').remove();
        $("#streets").find('option:not(:first)').remove();
        $("#project").find('option:not(:first)').remove();
        getLocation(cid, $objDistrict);
    });

    $objDistrict.change(function() {
        var did = $(this).val();
        $objWard.find('option:not(:first)').remove();
        $("#project").find('option:not(:first)').remove();
        $("#streets").find('option:not(:first)').remove();
        getLocation(did, $objWard);
    });

    $objCity.trigger('change');
    $('.chosen', $frm).chosen({
        width: '100%',
        no_results_text: "Không tìm thấy kết quả",
        disable_search_threshold: 12
    });

}

function getLocation(id, $obj) {
    if (id) {
        $.ajax({
            method: 'POST',
            url: BASE_URL + '/frontend/product/getlocation',
            dataType: 'JSON',
            data: {'id': id}
        }).done(function (res) {
            if (res.success) {
                $obj.find('option:not(:first)').remove();
                $obj.append(res.data).trigger('chosen:updated');
                if ($obj.attr('rel')) {
                    var dtid = $obj.attr('rel');
                    $('option[value="' + dtid + '"]', $obj).prop('selected', true).trigger('chosen:updated');
                }
                $obj.trigger('change');
            }
        });
    }
    return false;
}

function shareLink(type, url, title) {
    if(typeof url=="undefined")
        url = location.href;
    if(typeof title=="undefined")
        title = document.title;
    switch(type)	{
        case 'facebook':
            window.open('https://www.facebook.com/sharer/sharer.php?u='+url+'&t='+title, 'sharer',',width=980,height=600');
            break;
        case 'twitter':
            window.open('http://twitter.com/intent/tweet?original_referer='+url+'&text='+title+'&url='+url, 'sharer', ',width=980,height=600');
            break;
        case 'linkedin':
            window.open('http://www.linkedin.com/shareArticle?mini=true&url='+url+'&t='+title,'sharer',',width=980,height=600');
            break;
        case 'google':
            window.open('https://plus.google.com/share?url='+url+'&title='+title+'&annotation='+title,'sharer',',width=980,height=600');
            break;
        case 'stumbleupon':
            window.open('http://www.stumbleupon.com/submit?url='+url+'&title='+title, 'sharer',',width=980,height=600');
            break;
        case 'reddit':
            window.open('http://reddit.com/submit?url='+url+'&title='+title, 'sharer',',width=980,height=600');
            break;
        case 'pinterest':
            window.open('//pinterest.com/pin/create/button/?url='+url+'&title='+title, 'sharer',',width=980,height=600');
            break;
        case 'messenger':
            window.open('fb-messenger://share?link='+url);
            break;
        case 'telegram':
            window.open('//telegram.me/share/url?url='+url+'&text='+title, 'sharer',',width=980,height=600');
            break;
        case 'vk':
        case 'vkontakte':
            window.open('http://vk.com/share.php?url='+url+'&text='+title, 'sharer',',width=980,height=600');
            break;
        case 'zalo':
            break;
        case 'webchat':
            window.open('https://chart.apis.google.com/chart?cht=qr&chs=154x154&chld='+url+'&text='+title, 'sharer',',width=980,height=600');
            break;
        case 'viber':
            window.open('viber://forward?text='+url+' '+title, 'sharer',',width=980,height=600');
            break;
        case 'print':
            window.print();
            break;
    }
    if ("ga" in window) {
        tracker = ga.getAll()[0];
        if (tracker)
            tracker.send('event', 'share', 'click', 'web', 1);
    }
    return false;
}

function showPopup(url) {
    popUp = $.fancybox.getInstance();
    if(popUp) popUp.close();
    $.fancybox.open({
        src: url,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
    });
    return false;
}

function showPhotos(obj) {
    $.fancybox.open($(obj), {
        loop: true,
        buttons : [ 'slideShow', 'fullScreen', 'thumbs', 'share', 'zoom', 'close' ]
    });
}

function showLogin(type) {
    if(type===undefined) type=0;
    return showPopup(BASE_URL+'/login?type='+type);
}

function showPassword() {
    return showPopup(BASE_URL+'/password');
}

function showRegister() {
    return showPopup(BASE_URL+'/register');
}

var onLogin = false;
function doLogin() {
    // check validate
    if(onLogin) return false;
    onLogin = true;
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/login',
        dataType: 'JSON',
        data: $('#frmLogin').serialize()
    }).done(function(res) {
        onLogin = false;
        if(res.status==1) {
            if(res.return!==undefined) {
                document.location.href = res.return;
            } else {
                if(res.type!==undefined && res.type==1) {
                    if (popUp = $.fancybox.getInstance())
                        popUp.close();
                    $('#user_menu').load(ROOT_URL + '/checkauth');
                    return false;
                }
                if (popUp = $.fancybox.getInstance())
                    popUp.close()
                $.alert({
                    title: '',
                    content: res.message,
                    buttons: {
                        OK: function () {
                            location.reload();
                        }
                    }
                });
            }
        } else {
            $.alert({
                title: language.error_login,
                content: res.message,
                buttons: {
                    ok: {
                        keys: ['enter']
                    }
                }
            });
        }
    });
    return false;
}
var onRegister = false;
function doRegister() {
    if(onRegister) return false;
    onRegister = true;
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/register',
        dataType: 'JSON',

        data: $('#frmRegister').serialize()
    }).done(function(res) {
        onRegister = false;
        if(res.status==1) {
            window.location.href = BASE_URL+"/register/success";
        } else {
            $.alert(res.message);
        }
    });
    return false;
}

function retryCaptcha() {
    url = ROOT_URL+'/captcha?t='+Math.random();
    $('#imgCaptcha').attr('src', url);
}

var reset_pass = false;
function doPassword() {
    if (reset_pass) return false;
    reset_pass = true;
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/password',
        dataType: 'JSON',
        data: $('#frmPassword').serialize()
    }).done(function(res) {
        reset_pass = false;
        if(res.status==1) {
            if(popUp = $.fancybox.getInstance())
                popUp.close();
        }
        $.alert(res.message);
    });
    return false;
}

function doRating(id, val) {
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/my/rating',
        dataType: 'JSON',
        data: {'pid':id, 'val':val}
    }).done(function(res) {
        if(res.status == -1)
            showLogin();
        else if(res.status == 1)
            $.alert(res.message);
    });
    return false;
}




function reportAgency(id) {
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/my/reportagency',
        dataType: 'JSON',
        data: {'id':id}
    }).done(function(res) {
        if(res.status == 1) {
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        location.reload();
                    }
                }
            });
        }
    });
    return false;
}

function delMsg(action, id) {
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/my/messages',
        dataType: 'JSON',
        data: {'id':id, 'action': action}
    }).done(function(res) {
        if(res.status == 1) {
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        location.reload();
                    }
                }
            });
        }
    });
    return false;
}

function changeMsgStatus(action, id) {
    var status = $('#changeStatus_'+id).val();
    $.ajax({
        url: '',
        dataType: 'JSON',
        method: 'POST',
        data: {'id': id, 'action': action, 'status': status}
    }).done(function(res) {
        if (res.success) {
            $.alert({
                title: '',
                content: res.message,
                buttons: {
                    OK: function () {
                        location.reload();
                    }
                }
            });
        }
    })
}

function confirmDelId(id) {
    if(confirm(language.confirm_delete_selected) ) {
        var frm = $('#frmSearch');
        $('input[name=action]', frm).val('delete');
        $('input[name=id]', frm).val( id );
        frm.submit();
        return true;
    }
    return false;
}

function doFollow() {
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/follow',
        dataType: 'JSON'
    }).done(function(res) {
        if(res.status==1) {
            $('#boxFollow').remove();
            notifyMessage(res.message);
        } else {
            showLogin();
        }
    });
    return false;
}

function notifyMessage(msg, msg_type) {
    if(typeof msg_type=="undefined")
        msg_type='success';
    $.notify({
        message: msg
    },{
        type: msg_type,
        delay: 800,
        timer: 800,
        animate: {
            enter: 'animated fadeInDown',
            exit: 'animated fadeOutUp'
        },
    });
}

function initImage(obj) {
    $(obj).hover(function(){
        $(this).addClass('hover');
    }, function() {
        $(this).removeClass('hover');
    }).removeClass('new');
}

function RemoveImage(obj) {
    $(obj).closest('li').remove();
    return false;
}

function actionAd(action, id) {
    $.ajax({
        type: 'POST',
        url: BASE_URL+'/my/postings',
        dataType: 'json',
        data: {'id':id, 'action':action}
    }).done(function(data) {
        if ("ga" in window) {
            tracker = ga.getAll()[0];
            if (tracker) tracker.send('event', 'refresh', 'click', 'web', id);
        }
        $.alert({
            title: '',
            content: data.message,
            buttons: {
                confirm: function () {
                    location.reload();
                }
            }
        });
    });
    return false;
}

function Preview(url) {
    $.fancybox.open({
        'type': 'image',
        'src': ROOT_URL+url
    });
}

function loadFormRegisterInquiry() {
    $.fancybox.open({
        src: BASE_URL+'/save-alert?popup=1',
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
        touch: false,
    });
}


function closeFormInquiry() {
    $('#popupRegisterInquiry').removeClass('show');
}

function registerBorrowMoney(frm) {
    if(frmSubmit) return false;
    frmSubmit = true;
    $.ajax({
        type: 'POST',
        url: BASE_URL+'/register-money-borrow',
        dataType: 'JSON',
        data: $(frm).serialize(),
    }).done(function(data) {
        if (data.success) {
            $.alert(data.msg);
            closeFormInquiry();
            if (popUp = $.fancybox.getInstance())
                popUp.close();
        }
    });
    return false;
}

var regis_tin_cc = false;
function registerTinchinhchu(frm) {
    if (regis_tin_cc == true) return false;
    regis_tin_cc = true;
    $.ajax({
        type: 'POST',
        url: BASE_URL+'/frontend/product/registertinchinhchu',
        dataType: 'JSON',
        data: $(frm).serialize(),
    }).done(function(data) {
        regis_tin_cc = false;
        if (data.success) {
            if (data.link) {
                $.alert({
                    title: '',
                    content: data.msg,
                    buttons: {
                        'Sử dụng': function () {
                            window.location.href = data.link;
                        }
                    }
                });
            }
        }
        if (data.error) {
            $.alert(data.msg);
        }
    });
    return false;
}


function resetActive() {
    clearTimeout(activityTimeout);
    activityTimeout = setTimeout(inActive, 30000);
}

function inActive() {
    if(popUp = $.fancybox.getInstance())
        return false;

    loadFormRegisterInquiry();
    clearTimeout(activityTimeout);
    activityTimeout = false;
    $(document).unbind('mousemove keypress scroll');
}

function setupAutoPopup() {
    return false;
    show = $.cookie('show_popup_unquiry');
    if(show > $.now() )
        return false;
    $.cookie('show_popup_unquiry', $.now() + 60*30, { expires: 7 });
    activityTimeout = setTimeout(inActive, 200000);
    $(document).bind('mousemove keypress scroll', function () { resetActive(); });
}

function setSearchHomePageToCookie() {
    var data = $('#frmBoxSearch').serialize();
    if ($.cookie('set_data_search_box')) {
        $.removeCookie('set_data_search_box');
    }
    $.cookie('set_data_search_box', data, {expires: 7});
}

function setSearchFormToCookie() {
    var data = $('#frmSearchHouse').serialize();
    if ($.cookie('set_data_search_box')) {
        $.removeCookie('set_data_search_box');
    }
    $.cookie('set_data_search_box', data, {expires: 7});
}

function parseDate(str) {
    var mdy = str.split('/');
    return new Date(mdy[2], mdy[1]-1, mdy[0]);
}

function dateDiff(first, second) {
    first = parseDate(first);
    second = parseDate(second);
    return Math.round((second-first)/(1000*60*60*24));
}

function getPhone(hid, mobi) {
    $.getJSON(BASE_URL+'/house/phone/'+hid, function(data) {
        if (data.status == 0) {
            $.alert(data.msg);
            return false;
        }
        $('#btn_get_phone span').text(data.phone);
        $('#btn_get_phone').attr('href', 'tel:'+data.phone);
        ex_str = "";
        if(mobi==1)
            ex_str = 'tel:'+data.phone;
        else if(mobi==2)
            ex_str = 'sms:'+data.phone;
        if ("ga" in window) {
            tracker = ga.getAll()[0];
            if (tracker)
                tracker.send('event', 'phone', 'click', 'web', hid);
        }
        if(mobi==1 || mobi==2) {
            setTimeout(function() {
                window.location = ex_str;
            },300);
        }
    });
    return false;
}
function getAlertPhone(hid) {
    $.getJSON(BASE_URL+'/alert/phone/'+hid, function(res) {
        if (res.status == 0) {
            $('#get_phone').empty();
            if (res.data == 'login')
                $('#get_phone').append('<a class="btn btn-primary" onclick="return showLogin()">Bạn cần đăng nhập để xem tin</a>');
            else
                $('#get_phone').append('<a class="btn btn-primary" href="'+BASE_URL+'/my/goi-tin-chinh-chu">Bạn cần mua gói xem tin chính chủ</a>');
        } else if (res.status == 1) {
            $('#btn_get_phone span').text(res.phone);
            $('#btn_get_phone').attr('href', 'tell:' + res.phone);
        }
        if ("ga" in window) {
            tracker = ga.getAll()[0];
            if (tracker)
                tracker.send('event', 'phone', 'click', 'web', hid);
        }
    });
    return false;
}

function doFeedback(frm) {
    $frm = $(frm);
    $.ajax({
        method: 'POST',
        url: BASE_URL+'/phan-hoi',
        dataType: 'JSON',
        data: $frm.serialize()
    }).done(function(res) {
        $.alert({
            title: '',
            content: res.message,
            buttons: {
                OK: function () {
                    location.reload();
                }
            }
        });
    });
    return false;
}

function viewPackage(id) {
    $.fancybox.open({
        src: BASE_URL+'/my/package/'+id,
        type: 'ajax',
        openEffect	: 'fade',
        closeEffect	: 'elastic',
        scrolling: 'yes'
    });
    return false;
}

function Preview(url) {
    $.fancybox.open({
        'type': 'image',
        'src': ROOT_URL+url
    });
}

function convertPrice() {
    var error = '',
        text_price_max = 'Giá bất động sản vượt quá <b>%s</b>. Chúng tôi sẽ đề giá bất động sản của bạn là: <b>Thoả thuận</b>',
        b_max = 200,
        m_max = 200000,
        t_max = 200000000000,
        b_max_m2 = 2,
        m_max_m2 = 2000,
        price = $('#price').val(),
        unit = $('#unit').val();

    price = price.replace(/\,/g, '');
    if (unit == 0 && price < 1000000) {
        $.alert('Vui lòng nhập Giá bất động sản lớn hơn 1,000,000 VNĐ');
        return false;
    }

    if (unit == 0 && price >= t_max)
        error = '200 tỷ';
    else if (unit == 1 && price >= m_max)
        error = '200 tỷ';
    else if (unit == 2 && price >= b_max)
        error = '200 tỷ';
    else if (unit == 3 && price >= m_max_m2)
        error = '2 tỷ/m';
    else if (unit == 5 && price >= b_max_m2)
        error = '2 tỷ/m';
    else if ((unit == 1 && price >= 1000) || (unit == 3 && price >= 1000)) {
        $.ajax({
            method: 'POST',
            url: BASE_URL+'/frontend/product/convertprice',
            dataType: 'JSON',
            data: {'price' : price, 'unit' : unit}
        }).done(function(res) {
            if (res.success) {
                $.alert({
                    title: '',
                    content: res.data.msg,
                    buttons: {
                        OK: function () {
                            if (res.data.price) {
                                $('#price').val(res.data.price);
                                $('#unit option[value="' + res.data.unit + '"]').prop("selected", true);
                            } else {
                                $('#unit option[value="4"]').prop("selected", true);
                                $('#unit').trigger('change');
                            }
                        }
                    }
                });
            }
        });
    }
    if (error) {
        $.alert({
            title: '',
            content: text_price_max.replace(/%s/g, error),
            buttons: {
                OK: function () {
                    $('#unit option[value="4"]').prop("selected", true);
                    $('#unit').trigger('change');
                }
            }
        });
    }
    return false;
}

function expandInfo (id, mid, time_remain, seen) {
    if (time_remain && seen == 0) {
        $.ajax({
            method: 'POST',
            url: BASE_URL+'/frontend/my/viewedtinchinhchu',
            dataType: 'JSON',
            data: {'id' : id, 'mid' : mid, 'time_remain': time_remain}
        }).done(function (res) {
            if (res.success) {
                $('.tr_'+id).addClass('viewed');
                if (!$('.bound_'+id).length)
                    $('.tr_'+id).children('td:first-child').append('<div class="bound-viewed bound_'+id+'">Đã xem</div>');
            }
        });
    }
    $('.btnFilter_'+id).toggleClass('open');
    $('#home_filter_down_'+id).toggleClass('hidden');
}

var submit_alert_tincc = false;
function saveAlertTinCC (frm) {
    if (submit_alert_tincc == true) return false;
    submit_alert_tincc = true;
    $.ajax({
        type: 'POST',
        url: BASE_URL+'/alert-tin-chinh-chu',
        dataType: 'JSON',
        data: $(frm).serialize()
    }).done(function(data) {
        submit_alert_tincc = false;
        if (data.success) {
            $.alert({
                title: '',
                content: data.msg,
                buttons: {
                    OK: function () {
                        location.reload();
                    }
                }
            });
        } else if (data.error) {
            $.alert(data.msg);
        }
    });
    return false;
}