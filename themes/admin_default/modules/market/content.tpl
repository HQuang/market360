<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/default/js/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css">
<form class="form-horizontal" action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}&amp;id={ROW.id}&amp;redirect={REDIRECT}" method="post" id="frm-submit">
    <div class="row">
        <div class="col-xs-24 col-sm-19">
            <div class="panel panel-default">
                <div class="panel-body">
                    <input type="hidden" name="id" value="{ROW.id}" />
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.type}</strong> <span class="red">(*)</span></label>
                        <div class="col-sm-19 col-md-20">
                            <!-- BEGIN: type -->
                            <label><input type="radio" name="typeid" value="{TYPE.id}" {TYPE.checked} />{TYPE.title}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <!-- END: type -->
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.title}</strong> <span class="red">(*)</span></label>
                        <div class="col-sm-19 col-md-20">
                            <input class="form-control" type="text" name="title" value="{ROW.title}" id="title" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.alias}</strong></label>
                        <div class="col-sm-19 col-md-19">
                            <input class="form-control" type="text" name="alias" value="{ROW.alias}" id="id_alias" />
                        </div>
                        <div class="col-sm-4 col-md-1">
                            <i class="fa fa-refresh fa-lg icon-pointer" onclick="nv_get_alias('id_alias');">&nbsp;</i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.catid}</strong> <span class="red">(*)</span></label>
                        <div class="col-sm-19 col-md-20">
                            <select name="catid" class="form-control select2b" id="catid">
                                <option value=0>---{LANG.cat_c}---</option>
                                <!-- BEGIN: cat -->
                                <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                                <!-- END: cat -->
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.code}</strong> <!-- BEGIN: required_code --> <span class="red">(*)</span> <!-- END: required_code --> <em class="fa fa-info-circle fa-pointer text-info" data-toggle="tooltip" data-original-title="{LANG.code_note}">&nbsp;</em> </label>
                        <div class="col-sm-19 col-md-20">
                            <input class="form-control" type="text" name="code" value="{ROW.code}" id="code"
                            <!-- BEGIN: disabled_code -->
                            readonly="readonly"
                            <!-- END: disabled_code -->
                            <!-- BEGIN: required_code1 -->
                            required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')"
                            <!-- END: required_code1 -->
                            />
                        </div>
                    </div>
                    <div id="div-pricetype">{PRICETYPE}</div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.description}</strong></label>
                        <div class="col-sm-19 col-md-20">
                            <textarea class="form-control" name="description" rows="5">{ROW.description}</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.content}</strong> <span class="red">(*)</span></label>
                        <div class="col-sm-19 col-md-20" id="content">{ROW.content}</div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.note}</strong></label>
                        <div class="col-sm-19 col-md-20">
                            <textarea class="form-control" style="height: 100px;" cols="75" rows="5" name="note">{ROW.note}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default hide">
                <div class="panel-heading">{LANG.pack_money}</div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"></label>
                        <div class="col-sm-19 col-md-20">
                            <!-- BEGIN: pack_money -->
                            <label class="container"><input type="radio" name="pack_money" value="{PACK_MONEY.id}"{PACK_MONEY.checked}>{PACK_MONEY.title}</label>
                            <!-- END: pack_money -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.image}</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-24 col-sm-12">
                            <div id="uploader">
                                <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
                            </div>
                        </div>
                        <div class="col-xs-24 col-sm-12">
                            <div id="imagelist" style="border: solid 1px #ddd; padding: 10px; height: 360px">
                                <!-- BEGIN: images -->
                                <div class="image <!-- BEGIN: is_main -->is_main<!-- END: is_main -->">
                                    <em class="fa fa-times-circle fa-lg fa-pointer" title="{LANG.image_delete}" onclick="$(this).parent().remove();">&nbsp;</em>
                                    <div class="row m-bottom">
                                        <div class="col-xs-24 col-sm-4 text-center">
                                            <input type="hidden" name="images[{IMAGE.index}][path]" value="{IMAGE.homeimgfile}" />
                                            <img class="img-thumbnail" src="{IMAGE.path}" width="100%" />
                                        </div>
                                        <div class="col-xs-24 col-sm-20">
                                            <h2>{IMAGE.basename}</h2>
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-18">
                                                    <input type="text" name="images[{IMAGE.index}][description]" value="{IMAGE.description}" class="form-control input-sm" placeholder="{LANG.image_description}" />
                                                </div>
                                                <div class="col-xs-12 col-sm-6">
                                                    <label class="is_main"><input type="radio" name="is_main" onclick="nv_image_main($(this));" value="{IMAGE.index}" {IMAGE.ch_is_main} />{LANG.image_main}</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: images -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    {LANG.location} <label class="pull-right"><input type="checkbox" name="display_maps" value="1" id="display_maps"{ROW.ck_display_maps}>{LANG.display_maps}</label>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-10 col-xs-24">
                                <input type="text" class="form-control" name="address" value="{ROW.address}" placeholder="{LANG.contact_address}" />
                            </div>
                            <div class="col-md-14 col-xs-24">{LOCATION}</div>
                        </div>
                    </div>
                    <div id="maps">
                        <!-- BEGIN: maps -->
                        {MAPS}
                        <!-- END: maps -->
                    </div>
                    <!-- BEGIN: required_maps_appid -->
                    <div class="alert alert-danger">{LANG.error_required_maps_appid}</div>
                    <!-- END: required_maps_appid -->
                </div>
            </div>
            <div id="custom_form">{DATACUSTOM_FORM}</div>
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.contact_info}</div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_fullname}</strong></label>
                        <div class="col-sm-19 col-md-20">
                            <input class="form-control" type="text" name="contact_fullname" value="{ROW.contact_fullname}" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_email}</strong></label>
                        <div class="col-sm-19 col-md-20">
                            <input class="form-control" type="email" name="contact_email" value="{ROW.contact_email}" oninvalid="setCustomValidity( nv_email )" id="contact_email" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_phone}</strong></label>
                        <div class="col-sm-19 col-md-20">
                            <input class="form-control" type="text" name="contact_phone" value="{ROW.contact_phone}" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_address}</strong></label>
                        <div class="col-sm-19 col-md-20">
                            <input class="form-control" type="text" name="contact_address" value="{ROW.contact_address}" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">HÌNH THỨC ĐĂNG</div>
                <div id="group_posting_single" class="panel-body">
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
                                    <input type="text" id="starttime" name="starttime" value="{ROW.starttime}" class="form-control inputmask select_time">
                                    <span class="input-group-addon">đến</span>
                                    <input type="text" id="exptime" name="exptime" value="{ROW.exptimef}" class="form-control inputmask select_time">
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
                    <fieldset id="fl_autopost" disabled___>
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
            </div>
        </div>
        <div class="col-xs-24 col-sm-5">
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.adduser}</div>
                <div class="panel-body">
                    <select class="form-control" name="userid" id="userid">
                        <option value="0">{GLANG.guests}</option>
                        <!-- BEGIN: username -->
                        <option value="{ROW.userid}" selected="selected">{USERNAME}</option>
                        <!-- END: username -->
                    </select>
                </div>
            </div>
            <!-- BEGIN: block_cat -->
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.groups}</div>
                <div class="panel-body" style="height: 200px; overflow: scroll;">
                    <!-- BEGIN: loop -->
                    <div class="row">
                        <label><input type="checkbox" value="{BLOCKS.bid}" name="bids[]"{BLOCKS.checked}>{BLOCKS.title}</label>
                    </div>
                    <!-- END: loop -->
                </div>
            </div>
            <!-- END: block_cat -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>{LANG.wid}</strong>
                </div>
                <div class="panel-body" style="height: 200px; overflow: scroll;">
                    <!-- BEGIN: groups_widget -->
                    <label class="show"><input type="checkbox" name="wid[]" value="{GROUPS_WIDGET.value}" {GROUPS_WIDGET.checked} />{GROUPS_WIDGET.title}</label>
                    <!-- END: groups_widget -->
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>{LANG.faci}</strong>
                </div>
                <div class="panel-body" style="height: 200px; overflow: scroll;">
                    <!-- BEGIN: groups_faci -->
                    <label class="show"><input type="checkbox" name="faci[]" value="{GROUPS_FACI.value}" {GROUPS_FACI.checked} />{GROUPS_FACI.title}</label>
                    <!-- END: groups_faci -->
                </div>
            </div>
