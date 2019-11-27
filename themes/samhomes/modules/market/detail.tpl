<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/css/td/lightslider.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/css/td/lightgallery1.min.css">
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/td/lightgallery.js"></script>
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/td/lightslider.min.js"></script>
<script>
                                                    $(document).ready(function() {
                                                        $('#imageGallery').lightSlider({
                                                            gallery : true,
                                                            item : 1,
                                                            loop : true,
                                                            thumbItem : 10,
                                                            slideMargin : 0,
                                                            enableDrag : false,
                                                            currentPagerPosition : 'left',
                                                            onSliderLoad : function(el) {
                                                                $('.wrapimageGallery').css({
                                                                    'opacity' : 1,
                                                                    'height' : 'auto'
                                                                });
                                                                el.lightGallery({
                                                                    selector : '#imageGallery .lslide',
                                                                    thumbnail : true
                                                                });
                                                            }
                                                        });
                                                    });
                                                </script>
<div id="body_content" class="custom_page_product_detail" role="main">
    <div class="container">
        <section id="product_detail">
            <div class="row">
                <div class="col-sm-18 col-xs-24">
                    <h1 class="title">{DATA.title}</h1>
                    <div class="row">
                        <ul class="house_static">
                            <!-- BEGIN: price -->
                            <li><span class="price">{LANG.price}: {DATA.price}</span></li>
                            <!-- END: price -->
                            <li><i class="fa fa-tag"></i> <strong>{LANG.code}</strong> : {DATA.code}</li>
                            <li><i class="fa fa-clock-o"></i><strong> {LANG.addtime}</strong> : {DATA.addtimef}</li>
                            <li><i class="fa fa-eye"></i> <strong>{LANG.countview} </strong> : {DATA.countview}</li>
                            <!-- BEGIN: comment -->
                            <li><i class="fa fa-comment-o"></i> <strong>{LANG.countcomm} </strong> : {DATA.countcomment}</li>
                            <!-- END: comment -->
                            <li><em class="fa fa-folder-open-o">&nbsp;</em><strong>{LANG.cat}</strong> : <a href="{DATA.cat_link}" title="{DATA.cat}">{DATA.cat}</a></li>
                            <!-- BEGIN: type -->
                            <li><em class="fa fa-cog">&nbsp;</em><strong>{LANG.type}</strong> : {DATA.type}</li>
                            <!-- END: type -->
                            <!-- BEGIN: location -->
                            <li><em class="fa fa-map-marker">&nbsp;</em><strong>{LANG.area}</strong> : <a href="{DATA.location_link}" title="{DATA.location}">{DATA.location}</a></li>
                            <!-- END: location -->
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-xs-24 text-center">
                            <!-- BEGIN: image1 -->
                            <div class="wrapimageGallery" style="opacity: 0; overflow: hidden;">
                                <ul id="imageGallery">
                                    <!-- BEGIN: loop -->
                                    <li data-thumb="{IMAGE.thumb}" data-src="{IMAGE.full}"><span class="boxImage"> <img class="obj" src="{IMAGE.thumb}" />
                                    </span></li>
                                    <!-- END: loop -->
                                </ul>
                            </div>
                            <!-- END: image1 -->
                            <!-- BEGIN: image2 -->
                            <img class="obj" src="{NV_BASE_SITEURL}themes/{TEMPLATE}/images/market/nopicture.jpg" />
                            <!-- END: image2 -->
                        </div>
                    </div>
                    <div id="utility">
                        <!-- BEGIN: field -->
                        <div class="row">
                            <div class="col-xs-24">
                                <h3 class="title">{FIELD.title}</h3>
                            </div>
                            <div class="col-xs-24 box-utility">
                                <div class="thumbnail">
                                    <img src="https://cdn.samhomes.vn/htdocs/css/themes/garage.png" alt="">
                                </div>
                                <span>{FIELD.value}</span>
                            </div>
                        </div>
                        <!-- END: field -->
                    </div>
                    <!-- BEGIN: admin_keywords -->
                    <link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css">
                    <link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css">
                    <h3 class="title">{LANG.tags} ({LANG.tags_note})</h3>
                    <div class="form-group">
                        <select class="form-control" name="keywords[]" id="keywords" multiple="multiple">
                            <!-- BEGIN: keywords -->
                            <option value="{KEYWORDS.tid}" selected="selected">{KEYWORDS.title}</option>
                            <!-- END: keywords -->
                        </select>
                    </div>
                    <button class="btn btn-primary m-b20" id="tags-save">{LANG.save_change}</button>
                    <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
                    <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
                    <script>
		$(document).ready(function() {
			$('#keywords').select2({
				tags : true,
				language : '{NV_LANG_INTERFACE}',
				theme : 'bootstrap',
				tokenSeparators : [ ',' ],
				ajax : {
					url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + "=ajax&nocache=" + new Date().getTime() + "&get_keywords=1",
					processResults : function(data, page) {
						return {
							results : data
						};
					}
				}
			});
			
			$('#tags-save').click(function(){
				$.ajax({
					type : 'POST',
					url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + "=ajax&nocache=" + new Date().getTime(),
					data : 'tags_save=1&id={DATA.id}&keywords=' + $('#keywords').val(),
					success : function(res) {
						var r_split = res.split('_');
						if(r_split[0] == 'OK'){
							alert(nv_is_change_act_confirm[1]);
						}else{
							alert(nv_is_change_act_confirm[2]);
						}
					}
				});
			});
		});
	</script>
                    <!-- END: admin_keywords -->
                    <div id="content">
                        <!-- BEGIN: auction -->
                        <div class="row">
                            <div class="col-xs-24 col-sm-16 col-md-16">{DATA.content}</div>
                            <div class="col-xs-24 col-sm-16 col-md-8">
                                <div class="panel panel-default" id="auction">
                                    <div class="panel-heading">{LANG.auction_info}</div>
                                    <div class="panel-body">
                                        <div id="auction_heading" class="text-center <!-- BEGIN: auction_heading -->hidden<!-- END: auction_heading -->">
                                            <h3 id="auction_begin_note">{LANG.auction_begin_note}:</h3>
                                            <h2 class="m-bottom text-danger" id="auction-countdown"></h2>
                                        </div>
                                        <h2 id="auction_heading_end" class="m-bottom text-danger text-center <!-- BEGIN: auction_heading_end -->hidden<!-- END: auction_heading_end -->">{LANG.auction_status_2}</h2>
                                        <hr />
                                        <ul>
                                            <li><label>{LANG.auction_begin}</label> : {DATA.auction_begin_str}</li>
                                            <li><label>{LANG.auction_end}</label> : {DATA.auction_end_str}</li>
                                            <li><label>{LANG.auction_price_begin}</label> : <span class="money">{DATA.auction_price_begin_str} {MONEY_UNIT}</span></li>
                                        </ul>
                                        <hr />
                                        <div class="panel panel-default">
                                            <div class="panel-body text-center" id="auction-max">
                                                {LANG.auction_price_begins}</label> <span class="money">{DATA.auction_price_begin_str} {MONEY_UNIT} 
                                            </div>
                                        </div>
                                        <div id="messagesDiv" style="height: 200px; overflow: scroll; margin-bottom: 10px"></div>
                                        <!-- BEGIN: frm_auction -->
                                        <form id="frm-auction" action="" method="post" class="m-bottom">
                                            <div class="input-group">
                                                <input class="form-control price" type="text" name="auction_value" id="auction_value"
                                                <!-- BEGIN: auction_value_disabled -->
                                                disabled="disabled"
                                                <!-- END: auction_value_disabled -->
                                                /> <span class="input-group-btn">
                                                    <button class="btn btn-default" type="submit" id="auction-send"
                                                        <!-- BEGIN: auction_value_disabled_btn -->
                                                        disabled="disabled"
                                                        <!-- END: auction_value_disabled_btn -->
                                                        > <em class="fa fa-sign-in">&nbsp;</em>
                                                    </button>
                                                </span>
                                            </div>
                                        </form>
                                        <!-- END: frm_auction -->
                                        <div class="text-center">
                                            <!-- BEGIN: login -->
                                            {LANG.auction_login}
                                            <!-- END: login -->
                                            <!-- BEGIN: register -->
                                            <button class="btn btn-xs btn-primary <!-- BEGIN: register_hidden -->hidden<!-- END: register_hidden -->" id="btn-auction-register" onclick="nv_auction_register({DATA.id}); return !1;">{LANG.auction_register}</button>
                                            <button class="btn btn-xs btn-primary <!-- BEGIN: cancel_hidden -->hidden<!-- END: cancel_hidden --> " id="btn-auction-cancel" onclick="nv_auction_cancel({DATA.id}); return !1;">{LANG.auction_cancel}</button>
                                            <!-- END: register -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/market_autoNumeric-1.9.41.js"></script>
                        <script src='https://cdn.firebase.com/v0/firebase.js'></script>
                        <script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/jquery.countdown.min.js"></script>
                        <script type="text/javascript">
				var countdown = {DATA.auction_status};
				
				nv_auction_countdown('{DATA.countdown_begin}');
				
				function nv_auction_countdown(timer, stop)
				{
					
					if(stop){
						$('#auction_heading').addClass('hidden');
						$('#auction_heading_end').removeClass('hidden');
						return !1;
					}
					
					$('#auction-countdown').countdown(timer, function(event) {
						$(this).html(event.strftime('{LANG.auction_countdown}'));
						$(this).on('finish.countdown', function(){
							if(countdown == 0){
								countdown = 1;
								nv_auction_countdown('{DATA.countdown_end}');
							}else if(countdown == 1){
								$('#auction_value').prop('disabled', false);
								$('#auction-send').prop('disabled', false);
								$('#auction_value').focus();
								$('#auction_begin_note').text('{LANG.auction_end_note}:');
								nv_auction_countdown('', true);
							}
						});
					});	
				}
				
				var myDataRef = new Firebase('{FIREBASE_URL}');
				$('#frm-auction').submit(function (e) {
					e.preventDefault();
					var price = $('#auction_value').val();
				 
					if(price == ''){
						$('#auction_value').focus();
						alert('{LANG.error_auction_empty_value}');
					} else{ 
						$.ajax({
							type : 'POST',
							url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
							data : 'auction_send=1&rowsid={DATA.id}&price=' + price,
							dataType: 'json',
							success : function(json) {
								console.log(json);
					            if(json.status == 'error'){
					            	alert(json.message);
					            }else{
									myDataRef.push({userid: json.userid, name: json.name, price: json.price, addtime: json.addtime});
									$('#auction_value').val('');
					            }
							}
						});
					}
				});
				
				myDataRef.on('child_added', function(snapshot) {
					var message = snapshot.val();
					displayChatMessage(message.name, message.price, message.addtime);
				});
				
				function displayChatMessage(name, price, addtime) {
					$('#auction-max').html('<strong>' + name + '</strong> {LANG.auction_sended} <span class="money">' + price + '({MONEY_UNIT})</span><br />{LANG.auction_momment} ' + addtime);
					$('<div/>').text(price + '({MONEY_UNIT})').prepend($('<em title="' + addtime + '" />').text(name + ' ')).appendTo($('#messagesDiv'));
					$('#messagesDiv')[0].scrollTop = $('#messagesDiv')[0].scrollHeight;
				};
				
				var Options = {
					aSep : '{DES_POINT}',
					aDec : '{THOUSANDS_SEP}',
					vMin : '0',
					vMax : '999999999999999999'
				};
				$('.price').autoNumeric('init', Options);
				$('.price').bind('blur focusout keypress keyup', function() {
					$(this).autoNumeric('get', Options);
				});
			</script>
                        <!-- END: auction -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#tab-content" aria-controls="tab-content" role="tab" data-toggle="tab">{LANG.content}</a></li>
                            <!-- BEGIN: maps_title -->
                            <li role="presentation"><a href="#maps" aria-controls="maps" role="tab" data-toggle="tab">{LANG.maps}</a></li>
                            <!-- END: maps_title -->
                        </ul>
                        <div class="tab-content m-t10">
                            <div role="tabpanel" class="tab-pane active" id="tab-content">{DATA.content}</div>
                            <!-- BEGIN: maps_content -->
                            <div role="tabpanel" class="tab-pane" id="maps">
                                <script>
                                                    if (!$('#googleMapAPI').length) {
                                                        var script = document.createElement('script');
                                                        script.type = 'text/javascript';
                                                         script.id = 'googleMapAPI';
                                                        script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&callback=initializeMap&key={MAPS_ADPI}';
                                                        document.body.appendChild(script);
                                                    } else {
                                                        initializeMap();
                                                    }

                                                    function initializeMap() {
                                                        var ele = 'company-map';
                                                        var map, marker, ca, cf, a, f, z;
                                                        ca = parseFloat($('#' + ele).data('clat'));
                                                        cf = parseFloat($('#' + ele).data('clng'));
                                                        a = parseFloat($('#' + ele).data('lat'));
                                                        f = parseFloat($('#' + ele).data('lng'));
                                                        z = parseInt($('#' + ele).data('zoom'));
                                                        map = new google.maps.Map(document.getElementById(ele), {
                                                            zoom : z,
                                                            center : {
                                                                lat : ca,
                                                                lng : cf
                                                            }
                                                        });
                                                        marker = new google.maps.Marker({
                                                            map : map,
                                                            position : new google.maps.LatLng(a, f),
                                                            draggable : false,
                                                            animation : google.maps.Animation.DROP
                                                        });
                                                    }
                                                </script>
                                <div class="m-bottom" id="company-map" style="width: 100%; height: 500px" data-clat="{DATA.maps.maps_mapcenterlat}" data-clng="{DATA.maps.maps_mapcenterlng}" data-lat="{DATA.maps.maps_maplat}" data-lng="{DATA.maps.maps_maplng}" data-zoom="{DATA.maps.maps_mapzoom}"></div>
                            </div>
                            <!-- END: maps_content -->
                        </div>
                    </div>
                    <!-- BEGIN: keywords -->
                    <div class="tags">
                        <b> <i class="fa fa-tags"></i>{LANG.keywords}:
                        </b>
                        <!-- BEGIN: loop -->
                        <a title="{KEYWORD}" href="{LINK_KEYWORDS}"><em>{KEYWORD}</em></a>{SLASH}
                        <!-- END: loop -->
                    </div>
                    <div class="clearfix"></div>
                    <!-- END: keywords -->
                    {BLOCK_1}
                </div>
                <div class="col-sm-6 col-xs-24">
                    <!-- BEGIN: contact -->
                    <div class="formBooking">
                        <div class="form-group lbl-title">{LANG.contact_info}</div>
                        <!-- BEGIN: fullname -->
                        <div class="form-group" style="font-size: 14px">
                            <i class="fa fa-user"></i> {DATA.contact_fullname}
                        </div>
                        <!-- END: fullname -->
                        <!-- BEGIN: phone -->
                        <div class="form-group">
                            <a href="tel:{DATA.contact_phone}" class="btn btn-primary btn-block btn-sm" id="btn_get_phone"><i class="fa fa-phone"></i> <span>{DATA.contact_phone}</span></a>
                        </div>
                        <!-- END: phone -->
                        <!-- BEGIN: email -->
                        <div class=" div_chat">
                            <a href="mailto:{DATA.contact_email}" class="btn btn-info btn-block btn-sm"><i class="fa fa-envelope"></i>&nbsp;{LANG.sendmail}</a>
                        </div>
                        <!-- END: email -->
                        <!-- BEGIN: address -->
                        <div class="">
                            <a href="#" class="btn btn-default btn-block" style="white-space: inherit;"> <i class="fa fa-map-pin"></i> Địa chỉ <b style="color: #ed1c24"> {DATA.contact_address} </b></a>
                        </div>
                        <!-- END: address -->
                    </div>
                    <!-- END: contact -->
                    <div class="m-t10"></div>
                    <div class="formBooking">
                        <div class="m-b10">
                            <div class="socialicon clearfix">
                                <div class="fb-like pull-left" data-href="{SELFURL}" data-layout="button_count" data-action="like" data-show-faces="false" data-share="true">&nbsp;</div>
                                <div class="pull-right">
                                    <!-- BEGIN: refresh -->
                                    <a id="refresh" class="btn btn-warning" href="javascript:void(0)" onclick="nv_refresh_popup({DATA.id}); return !1;" title="{LANG.refresh}"><em class="fa fa-refresh fa-lg text-success">&nbsp;</em>{LANG.refresh}</a>
                                    <!-- END: refresh -->
                                    <a  class="btn btn-default btn-xs save_button_{DATA.id}" {DATA.style_save} href="javascript:void(0)" onclick="nv_save_rows({DATA.id}, 'add', {DATA.is_user}); return !1;" title="{LANG.save}"><em class="fa fa-floppy-o fa-lg text-success">&nbsp;</em>{LANG.save}</a> <a  class="btn btn-default btn-xs saved_button_{DATA.id}" {DATA.style_saved} href="javascript:void(0)" onclick="nv_save_rows({DATA.id}, 'remove', {DATA.is_user}); return !1;" title="{LANG.save_remove}"><em class="fa fa-minus-circle fa-lg text-danger">&nbsp;</em>{LANG.save_remove}</a>
                                    <!-- BEGIN: admin -->
                                    <a href="{DATA.link_edit}" class="btn btn-default btn-xs"><em class="fa fa-edit">&nbsp;</em>{LANG.edit}</a> <a href="{DATA.link_delete}" class="btn btn-default btn-xs" onclick="return confirm(nv_is_del_confirm[0]);"><em class="fa fa-trash-o">&nbsp;</em>{LANG.delete}</a>
                                    <!-- END: admin -->
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="form-group clear">
                            <div id="feedback">
                                <div class="dropdown">
                                    <form id="frmFeeback2" method="post" onsubmit="return doFeedback(this)">
                                        <button class="btn btn-block btn-sm btn-primary dropdown-toggle" type="button" data-toggle="dropdown" style="white-space: normal">
                                            <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;Báo cáo sai phạm
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><label class="title"><input type="checkbox" id="fb_1" name="fb[]" value="1">Bất động sản đã bán/cho thuê</label></li>
                                            <li><label class="title"><input type="checkbox" id="fb_2" name="fb[]" value="2">Nội dung không đúng với thực tế</label></li>
                                            <li><label class="title"><input type="checkbox" id="fb_3" name="fb[]" value="3">Giá không đúng</label></li>
                                            <li><label class="title"><input type="checkbox" id="fb_4" name="fb[]" value="4">Không liên lạc được</label></li>
                                            <li><label class="title"><input type="checkbox" id="fb_5" name="fb[]" value="5">Tin không có thật</label></li>
                                            <li><label class="title"><input type="checkbox" id="fb_6" name="fb[]" value="6">Địa chỉ bất động sản không đúng</label></li>
                                            <li><label class="title"><input type="checkbox" id="fb_7" name="fb[]" value="7">Trùng với tin rao khác</label></li>
                                            <li><input type="hidden" name="hid" value="107895">
                                                <button type="submit" name="action" class="btn btn-primary btn-sm" value="save">Gửi đi</button></li>
                                        </ul>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    [CONTENT_FIFTEEN]
                </div>
            </div>
        </section>
    </div>
    <!-- BEGIN: other -->
    <section id="other_real_eastate_you_interested_in">
        <div class="container">
            <div class="row d-flex align-items-center">
                <div class="col-xs-24 col-sm-20">
                    <h2 class="title st1">
                        {LANG.other} {DATA.cat} <a href="{DATA.cat_link}" title="{LANG.viewall}"><span>({LANG.viewall})</span></a>
                    </h2>
                </div>
            </div>
            <div class="house_listing owl-carousel owl-theme" id="house_insterested">{OTHER}</div>
            <script type="text/javascript">
    $(document).ready(function() {
        $('#house_insterested').each(function() {
            $(this).owlCarousel({
                nav : true,
                dots : false,
                autoplay : false,
                autoplayTimeout : 3000,
                animateOut : 'fadeOut',
                autoHeight : true,
                navText : [ "<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>" ],
                responsive : {
                    0 : {
                        autoWidth : true
                    },
                    480 : {
                        items : 2
                    },
                    768 : {
                        items : 3
                    },
                    1200 : {
                        items : 4
                    }
                }
            });
        });
    });
</script>
        </div>
    </section>
    <!-- END: other -->
</div>
<script>
	var LANG = [];
	LANG.error_save_login = '{LANG.error_save_login}';
	LANG.auction_register_confirm = '{LANG.auction_register_confirm}';
	LANG.auction_cancel = '{LANG.auction_cancel}';
	LANG.auction_register_success = '{LANG.auction_register_success}';
	LANG.auction_cancel_succes = '{LANG.auction_cancel_succes}';
	LANG.auction_cancel_confirm = '{LANG.auction_cancel_confirm}';
	
	
</script>
<!-- END: main -->