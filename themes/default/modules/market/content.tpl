<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/default/js/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css" />


<div class="content-body content <!-- BEGIN: popup -->popup<!-- END: popup -->">
    <!-- BEGIN: error -->
    <div class="alert alert-warning">{ERROR}</div>
    <!-- END: error -->
    <form class="form-horizontal" action="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}&amp;id={ROW.id}&amp;ispopup={ISPOPUP}&amp;redirect={REDIRECT}" method="post" id="frm-submit" autocomplete="off">
        <h2 class="title">{LANG.rowsinfo}</h2>
        <div class="alert alert-info">
            <ul class="box-note">
                <!-- BEGIN: guest_note -->
                <li>{LANG.content_guest_note}</li>
                <!-- END: guest_note -->
                <li>{LANG.required_note}</li>
                <li>{LANG.terms_note}</li>
            </ul>
        </div>
        <input type="hidden" name="id" value="{ROW.id}" />
        <div class="form-group">
            <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <span class="require">(*) Thông tin bắt buộc</span>
            </div>
        </div>
        <!-- BEGIN: typeid -->
        <div class="form-group">
            <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong>{LANG.type} <span class="require">(*)</span></strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <!-- BEGIN: loop -->
                <label><input type="radio" name="typeid" value="{TYPE.id}" {TYPE.checked} />{TYPE.title}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <!-- END: loop -->
            </div>
        </div>
        <!-- END: typeid -->
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.title} <span class="require">(*)</span></strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <input class="form-control required tooltip-focus" type="text" name="title" value="{ROW.title}" id="title" placeholder="{LANG.title}" data-toggle="tooltip" title="{LANG.tooltip_focus_title}" maxlength="60" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.catid} <span class="require">(*)</span></strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <select name="catid" class="form-control required tooltip-focus m-bottom" id="catid">
                    <option value="">---{LANG.cat_c}---</option>
                    <!-- BEGIN: cat -->
                    <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                    <!-- END: cat -->
                </select>
            </div>
        </div>
        <div id="custom_form">{DATACUSTOM_FORM}</div>
        <div id="div-pricetype">{PRICETYPE}</div>
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"> <strong>{LANG.location} <span class="require">(*)</span></strong>
            </label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <div class="col-md-14 col-xs-24">{LOCATION}</div>
                <div class="col-md-10 col-xs-24 p-l0">
                    <input type="text" class="form-control" name="address" value="{ROW.address}" placeholder="{LANG.contact_address}" />
                </div>
            </div>
        </div>
        <!-- BEGIN: description -->
        <div class="form-group form-tooltip">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.description_s}</strong> <em class="fa fa-question-circle fa-pointer text-info" data-toggle="tooltip" data-original-title="{LANG.description_note}">&nbsp;</em></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <textarea class="form-control" name="description">{ROW.description}</textarea>
            </div>
        </div>
        <!-- END: description -->
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.content}</strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                {ROW.content}
                <!-- BEGIN: editor_guest_note -->
                <small class="help-block"><em>{LANG.editor_guest_note}</em></small>
                <!-- END: editor_guest_note -->
            </div>
        </div>
        <!-- BEGIN: note -->
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.note} <span class="require">(*)</span></strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <textarea class="form-control required" cols="75" rows="5" name="note">{ROW.note}</textarea>
            </div>
        </div>
        <!-- END: note -->
        <!-- BEGIN: exptime -->