<!--             <div class="panel panel-default"> -->
<!--                 <div class="panel-heading">{LANG.exptime}</div> -->
<!--                 <div class="panel-body"> -->
<!--                     <div class="form-group"> -->
<!--                         <div class="row m-bottom"> -->
<!--                             <div class="col-xs-24 col-sm-12"> -->
<!--                                 <select name="begintime_hour" class="form-control"> -->
<!--                                     <option value="0">---{LANG.hour_select}---</option> -->
<!--                                     BEGIN: hour -->
<!--                                     <option value="{HOUR.index}"{HOUR.selected}>{HOUR.index}</option> -->
<!--                                     END: hour -->
<!--                                 </select> -->
<!--                             </div> -->
<!--                             <div class="col-xs-24 col-sm-12"> -->
<!--                                 <select name="begintime_min" class="form-control"> -->
<!--                                     <option value="0">---{LANG.min_select}---</option> -->
<!--                                     BEGIN: min -->
<!--                                     <option value="{MIN.index}"{MIN.selected}>{MIN.index}</option> -->
<!--                                     END: min -->
<!--                                 </select> -->
<!--                             </div> -->
<!--                         </div> -->
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
            <!-- BEGIN: auction -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <label><input type="checkbox" name="auction" value="1" {ROW.ck_auction} />{LANG.auction}</label>
                </div>
                <div class="panel-body" id="auction-block"{ROW.auction_style}>
                    <label><strong>{LANG.auction_begin}</strong> <span class="red">(*)</span></label>
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
                                    <input class="form-control datepicker" type="text" name="auction_begin_date" value="{ROW.auction_beginf}" pattern="^[0-9]{2,2}\/[0-9]{2,2}\/[0-9]{1,4}$" />
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button">
                                            <em class="fa fa-calendar fa-fix"> </em>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <label><strong>{LANG.auction_end}</strong> <span class="red">(*)</span></label>
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
                                    <input class="form-control datepicker" type="text" name="auction_end_date" value="{ROW.auction_endf}" pattern="^[0-9]{2,2}\/[0-9]{2,2}\/[0-9]{1,4}$" />
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button" id="exptime-btn">
                                            <em class="fa fa-calendar fa-fix"> </em>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <label><strong>{LANG.auction_price_begin}</strong> <span class="red">(*)</span></label>
                    <div class="form-group">
                        <div class="input-group">
                            <input type="text" name="auction_price_begin" value="{ROW.auction_price_begin}" class="form-control price" />
                            <span class="input-group-addon">{MONEY_UNIT}</span>
                        </div>
                    </div>
                    <label><strong>{LANG.auction_price_step}</strong> <span class="red">(*)</span></label>
                    <div class="form-group">
                        <div class="input-group">
                            <input type="text" name="auction_price_step" value="{ROW.auction_price_step}" class="form-control price" />
                            <span class="input-group-addon">{MONEY_UNIT}</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: auction -->
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.keywords}</div>
                <div class="panel-body">
                    <select class="form-control" name="keywords[]" id="keywords" multiple="multiple">
                        <!-- BEGIN: keywords -->
                        <option value="{KEYWORDS.tid}" selected="selected">{KEYWORDS.title}</option>
                        <!-- END: keywords -->
                    </select>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.groupview}</div>
                <div class="panel-body" style="height: 300px; overflow: scroll;">
                    <!-- BEGIN: groups_view -->
                    <label class="show"><input type="checkbox" name="groupview[]" value="{GROUPS_VIEW.value}" {GROUPS_VIEW.checked} />{GROUPS_VIEW.title}</label>
                    <!-- END: groups_view -->
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">{LANG.groupcomment}</div>
                <div class="panel-body" style="height: 300px; overflow: scroll;">
                    <!-- BEGIN: groups_comment -->
                    <label class="show"><input type="checkbox" name="groupcomment[]" value="{GROUPS_COMM.value}" {GROUPS_COMM.checked} />{GROUPS_COMM.title}</label>
                    <!-- END: groups_comment -->
                </div>
            </div>
            <!-- BEGIN: remove_link -->
            <div class="panel panel-default">
                <div class="panel-body">
                    <label><input type="checkbox" value="1" name="remove_link"{ROW.ck_remove_link}>{LANG.remove_link}</label>
                </div>
            </div>
            <!-- END: remove_link -->
        </div>
    </div>
    <!-- BEGIN: queue -->
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.queue_action}</div>
        <div class="panel-body">
            <!-- BEGIN: queue_logs -->
            <div class="form-group">
                <label class="col-sm-5 col-md-3 text-right"><strong>{LANG.queue_logs}</strong></label>
                <div class="col-sm-19 col-md-21">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <colgroup>
                                <col />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>{LANG.queue_type}</th>
                                    <th>{LANG.queue_reason}</th>
                                    <th>{LANG.reason_other}</th>
                                    <th>{LANG.queue_userid}</th>
                                    <th>{LANG.queue_time}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- BEGIN: loop -->
                                <tr>
                                    <td>{QUEUE_LOGS.type}</td>
                                    <td>{QUEUE_LOGS.reasonid}</td>
                                    <td>{QUEUE_LOGS.reason}</td>
                                    <td>{QUEUE_LOGS.name}</td>
                                    <td>{QUEUE_LOGS.addtime}</td>
                                </tr>
                                <!-- END: loop -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- END: queue_logs -->
            <div class="form-group">
                <label class="col-sm-5 col-md-3 text-right"><strong>{LANG.queue_action_atc}</strong></label>
                <div class="col-sm-19 col-md-21">
                    <!-- BEGIN: queue_action -->
                    <label><input type="radio" name="queue" value="{QUEUE_ACTION.index}" {QUEUE_ACTION.checked} />{QUEUE_ACTION.value}</label>&nbsp;&nbsp;&nbsp;
                    <!-- END: queue_action -->
                </div>
            </div>
            <div class="form-group" id="queue_reason"{ROW.queue_reason_style}>
                <div class="form-group">
                    <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.reason_c}</strong></label>
                    <div class="col-sm-19 col-md-21">
                        <select name="queue_reasonid" class="form-control">
                            <option value="0">---{LANG.reason_c}---</option>
                            <!-- BEGIN: reason -->
                            <option value="{REASON.id}">{REASON.title}</option>
                            <!-- END: reason -->
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.queue_reason}</strong></label>
                    <div class="col-sm-19 col-md-21">
                        <textarea class="form-control" name="queue_reason">{ROW.queue_reason}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END: queue -->
    <div class="form-group text-center">
        <input type="hidden" name="submit" value="1" />
        <input class="btn btn-primary loading" type="submit" value="{LANG.save}" />
    </div>
