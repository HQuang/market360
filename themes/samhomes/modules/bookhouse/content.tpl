<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css" />
<div class="items m-bottom">
    <form action="{ACTION}" method="POST" id="items" name="items" class="form-horizontal" enctype="multipart/form-data">
        <input name="id" type="hidden" value="{ID}">
        <div class="row">
            <div class="col-md-19">
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.main_info}</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 text-right"><strong>{LANG.type}</strong></label>
                            <div class="col-sm-19 col-md-20 idtype">
                                <!-- BEGIN: type -->
                                <label><input class="form-control typeid required" type="radio" name="typeid" id="typeid" value="{TYPE.key}" {TYPE.checked}required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')">{TYPE.title} &nbsp;</label>
                                <!-- END: type -->
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.title}</strong> </label>
                            <div class="col-xs-24 col-sm-20 col-md-20">
                                <input type="text" class="form-control required" name="title" id="idtitle" value="{DATA.title}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.category_cat_parent}</strong> </label>
                            <div class="col-xs-24 col-sm-20 col-md-20">
                                <select name="catid" id="catid" class="form-control required sselect2" onchange="nv_bookhouse_cat_change({DATA.id}, $(this).val()">
                                    <option value="0">---{LANG.cat_chose}---</option>
                                    <!-- BEGIN: cat -->
                                    <option value="{CAT.id}"{CAT.selected}>{CAT.name}</option>
                                    <!-- END: cat -->
                                </select>
                            </div>
                        </div>
                        <!-- BEGIN: room -->
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.items_room}</strong></label>
                            <div class="col-xs-24 col-sm-20 col-md-20">
                                <div style="max-height: 200px; overflow: auto">
                                    <table class="table table-striped table-bordered table-hover w400">
                                        <tbody>
                                            <!-- BEGIN: loop -->
                                            <tr>
                                                <td>{ROOM.name}</td>
                                                <td>
                                                    <input type="number" name="room[{ROOM.id}]" value="{ROOM.value}" class="form-control" />
                                                </td>
                                            </tr>
                                            <!-- END: loop -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- END: room -->
                        <!-- BEGIN: area -->
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.items_area} (m<sup>2</sup>)
                            </strong> </label>
                            <div class="col-xs-24 col-sm-20 col-md-20">
                                <input type="text" class="form-control" name="area" value="{DATA.area}" />
                            </div>
                        </div>
                        <!-- END: area -->
                        <!-- BEGIN: size -->
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.size} (m) </strong> </label>
                            <div class="col-xs-24 col-sm-20 col-md-20">
                                <div class="row">
                                    <div class="col-sm-12 col-md-12">
                                        <input type="text" class="form-control" name="size_h" value="{DATA.size_h}" placeholder="{LANG.size_h}" />
                                    </div>
                                    <div class="col-sm-12 col-md-12">
                                        <input type="text" class="form-control" name="size_v" value="{DATA.size_v}" placeholder="{LANG.size_v}" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: size -->
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.items_price}</strong></label>
                            <div class="col-xs-24 col-sm-7 col-md-7">
                                <input type="text" class="form-control required money" name="price" id="price" value="{DATA.price}" />
                            </div>
                            <div class="col-xs-24 col-sm-3 col-md-3">
                                <select class="form-control" name="money_unit">
                                    <!-- BEGIN: money_unit -->
                                    <option value="{UNIT.key}"{UNIT.selected}>{UNIT.value}</option>
                                    <!-- END: money_unit -->
                                </select>
                            </div>
                            <div class="col-xs-24 col-sm-10 col-md-10">
                                <select name="price_time" id="price_time" class="form-control">
                                    <option value="0">---{LANG.pricetype_select}---</option>
                                    <!-- BEGIN: price_time -->
                                    <option value="{PRICETIME.index}"{PRICETIME.selected}>{PRICETIME.value}</option>
                                    <!-- END: price_time -->
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.items_image}</strong></label>
                            <div class="col-sm-19 col-md-20">
                                <div class="m-bottom">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="homeimgfile" value="{DATA.homeimgfile}" id="file_name" readonly="readonly"> <span class="input-group-btn">
                                            <button class="btn btn-default" onclick="$('#upload_fileupload').click();" type="button">
                                                <em class="fa fa-folder-open-o fa-fix">&nbsp;</em> {LANG.file_selectfile}
                                            </button>
                                        </span>
                                    </div>
                                    <input type="file" name="upload_fileupload" id="upload_fileupload" style="display: none" />
                                </div>
                                <em class="help-block"><small>{LANG.maxfilesize}: <strong>{MAXFILESIZE}</strong>, {LANG.image_size_limit}: <strong>{UPLOAD_IMG_SIZE}px</strong>. {LANG.image_other_note1}
                                </small></em>
                                <!-- BEGIN: image -->
                                <a href="#" title=""><img src="{DATA.homeimgfile}" class="img-thumbnail" width="150" onclick='modalShow("", "<img src=" + $(this).attr("src" ) + " class=\ "img-responsive\" />" );' /></a>
                                <!-- END: image -->
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.items_hometext}</strong> </label>
                            <div class="col-xs-24 col-sm-20 col-md-20">
                                <textarea class="form-control required" rows="5" name="hometext" oninput="setCustomValidity('')">{DATA.hometext}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-24 col-sm-4 col-md-4 control-label"><strong>{LANG.items_bodytext}</strong></label>
                            <div class="col-xs-24 col-sm-20 col-md-20">{DATA.bodytext}</div>
                        </div>
                    </div>
                </div>
                <div id="custom_form">{DATACUSTOM_FORM}</div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.image_other}</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <span class="text-danger m-bottom show">{LANG.image_other_add_note}</span>
                            <div id="uploader" class="m-bottom">
                                <p>{LANG.images_none_support}</p>
                            </div>
                            <div class="other-image row" id="image-other">
                                <!-- BEGIN: data -->
                                <div class="col-xs-4 col-sm-3 col-md-3 other-image-item" id="other-image-div-{DATA.number}">
                                    <input type="hidden" name="otherimage[{DATA.number}][id]" value="{DATA.id}"> <input type="hidden" name="otherimage[{DATA.number}][basename]" value="{DATA.title}"> <input type="hidden" name="otherimage[{DATA.number}][homeimgfile]" value="{DATA.homeimgfile}"> <input type="hidden" name="otherimage[{DATA.number}][thumb]" value="{DATA.thumb}"> <input type="hidden" name="otherimage[{DATA.number}][name]" value="{DATA.title}"> <input type="hidden" name="otherimage[{DATA.number}][description]" value="{DATA.description}"> <a href="#" onclick="modalShow('{DATA.basename}', '<img src=\' {DATA.filepath}\' class=\ 'img-responsive\' />'); return false;"> <img class="img-thumbnail m-bottom" src="{DATA.filepath}"></a> <em class="fa fa-times-circle fa-lg fa-pointer" onclick="nv_delete_other_images( {DATA.number} ); return false;">&nbsp;</em>
                                </div>
                                <!-- END: data -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.items_location}</div>
                    <div class="panel-body">
                        <div class="form-group">{LOCATION} {LOCATION1}</div>
                        <div class="form-group">
                            <input type="text" class="form-control required" name="address" id="address" value="{DATA.address}" placeholder="{LANG.items_address}" />
                        </div>
                        <!-- BEGIN: maps -->
                        <hr />
                        <div class="form-group">
                            <input type="text" class="form-control" name="maps_address" id="maps_address" value="" placeholder="{LANG.items_maps_location}">
                        </div>
                        <script type="text/javascript" src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/bookhouse-google_maps.js"></script>
                        <input type="hidden" id="maps_appid" value="{MAPS_APPID}" />
                        <div id="maps_maparea">
                            <div id="maps_mapcanvas" style="margin-top: 10px;" class="form-group"></div>
                            <div class="row form-group">
                                <div class="col-xs-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">L</span> <input type="text" class="form-control" name="maps[maps_mapcenterlat]" id="maps_mapcenterlat" value="{DATA.maps.maps_mapcenterlat}" readonly="readonly">
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">N</span> <input type="text" class="form-control" name="maps[maps_mapcenterlng]" id="maps_mapcenterlng" value="{DATA.maps.maps_mapcenterlng}" readonly="readonly">
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">L</span> <input type="text" class="form-control" name="maps[maps_maplat]" id="maps_maplat" value="{DATA.maps.maps_maplat}" readonly="readonly">
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">N</span> <input type="text" class="form-control" name="maps[maps_maplng]" id="maps_maplng" value="{DATA.maps.maps_maplng}" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">Z</span> <input type="text" class="form-control" name="maps[maps_mapzoom]" id="maps_mapzoom" value="{DATA.maps.maps_mapzoom}" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: maps -->
                        <!-- BEGIN: required_maps_appid -->
                        <div class="alert alert-danger">{LANG.items_required_maps_appid}</div>
                        <!-- END: required_maps_appid -->
                    </div>
                </div>
                <!-- BEGIN: contact_info -->
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.contact_info}</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_fullname}</strong></label>
                            <div class="col-sm-19 col-md-20">
                                <input class="form-control required" type="text" name="contact_fullname" value="{DATA.contact_fullname}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_email}</strong></label>
                            <div class="col-sm-19 col-md-20">
                                <input class="form-control required" type="email" name="contact_email" id="contact_email" value="{DATA.contact_email}" oninvalid="setCustomValidity( nv_email )" oninput="setCustomValidity('')" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_phone}</strong></label>
                            <div class="col-sm-19 col-md-20">
                                <input class="form-control required" type="text" name="contact_phone" value="{DATA.contact_phone}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.contact_address}</strong></label>
                            <div class="col-sm-19 col-md-20">
                                <input class="form-control" type="text" name="contact_address" value="{DATA.contact_address}" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: contact_info -->
            </div>
            <div class="col-md-5">
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.projects}</div>
                    <div class="panel-body">
                        <select class="form-control sselect2" name="projectid" id="projectid">
                            <option value="0">---{LANG.projetc_select}---</option>
                            <!-- BEGIN: projects -->
                            <option value="{PROJECTS.id}"{PROJECTS.selected}>{PROJECTS.title}</option>
                            <!-- END: projects -->
                        </select>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.way}</div>
                    <div class="panel-body">
                        <select class="form-control" name="way">
                            <option value="0">---{LANG.way_c}---</option>
                            <!-- BEGIN: way -->
                            <option value="{WAY.id}"{WAY.selected}>{WAY.title}</option>
                            <!-- END: way -->
                        </select>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.way_balcony}</div>
                    <div class="panel-body">
                        <select class="form-control" name="way_balcony">
                            <option value="0">---{LANG.way_balcony_c}---</option>
                            <!-- BEGIN: way_balcony -->
                            <option value="{WAY_BAL.id}"{WAY_BAL.selected}>{WAY_BAL.title}</option>
                            <!-- END: way_balcony -->
                        </select>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.legal}</div>
                    <div class="panel-body">
                        <select class="form-control" name="legal">
                            <option value="0">---{LANG.legal_c}---</option>
                            <!-- BEGIN: legal -->
                            <option value="{LEGAL.id}"{LEGAL.selected}>{LEGAL.title}</option>
                            <!-- END: legal -->
                        </select>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.publtime}</div>
                    <div class="panel-body">
                        <div class="row m-bottom">
                            <div class="col-xs-12">
                                <select class="form-control" name="publtime_hour">
                                    <option value="-1">---{LANG.hour_select}---</option>
                                    <!-- BEGIN: publtime_hour -->
                                    <option value="{HOUR.index}"{HOUR.selected}>{HOUR.index}</option>
                                    <!-- END: publtime_hour -->
                                </select>
                            </div>
                            <div class="col-xs-12">
                                <select class="form-control" name="publtime_min">
                                    <option value="-1">---{LANG.min_select}---</option>
                                    <!-- BEGIN: publtime_min -->
                                    <option value="{MIN.index}"{MIN.selected}>{MIN.index}</option>
                                    <!-- END: publtime_min -->
                                </select>
                            </div>
                        </div>
                        <div class="input-group">
                            <input class="form-control datepicker" value="{DATA.publtime_f}" type="text" name="publtime" readonly="readonly" /> <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <em class="fa fa-calendar fa-fix">&nbsp;</em>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.exptime}</div>
                    <div class="panel-body">
                        <div class="row m-bottom">
                            <div class="col-xs-12">
                                <select class="form-control" name="exptime_hour">
                                    <option value="-1">---{LANG.hour_select}---</option>
                                    <!-- BEGIN: exptime_hour -->
                                    <option value="{HOUR.index}"{HOUR.selected}>{HOUR.index}</option>
                                    <!-- END: exptime_hour -->
                                </select>
                            </div>
                            <div class="col-xs-12">
                                <select class="form-control" name="exptime_min">
                                    <option value="-1">---{LANG.min_select}---</option>
                                    <!-- BEGIN: exptime_min -->
                                    <option value="{MIN.index}"{MIN.selected}>{MIN.index}</option>
                                    <!-- END: exptime_min -->
                                </select>
                            </div>
                        </div>
                        <div class="input-group">
                            <input class="form-control datepicker" value="{DATA.exptime_f}" type="text" name="exptime" readonly="readonly" /> <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <em class="fa fa-calendar fa-fix">&nbsp;</em>
                                </button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.items_other}</div>
                    <div class="panel-body">
                        <label class="show"><input type="checkbox" name="inhome" value="1" {DATA.inhome} />&nbsp;{LANG.items_inhome}</label> <label class="show"><input type="checkbox" name="showprice" value="1" {DATA.showprice} />&nbsp;{LANG.items_showprice}</label>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.items_keywords}</div>
                    <div class="panel-body">
                        <textarea class="form-control" name="keywords">{KEYWORDS}</textarea>
                    </div>
                </div>
                <!-- BEGIN: status -->
                <div class="panel panel-default">
                    <div class="panel-heading">{LANG.items_status}</div>
                    <div class="panel-body">
                        <!-- BEGIN: loop -->
                        <p>
                            <label><input type="radio" name="status" value="{STATUS.key}" {STATUS.checked} />{STATUS.title}</label>
                        </p>
                        <!-- END: loop -->
                    </div>
                </div>
                <!-- END: status -->
            </div>
        </div>
        <div class="text-center">
            <hr />
            <!-- BEGIN: requeue -->
            <div class="alert alert-warning text-center">
                <p class="m-bottom">{LANG.requeue_note}</p>
                <label class="show"><input type="checkbox" name="requeue" value="1" />{LANG.requeue}</label>
            </div>
            <!-- END: requeue -->
            <input type="hidden" name="submit" value="1" /> <input type="submit" class="btn btn-primary" value="{LANG.items_submit}" />
        </div>
    </form>
    <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="{NV_BASE_SITEURL}themes/default/js/bookhouse_autoNumeric-1.9.41.js"></script>
    <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
    <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
    <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
    <script type="text/javascript">
		//<![CDATA[
		var file_items = '{FILE_ITEMS}';
		var file_selectfile = '{LANG.items_chose_image}';
		var nv_base_adminurl = '{NV_BASE_ADMINURL}';
		var file_dir = '{UPLOAD_DIR}';
		var items_del_otherimage = '{LANG.items_other_image_del}';
		var items_image_del = '{LANG.items_image_del}';
		
		var Options = {
			aSep : '{DES_POINT}',
			aDec : '{THOUSANDS_SEP}',
			vMin : '0',
			vMax : '999999999999999999999999'
		};

		$(document).ready(function() {
			$('.money').autoNumeric('init', Options);
			$('.money').bind('blur focusout keypress keyup', function() {
				$(this).autoNumeric('get', Options);
			});
						
			$('.sselect2').select2({
				language: '{NV_LANG_INTERFACE}',
				theme: 'bootstrap'
			});

			$(".datepicker").datepicker({
	            dateFormat : "dd/mm/yy",
	            changeMonth : !0,
	            changeYear : !0,
	            showOtherMonths : !0,
	            showOn : "focus",
	            yearRange : "-90:+5"
	        });

            $('.typeid').on('change', function() {
                nv_bookhouse_get_cat($(this), $('#catid').val());
            });

            if ($('.typeid').val() > 0) {
                nv_bookhouse_get_cat($('#typeid'), {DATA.catid});
            }

		});

		function nv_bookhouse_get_cat(_this, catid) {

	        var typeid = $(".typeid:checked").val();
	        $.ajax({
	            type : 'POST',
	            dataType : 'html',
	            url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
	            data : 'getcat=1&typeid=' + typeid + '&catid=' + catid,
	            success : function(data) {
	                $('#catid').html(data);
	            }
	        });
	        
	        $.ajax({
	            type : 'POST',
	            dataType : 'html',
	            url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
	            data : 'getpricetype=1&typeid=' + typeid,
	            success : function(data) {
	                $('#price_time').html(data);
	            }
	        });
	    }

	    function nv_bookhouse_cat_change(id, catid){
	        // hiển thị các trường tùy biến dữ liệu cho chủ đề
	        $.ajax({
	            type : 'POST',
	            data: 'get_custom_field=1&id=' + id + '&catid=' + catid,
	            url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
	            success : function(html) {
	                $('#custom_form').html(html);
	            }
	        });
	    }

		function nv_location_change(type, value){
			$.ajax({
				type : 'POST',
				dataType: 'html',
				url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
				data : 'getprojects=1&type=' + type + '&value=' + value,
				success : function(data) {
					$('#projectid').html(data);
				}
			});
		}
		
		function nv_add_element(idElment, key, value) {
			var html = "<span title=\"" + value + "\" class=\"uiToken removable\">" + value + "<input type=\"hidden\" value=\"" + key + "\" name=\"" + idElment + "[]\" autocomplete=\"off\"><a onclick=\"$(this).parent().remove();\" href=\"javascript:void(0);\" class=\"remove uiCloseButton uiCloseButtonSmall\"></a></span>";
			$("#" + idElment).append(html);
			return false;
		}

		$(".selectimg").click(function() {
			var area = "homeimg";
			var alt = "homeimgalt";
			var path = "{UPLOAD_DIR}";
			var type = "image";
			nv_open_browse(script_name + "?" + nv_name_variable + "=upload&popup=1&area=" + area + "&alt=" + alt + "&path=" + path + "&type=" + type, "NVImg", 850, 420, "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
			return false;
		});

		$('[type="submit"]').hover(function() {
			if ($('[name="keywords[]"]').length == 0) {
				if ($('#message-tags').length == 0) {
					$('#message').html('<div id="message-tags" class="alert alert-danger">{LANG.content_tags_empty}.<!-- BEGIN: auto_tags --> {LANG.content_tags_empty_auto}.<!-- END: auto_tags --></div>');
				}
			} else {
				$('#message-tags').remove();
			}
		});
		//]]>
	</script>
    <link type="text/css" href="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css" rel="stylesheet" />
    <script type="text/javascript" src="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
    <script type="text/javascript" src="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/i18n/{NV_LANG_INTERFACE}.js"></script>
    <script type="text/javascript">
    	var initUploader = function () {
	        $("#uploader").pluploadQueue({
	            runtimes: 'html5,flash,silverlight,html4',
	            url: '{UPLOAD_URL}',
	            resize: {
	                width: '{MAXIMAGESIZEULOAD.0}',
	                height: '{MAXIMAGESIZEULOAD.1}'
	            },
	            chunk_size: '{MAXFILESIZEULOAD}',
	            max_retries: 3,
	            rename: false,
	            dragdrop: true,
	            filters: {
	                max_file_size: '{MAXFILESIZEULOAD}',
	                mime_types: [{
	                    title: "Image files",
	                    extensions: "jpg,gif,png,jpeg"
	                }, ]
	            },
	            flash_swf_url: '{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/Moxie.swf',
	            silverlight_xap_url: '{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/Moxie.xap',
	            multi_selection: true,
	            prevent_duplicates: true,
	            multiple_queues: false,
	            init: {
	    			FilesAdded: function (up, files) {
	    				this.start();
	    				return false;
	    			},
	                UploadComplete: function (up, files) {
	                    $(".plupload_buttons").css("display", "inline");
	                    $(".plupload_upload_status").css("display", "inline");
	                }
	            }
	        });
	        
	        var uploader = $("#uploader").pluploadQueue();
	        uploader.bind('BeforeUpload', function(up) {
	             up.settings.multipart_params = {
	                    'folder': ''
	             };
	        });
			
	        var j = '{COUNT_UPLOAD}';
	        var i = '{COUNT}';
	        uploader.bind('FileUploaded', function(up, file, response) {
	        	if($.parseJSON(response.response).error.length == 0){
			        var content = $.parseJSON(response.response).data;
			        var item='';
		            item+='<div class="col-xs-4 col-sm-3 col-md-3 other-image-item new-images-append" id="other-image-div-' + i + '">';
		            item+='                 <input type="hidden" name="otherimage['+ i +'][id]" value="0">';
		            item+='                 <input type="hidden" name="otherimage['+ i +'][basename]" value="'+ content['basename'] +'">';
		            item+='                 <input type="hidden" name="otherimage['+ i +'][homeimgfile]" value="'+ content['homeimgfile'] +'">';
		            item+='                 <input type="hidden" name="otherimage['+ i +'][thumb]" value="'+ content['thumb'] +'">';
		            item+='                 <input type="hidden" name="otherimage['+ i +'][name]" value="' + content['basename'] + '" >';
		            item+='                 <input type="hidden" name="otherimage['+ i +'][description]" value="' + content['description'] + '" >';
		            item+='                 <a href="#" onclick="modalShow(\'' + content['basename'] + '\', \'<img src=' + content['image_url'] + ' class=img-responsive />\' ); return false;" >';
		            item+='                     <img class="img-thumbnail m-bottom" src="'+ content['thumb'] +'">';
		            item+='                 </a>';
		            item+='                 <em class="fa fa-times-circle fa-lg fa-pointer" onclick="nv_delete_other_images_tmp(\'' + content['image_url'] + '\', \'' + content['thumb'] + '\', ' + i + '); return false;">&nbsp;</em>';
		            item+='</div>';
		            item+='</div>';
		
		            $('#image-other').append(item);
		            ++i;	
	        	}else{
	        		alert($.parseJSON(response.response).error.message);
	        	}
	        });
	
	        uploader.bind("UploadComplete", function (up, files) {
                initUploader();
	        });
	
	        uploader.bind('QueueChanged', function() {
	
	        });
	
	        uploader.bind('FilesAdded', function(up, files) {
	            if( files.length > j )
	            {
	                alert( strip_tags( '{LANG.error_required_otherimage}' ) );
	                $.each(files, function(i, file) {
	                    up.removeFile(file);
	                });
	            }
	        });
    	};
	    
	    $(document).ready(function(){
	    	initUploader();
    	});
	    
	    $('.images-add').click(function(){
	        $('#uploader').show();
	        $('.images-add').hide();
	    });
	</script>
    <!-- BEGIN: change_alias -->
    <script type="text/javascript">
		$("#idtitle").change(function() {
			get_alias();
		});
	</script>
    <!-- END: change_alias -->
</div>
<!-- END: main -->