<!--         <div class="form-group"> -->
<!--             <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.exptime}</strong></label> -->
<!--             <div class="col-sm-19 col-md-20 p-tb5 p-lr15"> -->
<!--                 <div class="row m-bottom"> -->
<!--                     <div class="col-xs-8 col-sm-8 col-md-6"> -->
<!--                         <select name="begintime_hour" class="form-control"> -->
<!--                             <option value="0">---{LANG.hour_select}---</option> -->
<!--                             BEGIN: hour -->
<!--                             <option value="{HOUR.index}"{HOUR.selected}>{HOUR.index}</option> -->
<!--                             END: hour -->
<!--                         </select> -->
<!--                     </div> -->
<!--                     <div class="col-xs-8 col-sm-8 col-md-6"> -->
<!--                         <select name="begintime_min" class="form-control"> -->
<!--                             <option value="0">---{LANG.min_select}---</option> -->
<!--                             BEGIN: min -->
<!--                             <option value="{MIN.index}"{MIN.selected}>{MIN.index}</option> -->
<!--                             END: min -->
<!--                         </select> -->
<!--                     </div> -->
<!--                     <div class="col-xs-8 col-sm-8 col-md-12"> -->
<!--                         <div class="input-group"> -->
<!--                             <input class="form-control datepicker" type="text" name="exptime" value="{ROW.exptimef}" pattern="^[0-9]{2,2}\/[0-9]{2,2}\/[0-9]{1,4}$" /> -->
<!--                             <span class="input-group-btn"> -->
<!--                                 <button class="btn btn-default" type="button" id="exptime-btn"> -->
<!--                                     <em class="fa fa-calendar fa-fix"> </em> -->
<!--                                 </button> -->
<!--                             </span> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        <!-- END: exptime -->
<!--         <div class="panel panel-default"> -->
<!--             <div class="panel-heading">{LANG.pack_money}</div> -->
<!--             <div class="panel-body"> -->
<!--                 <div class="form-group"> -->
<!--                     <label class="col-sm-5 col-md-4 control-label"></label> -->
<!--                     <div class="col-sm-19 col-md-20"> -->
<!--                         BEGIN: pack_money -->
<!--                         <label class="container"><input type="radio" name="pack_money" value="{PACK_MONEY.id}" {PACK_MONEY.checked}>{PACK_MONEY.title}</label> -->
<!--                         END: pack_money -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        <!-- BEGIN: auction -->
        <h2 class="title">
            <label><input type="checkbox" name="auction" value="1" {ROW.ck_auction} />{LANG.auction}</label>
        </h2>
        <div class="" id="auction-block"{ROW.auction_style}>
            <label><strong>{LANG.auction_begin}</strong></label>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-6">
                        <select name="auction_begin_hour" class="form-control">
                            <option value="0">---{LANG.hour_select}---</option>
                            <!-- BEGIN: auction_begin_hour -->
                            <option value="{HOUR.index}"{HOUR.selected}>{HOUR.index}</option>
                            <!-- END: auction_begin_hour -->
                        </select>
                    </div>
                    <div class="col-xs-6">
                        <select name="auction_begin_min" class="form-control">
                            <option value="0">---{LANG.min_select}---</option>
                            <!-- BEGIN: auction_begin_min -->
                            <option value="{MIN.index}"{MIN.selected}>{MIN.index}</option>
                            <!-- END: auction_begin_min -->
                        </select>
                    </div>
                    <div class="col-xs-12">
                        <div class="input-group">
                            <input class="form-control datepicker required" type="text" name="auction_begin_date" value="{ROW.auction_beginf}" pattern="^[0-9]{2,2}\/[0-9]{2,2}\/[0-9]{1,4}$" />
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <em class="fa fa-calendar fa-fix"> </em>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <label><strong>{LANG.auction_end}</strong></label>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-6">
                        <select name="auction_end_hour" class="form-control">
                            <option value="0">---{LANG.hour_select}---</option>
                            <!-- BEGIN: auction_end_hour -->
                            <option value="{HOUR.index}"{HOUR.selected}>{HOUR.index}</option>
                            <!-- END: auction_end_hour -->
                        </select>
                    </div>
                    <div class="col-xs-6">
                        <select name="auction_end_min" class="form-control">
                            <option value="0">---{LANG.min_select}---</option>
                            <!-- BEGIN: auction_end_min -->
                            <option value="{MIN.index}"{MIN.selected}>{MIN.index}</option>
                            <!-- END: auction_end_min -->
                        </select>
                    </div>
                    <div class="col-xs-12">
                        <div class="input-group">
                            <input class="form-control datepicker required" type="text" name="auction_end_date" value="{ROW.auction_endf}" pattern="^[0-9]{2,2}\/[0-9]{2,2}\/[0-9]{1,4}$" />
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button" id="exptime-btn">
                                    <em class="fa fa-calendar fa-fix"> </em>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <label><strong>{LANG.auction_price_begin}</strong></label>
            <div class="form-group">
                <div class="input-group">
                    <input type="text" name="auction_price_begin" value="{ROW.auction_price_begin}" class="form-control required price" />
                    <span class="input-group-addon">{MONEY_UNIT}</span>
                </div>
            </div>
            <label><strong>{LANG.auction_price_step}</strong></label>
            <div class="form-group">
                <div class="input-group">
                    <input type="text" name="auction_price_step" value="{ROW.auction_price_step}" class="form-control required price" />
                    <span class="input-group-addon">{MONEY_UNIT}</span>
                </div>
            </div>
        </div>
        <!-- END: auction -->
        <!-- BEGIN: images -->
        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.image} <span class="require">(*)</span></strong></label>
        <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
            <blockquote class="alert alert-info">
                <ul class="p-0">
                    <li>Tin đăng kèm hình ảnh sẽ thu hút người xem nhiều hơn!</li>
                    <li>Bạn có thể tải lên tới 10 hình ảnh, {LANG.maxsizeimage}: {USER_CONFIG.max_width}x{USER_CONFIG.max_height}, {LANG.maxsize}: {USER_CONFIG.max_filesize} có liên quan đến tin đăng của bạn</li>
                </ul>
            </blockquote>
            <div class="col-xs-24 col-sm-13  p-l0">
                <div id="uploader">
                    <p>Trình duyệt của bạn không có hỗ trợ Flash, Silverlight hoặc HTML5.</p>
                </div>
            </div>
            <div class="col-xs-24 col-sm-11 ">
                <div id="imagelist" style="border: solid 1px #ddd; padding: 10px; height: 315px">
                    <!-- BEGIN: loop -->
                    <div class="image <!-- BEGIN: is_main -->is_main<!-- END: is_main -->">
                        <em class="fa fa-times-circle fa-lg fa-pointer" title="{LANG.image_delete}" onclick="$(this).parent().remove();">&nbsp;</em>
                        <div class="row m-bottom">
                            <div class="col-xs-24 col-sm-4 col-md-4 text-center">
                                <input type="hidden" name="images[{IMAGE.index}][path]" value="{IMAGE.homeimgfile}" />
                                <img class="img-thumbnail" src="{IMAGE.path}" width="100%" />
                            </div>
                            <div class="col-xs-24 col-sm-20 col-md-20" style="overflow: hidden;">
                                <h2>{IMAGE.basename}</h2>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-18 col-md-18">
                                        <input type="text" name="images[{IMAGE.index}][description]" value="{IMAGE.description}" class="form-control input-sm" placeholder="{LANG.image_description}" />
                                    </div>
                                    <div class="col-xs-12 col-sm-6 col-md-6">
                                        <label class="is_main"><input type="radio" name="is_main" onclick="nv_image_main($(this));" value="{IMAGE.index}" {IMAGE.ch_is_main} />{LANG.image_main}</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: loop -->
                </div>
            </div>
        </div>
        <!-- END: images -->
        <div class="form-group">
            <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong>{LANG.wid} </strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <!-- BEGIN: groups_widget -->
                <div class="col-xs-12 col-sm-8 col-md-6">
                    <label><input type="checkbox" name="wid[]" value="{GROUPS_WIDGET.value}" {GROUPS_WIDGET.checked} />{GROUPS_WIDGET.title}</label>
                </div>
                <!-- END: groups_widget -->
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong>{LANG.faci} </strong></label>
            <div class="col-sm-19 col-md-20 p-tb5 p-lr15">
                <!-- BEGIN: groups_faci -->
                <div class="col-xs-12 col-sm-8 col-md-6">
                    <label><input type="checkbox" name="faci[]" value="{GROUPS_FACI.value}" {GROUPS_FACI.checked} />{GROUPS_FACI.title}</label>
                </div>
                <!-- END: groups_faci -->
            </div>
        </div>
        <label class="col-sm-5 col-md-4 control-label"><strong>Vị trí trên bản đồ </strong></label>
        <div class="col-sm-19 col-md-20 p-tb5 p-lr15" style="min-height: 35px;">
            <label class="btn btn-primary" style="padding-left: inherit !important"><input type="checkbox" name="display_maps" value="1" id="display_maps"{ROW.ck_display_maps}>{LANG.display_maps}</label>
            <div id="maps" class="p-tb5 p-lr5">
                <!-- BEGIN: maps -->
                {MAPS}
                <!-- END: maps -->
            </div>
        </div>
        <!-- BEGIN: required_maps_appid -->
        <div class="alert alert-danger">{LANG.error_required_maps_appid}</div>
        <!-- END: required_maps_appid -->
        <h2 class="title">{LANG.contact_info}</h2>
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_fullname} <span class="require">(*)</span></strong></label>
            <div class="col-sm-16 col-md-14">
                <input class="form-control" type="text" name="contact_fullname" value="{ROW.contact_fullname}" />
            </div>
        </div>
        <div class="form-group form-tooltip">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_email} <span class="require">(*)</span></strong><em class="fa fa-question-circle fa-pointer text-info" data-toggle="tooltip" data-original-title="{LANG.contact_email_note}">&nbsp;</em></label>
            <div class="col-sm-16 col-md-14">
                <input class="form-control" type="email" name="contact_email" value="{ROW.contact_email}" id="contact_email" oninvalid="setCustomValidity( nv_email )" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_phone} <span class="require">(*)</span></strong></label>
            <div class="col-sm-16 col-md-14">
                <input class="form-control" type="text" name="contact_phone" value="{ROW.contact_phone}" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_address} <span class="require">(*)</span></strong></label>
            <div class="col-sm-16 col-md-14">
                <input class="form-control" type="text" name="contact_address" value="{ROW.contact_address}" />
            </div>
        </div>

        <h2 class="title">HÌNH THỨC ĐĂNG</h2>
        <div id="group_posting_single">
            <div id="only_website">
                <div class="form-group">
                    <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong> </strong></label>
                    <div class="col-sm-16 col-md-14">Để đáp ứng tốt hơn nhu cầu của Khách hàng, chúng tôi hỗ trợ dịch vụ đăng tin Hot, tin Vip với nhiều ưu đãi về hình thức và vị trí hiển thị.</div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong>Loại tin đăng</strong></label>
                    <div class="col-sm-16 col-md-14">
                        <select class="form-control" name="post_type" id="post_type">
                            <!-- BEGIN: post_type -->
                            <option value="{POST_TYPE.id}" {POST_TYPE.checked}>{POST_TYPE.title}</option>
                            <!-- END: post_type -->
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong>Thời gian đăng</strong></label>
                    <div class="col-sm-16 col-md-14">
                        <div class="input-group input-daterange" id="group_date" style="width: 100%">
                            <input type="text" id="starttime" name="starttime" value="{ROW.starttime}" class="form-control inputmask time_picker">
                            <span class="input-group-addon">đến</span>
                            <input type="text" id="exptime" name="exptime" value="{ROW.exptimef}" class="form-control inputmask time_picker">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong>Thành tiền</strong></label>
                    <div class="col-sm-16 col-md-14">
                        <table class="table table-striped table-bordered" id="price_info">
                                    
                        </table>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right"><strong> </strong></label>
                <div class="col-sm-16 col-md-14">
                    <div class="checkbox">
                        <label> <input type="checkbox" name="autopost" value="1" id="autopost" {ROW.autopost_checked}> <b>Đăng tin trên nhiều website, tăng cường khả năng tiếp cận khách mua/thuê</b>
                        </label>
                    </div>
                </div>
            </div>
            <fieldset id="fl_autopost">
                <div class="form-group">
                    <label class="col-sm-5 col-md-4 p-tb5 p-lr15 text-right control-label">Gói đăng tin</label>
                    <div class="col-sm-17 col-md-18 p-tb5">
                        <div class="row" id="posting_package">
                            <div class="col-xs-8">
                                <div class="packages alert alert-warning">
                                    <!-- BEGIN: package -->
                                    <div class="radio">
                                        <label> <input class="package" type="radio" name="package" value="{PACKAGE.id}" {PACKAGE.checked}> <b>{PACKAGE.title}</b><br> ({PACKAGE.price} đ)
                                        </label>
                                    </div>
                                    <!-- END: package -->
                                </div>
                            </div>
                            <div class="col-xs-16">
                                <div class="table-responsive table-scroll " id="pk_1">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
        

        <!-- BEGIN: requeue -->
        <div class="alert alert-warning text-center">
            <p>{LANG.requeue_note}</p>
            <label class="show"><input type="checkbox" name="requeue" value="1">{LANG.requeue}</label>
        </div>
        <!-- END: requeue -->
        <!-- BEGIN: captcha -->
        <div class="form-group text-center ">
            <div class="middle clearfix justify-content d-flex">
                <img width="{GFX_WIDTH}" height="{GFX_HEIGHT}" title="{LANG.captcha}" alt="{LANG.captcha}" src="{NV_BASE_SITEURL}index.php?scaptcha=captcha&t={NV_CURRENTTIME}" class="captchaImg display-inline-block"> <em onclick="change_captcha('.fcode');" title="{GLANG.captcharefresh}" class="fa fa-pointer fa-refresh margin-left margin-right"></em>
                <input type="text" placeholder="{LANG.captcha}" maxlength="{NV_GFX_NUM}" value="" name="fcode" id="fcode" class="fcode required form-control display-inline-block" style="width: 100px;" data-pattern="/^(.){{NV_GFX_NUM},{NV_GFX_NUM}}$/" onkeypress="nv_validErrorHidden(this);" data-mess="{LANG.error_captcha}" />
            </div>
        </div>
        <!-- END: captcha -->
        <!-- BEGIN: recaptcha -->
        <div class="form-group">
            <div class="middle text-center clearfix justify-content d-flex">
                <div class="nv-recaptcha-default">
                    <div id="{RECAPTCHA_ELEMENT}"></div>
                </div>
                <script type="text/javascript">
                nv_recaptcha_elements.push({
                    id: "{RECAPTCHA_ELEMENT}",
                    btn: $('[type="submit"]', $('#{RECAPTCHA_ELEMENT}').parent().parent().parent().parent())
                })
                </script>
            </div>
        </div>
        <!-- END: recaptcha -->
        <div class="form-group text-center">
            <!-- BEGIN: fullform -->
            <a class="btn btn-success" href="{URL_CONTENT}">{LANG.fullform}</a>
            <!-- END: fullform -->
            <input type="hidden" name="submit" value="1" />
            <input class="btn btn-primary loading" type="submit" value="{LANG.submit}" />
        </div>
    </form>