</form>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/market_autoNumeric-1.9.41.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
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
			url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax',
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
			url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax',
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
        height: '360px'
    });
	
	initUploader();
	
    // Setup html5 version
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
    	                height: '360px'
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
    				item += '	<div class="col-xs-24 col-sm-4 text-center">';
    				item += '		<input type="hidden" name="images[' + i + '][path]" value="' + content.homeimgfile + '" />';
    				item += '		<img class="img-thumbnail" src="' + content.path + '" width="100%" />';
    				item += '	</div>';
    				item += '	<div class="col-xs-24 col-sm-20">';
    				item += '		<h2>' + content.basename + '</h2>';
    				item += '		<div class="row">';
    				item += '			<div class="col-xs-12 col-sm-18">';
    				item += '				<input type="text" name="images[' + i + '][description]" class="form-control input-sm" placeholder="{LANG.image_description}" />';
    				item += '			</div>';
    				item += '			<div class="col-xs-12 col-sm-6">';
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
	        	url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=content&nocache=' + new Date().getTime(),
	        	data : $(this).serialize(),
	        	success : function(json) {
	        		if(json.error){
	        		    alert(json.msg);
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
	    
		$('#keywords').select2({
			tags : true,
			language : '{NV_LANG_INTERFACE}',
			theme : 'bootstrap',
			tokenSeparators : [ ',' ],
			ajax : {
				url : script_name + "?" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=content&get_keywords=1",
				processResults : function(data, page) {
					return {
						results : data
					};
				}
			}
		});

		$(".datepicker").datepicker({
			dateFormat : "dd/mm/yy",
			changeMonth : true,
			changeYear : true,
			showOtherMonths : true,
			showOn : "focus",
			yearRange : "-90:+10"
		});

		$('.select2b').select2({
			theme : 'bootstrap',
			language : '{NV_LANG_INTERFACE}'
		});

		$('#catid').change(function() {
		    var catid = $(this).val();
			$.ajax({
				type : 'POST',
				url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax',
				data : 'load_pricetype=1&catid=' + catid + '&pricetype=' + $('#pricetype').val() + '&price=' + $('#price').val() + '&price1=' + $('#price1').val() + '&unitid=' + $('#unitid').val(),
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
		
		$('input[name="queue"]').change(function(){
			if($(this).val() == 2){
				$('#queue_reason').show();
			}else{
				$('#queue_reason').hide();
			}
		});
		
		$("#userid").select2({
			language: "{NV_LANG_INTERFACE}",
			theme: "bootstrap",
			ajax: {
		    url: script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&get_user_json=1',
		    	dataType: 'json',
		    	delay: 250,
		    	data: function (params) {
		      		return {
		      			q: params.term, // search term
		      			page: params.page
		      		};
		      	},
		    	processResults: function (data, params) {
		    		params.page = params.page || 1;
		    		return {
		    			results: data,
		    			pagination: {
		    				more: (params.page * 30) < data.total_count
		    			}
		    		};
		    	},
			cache: true
			},
			escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
			minimumInputLength: 3,
			templateResult: formatRepo, // omitted for brevity, see the source of this page
			templateSelection: formatRepoSelection // omitted for brevity, see the source of this page
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
	
	function formatRepo (repo) {
		if (repo.loading) return repo.text;
		var markup = '<div class="clearfix">' +
		'<div class="col-sm-19">' + repo.username + '</div>' +
	    '<div clas="col-sm-5"><span class="show text-right">' + repo.fullname + '</span></div>' +
	    '</div>';
		markup += '</div></div>';
		return markup;
	}
	
	function formatRepoSelection (repo) {
		$('#username').val( repo.username );
		return repo.username || repo.text;
	}

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
    $(".select_time").datepicker({
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