</div>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery/jquery.slimscroll.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/market_autoNumeric-1.9.41.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<!-- BEGIN: images_js -->
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/plupload/jquery.plupload.queue/jquery.plupload.queue.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/plupload/i18n/{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript">
// Initialize the widget when the DOM is ready
$(function() {

    function auto_check_autopost(){
        var checked = $("#autopost:checked").length;
        if(checked){
        	$("#only_website").hide('slow');            
        	$("#fl_autopost").attr("disabled", false);            
        }else{
            $("#only_website").show('slow');            
        	$("#fl_autopost").attr("disabled", true);
        }
    }
    
    auto_check_autopost();
    
    $('#autopost').change(function(){
        auto_check_autopost();
    });
    
    
    function auto_load_packages_info(id){
		$.ajax({
			type : 'POST',
			url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
			data : 'load_packages_info=1&id=' + id,
			success : function(data) {
				$('#pk_1').html(data);
			}
		});
    }
    
    auto_load_packages_info($('.package').val());
    
    $('.package').change(function() {
        auto_load_packages_info($(this).val());           
	});
    
    function auto_load_price_info(){
        var post_type = $('#post_type').val();
	    var starttime = $('#starttime').val();
	    var exptime = $('#exptime').val();
	    
		$.ajax({
			type : 'POST',
			url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
			data : 'load_price_info=1&post_type=' + post_type + '&starttime=' + starttime + '&exptime=' + exptime,
			success : function(data) {
				$('#price_info').html(data);
			}
		});
    }
    
    auto_load_price_info();
    
    $('#post_type, #starttime, #exptime').change(function() {
        auto_load_price_info();
	});
	
	var i = {COUNT};
	
	$('#imagelist').slimScroll({
        height: '315px'
    });
	
    // Setup html5 version
    initUploader();
    
    function initUploader(){
        $("#uploader").pluploadQueue({
            // General settings
            runtimes : 'html5,flash,silverlight,html4',
            url : "{UPLOAD_URL}",
            rename : true,
            dragdrop: true,
     
            // Flash settings
            flash_swf_url : '{NV_BASE_SITEURL}themes/default/js/plupload/Moxie.swf',
         
            // Silverlight settings
            silverlight_xap_url : '{NV_BASE_SITEURL}themes/default/js/plupload/Moxie.xap',
            
            init: {
    			FilesAdded: function (up, files) {
    				this.start();
    				return false;
    			},
    			UploadComplete: function (up, files) {
    				$('#imagelist').slimScroll({
    	                height: '315px'
    	            });
    				up.destroy();
                    initUploader();
    			},
                FileUploaded: function(up, file, response) {
    				var content = $.parseJSON(response.response);
    				var item = '';
    				item += '<div class="image">';
    				item += '<em class="fa fa-times-circle fa-lg fa-pointer" title="{LANG.image_delete}" onclick="$(this).parent().remove();">&nbsp;</em>';
    				item += '<div class="row m-bottom">';
    				item += '	<div class="col-xs-24 col-sm-4 col-md-4 text-center">';
    				item += '		<input type="hidden" name="images[' + i + '][path]" value="' + content.homeimgfile + '" />';
    				item += '		<img class="img-thumbnail" src="' + content.path + '" width="100%" />';
    				item += '	</div>';
    				item += '	<div class="col-xs-24 col-sm-20 col-md-20" style="overflow: hidden;">';
    				item += '		<h2>' + content.basename + '</h2>';
    				item += '		<div class="row">';
    				item += '			<div class="col-xs-12 col-sm-18 col-md-18">';
    				item += '				<input type="text" name="images[' + i + '][description]" class="form-control input-sm" placeholder="{LANG.image_description}" />';
    				item += '			</div>';
    				item += '			<div class="col-xs-12 col-sm-6 col-md-6">';
    				item += '				<label class="is_main"><input type="radio" name="is_main" onclick="nv_image_main($(this));" value="' + i + '" />{LANG.image_main}</label>';
    				item += '			</div>';
    				item += '		</div>';
    				item += '	</div>';
    				item += '</div>';
    				item += '</div>';
    				$('#imagelist').append(item);
    				nv_image_main_check();
    				++i;
                }
    		}
        });
    }
});
</script>
<!-- END: images_js -->
<script>
	$(document).ready(function() {
	    
	    $('#frm-submit').submit(function(e){
	        e.preventDefault();

	        if (typeof (CKEDITOR) !== "undefined") {
	            for (instance in CKEDITOR.instances) {
	                CKEDITOR.instances[instance].updateElement();
	            }
	        }

	        $.ajax({
	        	type : 'POST',
	        	url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=content&nocache=' + new Date().getTime(),
	        	data : $(this).serialize(),
	        	success : function(json) {
	        	    if(json.msg){
	        	        alert(json.msg);
	        	    }
	        		if(json.error){
	        		    if(json.input){
	        		        $('#' + json.input).focus();
	        		    }
	        		    $('.ajax-load-qa').remove();
	        		    return !1;
	        		}
	        		window.location.href = json.redirect;
	        	}
	        });
	    });

		$('.tooltip-focus').tooltip({
		    trigger: "focus"
		});
		
		$(".datepicker").datepicker({
			dateFormat : "dd/mm/yy",
			changeMonth : true,
			changeYear : true,
			showOtherMonths : true,
			showOn : "focus",
			yearRange : "-90:+10",
		});

		$('#catid').change(function() {
			$.ajax({
				type : 'POST',
				url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
				data : 'load_pricetype=1&catid=' + $(this).val() + '&pricetype=' + $('#pricetype').val() + '&price=' + $('#price').val() + '&price1=' + $('#price1').val() + '&unitid=' + $('#unitid').val(),
				success : function(data) {
					$('#div-pricetype').html(data);
				}
			});
			
			nv_market_cat_change({ROW.id}, $(this).val());
		});
		
		$('input[name="auction"]').change(function(){
			if($(this).is(':checked')){
				$('#auction-block').slideDown();
			}else{
				$('#auction-block').slideUp();
			}
		});
		
		$('#display_maps').change(function(){
		    if($(this).is(':checked')){
		        $.ajax({
					type : 'POST',
					url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
					data : 'load_maps=1',
					success : function(html) {
					    $('#maps').html(html);
					}
				});
		    }else{
		        $('#maps').html('');
		    }
		});
	});
	
	function nv_get_alias(id) {
		var title = strip_tags($("[name='title']").val());
		if (title != '') {
			$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name
					+ '&' + nv_fc_variable + '=content&nocache='
					+ new Date().getTime(), 'get_alias_title='
					+ encodeURIComponent(title), function(res) {
				$("#" + id).val(strip_tags(res));
			});
		}
		return false;
	}
	
	function nv_image_main($_this)
	{
		$('#imagelist .image').each(function(){
			$(this).removeClass('is_main');
		});
		
		if($_this.is(':checked')){
			$_this.closest('.image').addClass('is_main');
		}
	}

	function nv_image_main_check()
	{
		if($('input[name="is_main"]:checked').length == 0){
			$('#imagelist .image:first').addClass('is_main');
			$('input[name="is_main"]:first').prop('checked', true);
		}
	}
</script>
<!-- BEGIN: auto_get_alias -->
<script>
	//<![CDATA[
	$("[name='title']").change(function() {
		nv_get_alias('id_alias');
	});
	//]]>
</script>
<!-- END: auto_get_alias -->
<!-- BEGIN: check_similar_content -->
<script>
	$(document).ready(function() {
		CKEDITOR.instances.market_content.on('blur', function() {
			var content = CKEDITOR.instances['market_content'].getData();
			if(content != ''){
				$.ajax({
					type : 'POST',
					url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&check_similar_content=1&nocache=' + new Date().getTime(),
					data : {
						html: content
					},
					success : function(res) {
						if(res != 'OK'){
							alert('{LANG.error_similar_content}');
							CKEDITOR.instances['market_content'].focus();
						}
					}
				});	
			}
		});
	});
</script>
<!-- END: check_similar_content -->

<script type="text/javascript" src="/{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
    $(".time_picker").datepicker({
        dateFormat: "dd/mm/yy",
        changeMonth: !0,
        changeYear: !0,
        showOtherMonths: !0,
        showOn: "focus",
        yearRange: "-90:+0"
    });
</script>
<!-- END: main -->
<!-- BEGIN: price_info -->
<tbody>
    <tr>
        <td>Đơn giá</td>
        <td align="right">
            <span id="price_per_day">{PRICE_INFO.price_per_day}</span> VND/ngày
        </td>
    </tr>
    <tr>
        <td>Số ngày</td>
        <td align="right">
            <span id="days_calculate">{PRICE_INFO.days_calculate}</span> ngày
            <input type="hidden" name="days_calculate" value="{PRICE_INFO.days_calculate}" />
        </td>
    </tr>
    <tr>
        <td>Phí đăng tin</td>
        <td align="right">
            <span id="price_subtotal">{PRICE_INFO.price_subtotal}</span> VND
        </td>
    </tr>
    <tr>
        <td>Khuyến mại</td>
        <td align="right">0 VND</td>
    </tr>
    <tr>
        <td>Tổng tiền</td>
        <td align="right">
            <span id="price_total">{PRICE_INFO.price_total}</span> VND
            <input type="hidden" name="price_info" value="{PRICE_INFO.price_total_input}" />
        </td>
    </tr>
</tbody>
<!-- END: price_info -->
<!-- BEGIN: table_packages -->
<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <th width="50%">Website</th>
            <th width="50%">Ghi chú</th>
        </tr>
    </thead>
    <tbody>
        <!-- BEGIN: loop -->
        <tr>
            <td>{LIST.number}. {LIST.list.link}</td>
            <td>{LIST.list.note}</td>
        </tr>
        <!-- END: loop -->
    </tbody>
</table>
<!-- END: table_packages -->