<!-- BEGIN: main -->
<!-- BEGIN: view -->
<div class="well">
    <form action="{NV_BASE_ADMINURL}index.php" method="get">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" /> <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />
        <div class="row">
            <div class="col-xs-24 col-md-6">
                <div class="form-group">
                    <input class="form-control" type="text" value="{Q}" name="q" maxlength="255" placeholder="{LANG.search_title}" />
                </div>
            </div>
            <div class="col-xs-12 col-md-3">
                <div class="form-group">
                    <input class="btn btn-primary" type="submit" value="{LANG.search_submit}" />
                </div>
            </div>
        </div>
    </form>
</div>
<form action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}" method="post">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th class="w50 text-center"><input name="check_all[]" type="checkbox" value="yes" onclick="nv_checkAll(this.form, 'idcheck[]', 'check_all[]',this.checked);" /></th>
                    <th class="w100">{LANG.weight}</th>
                    <th>{LANG.title}</th>
                    <th>{LANG.url}</th>
                    <th>{LANG.type}</th>
                    <th class="w150">{LANG.updatetime}</th>
                    <th class="w100 text-center">{LANG.active}</th>
                    <th class="w150">&nbsp;</th>
                </tr>
            </thead>
            <!-- BEGIN: generate_page -->
            <tfoot>
                <tr>
                    <td class="text-center" colspan="7">{NV_GENERATE_PAGE}</td>
                </tr>
            </tfoot>
            <!-- END: generate_page -->
            <tbody>
                <!-- BEGIN: loop -->
                <tr>
                    <td class="text-center"><input type="checkbox" class="post" onclick="nv_UncheckAll(this.form, 'idcheck[]', 'check_all[]', this.checked);" value="{VIEW.id}" name="idcheck[]" /></td>
                    <td><select class="form-control" id="id_weight_{VIEW.id}" onchange="nv_change_weight('{VIEW.id}');">
                            <!-- BEGIN: weight_loop -->
                            <option value="{WEIGHT.key}"{WEIGHT.selected}>{WEIGHT.title}</option>
                            <!-- END: weight_loop -->
                    </select></td>
                    <td>{VIEW.title}</td>
                    <td><a target="_blank" href="{VIEW.url}" title="{VIEW.title}">{VIEW.url}</a></td>
                    <td>{VIEW.type}</td>
                    <td>{VIEW.updatetime}</td>
                    <td class="text-center"><input type="checkbox" name="status" id="change_status_{VIEW.id}" value="{VIEW.id}" {CHECK} onclick="nv_change_status({VIEW.id});" /></td>
                    <td class="text-center"><i class="fa fa-edit fa-lg">&nbsp;</i><a href="{VIEW.link_edit}#edit">{LANG.edit}</a> - <em class="fa fa-trash-o fa-lg">&nbsp;</em><a href="{VIEW.link_delete}" onclick="return confirm(nv_is_del_confirm[0]);">{LANG.delete}</a></td>
                </tr>
                <!-- END: loop -->
            </tbody>
        </table>
    </div>
</form>
<form class="form-inline m-bottom">
    <select class="form-control" id="action">
        <!-- BEGIN: action -->
        <option value="{ACTION.key}">{ACTION.value}</option>
        <!-- END: action -->
    </select>
    <button class="btn btn-primary" onclick="nv_list_groups_action( $('#action').val(), '{BASE_URL}', '{LANG.action_del_confirm_no_post}' ); return false;">{LANG.perform}</button>
</form>
<!-- END: view -->
<!-- BEGIN: error -->
<div class="alert alert-warning">{ERROR}</div>
<!-- END: error -->
<form class="form-horizontal" action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}" method="post" id="form">
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.info}</div>
        <div class="panel-body">
            <input type="hidden" name="id" value="{ROW.id}" />
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.title}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="title" value="{ROW.title}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.url}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="url" name="url" value="{ROW.url}" oninvalid="setCustomValidity( nv_url )" oninput="setCustomValidity('')" required="required" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.logo}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <div class="input-group">
                        <input class="form-control" type="text" name="logo" value="{ROW.logo}" id="id_logo" /> <span class="input-group-btn">
                            <button class="btn btn-default selectfile" type="button">
                                <em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.container_list}</div>
        <div class="panel-body">
            <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.crawler_type}</strong> <span class="red">(*)</span></label>
            <div class="col-sm-19 col-md-19">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <!-- BEGIN: type -->
                        <label><input type="radio" name="type" value="{TYPE.index}" {TYPE.checked} />{TYPE.value}</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <!-- END: type -->
                    </div>
                </div>
            </div>
            <div id="dom_html"
                <!-- BEGIN: dom_hidden -->
                class="hidden"
                <!-- END: dom_hidden -->
                >
                <div class="form-group">
                    <label class="col-sm-5 col-md-5 control-label">&nbsp;</label>
                    <div class="col-sm-19 col-md-19">
                        <span class="help-block">{LANG.detail_element_note}</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_list_outside}</strong> <span class="red">(*)</span></label>
                    <div class="col-sm-19 col-md-19">
                        <input class="form-control req" type="text" name="container_list_outside" value="{ROW.container_list_outside}" {ROW.dom_required} oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_title}</strong> <span class="red">(*)</span></label>
                    <div class="col-sm-19 col-md-19">
                        <input class="form-control req" type="text" name="container_list_title" value="{ROW.container_list_title}" {ROW.dom_required} oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_url}</strong> <span class="red">(*)</span></label>
                    <div class="col-sm-19 col-md-19">
                        <input class="form-control req" type="text" name="container_list_url" value="{ROW.container_list_url}" {ROW.dom_required} oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_hometext}</strong></label>
                    <div class="col-sm-19 col-md-19">
                        <input class="form-control" type="text" name="container_list_hometext" value="{ROW.container_list_hometext}" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_homeimage}</strong></label>
                    <div class="col-sm-19 col-md-19">
                        <input class="form-control" type="text" name="container_list_homeimage" value="{ROW.container_list_homeimage}" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.container_detail}</div>
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_title}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="container_title" value="{ROW.container_title}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_homeimage}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="container_homeimage" value="{ROW.container_homeimage}" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_hometext}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="container_hometext" value="{ROW.container_hometext}" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_bodytext}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="container_bodytext" value="{ROW.container_bodytext}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_price}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="container_price" value="{ROW.container_price}"  />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.maps}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <input class="form-control" type="text" name="container_maplat" value="{ROW.container_maplat}" placeholder="Lat" />
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <input class="form-control" type="text" name="container_maplng" value="{ROW.container_maplng}" placeholder="Lng" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 text-right"><strong>{LANG.contact_info}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <div class="row m-bottom">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <label>{LANG.contact_fullname}</label> 
                            <input class="form-control" type="text" name="container_contact_fullname" value="{ROW.container_contact_fullname}" />
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <label>{LANG.contact_email}</label>
                            <input class="form-control" type="text" name="container_contact_email" value="{ROW.container_contact_email}" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <label>{LANG.contact_phone}</label> 
                            <input class="form-control" type="text" name="container_contact_phone" value="{ROW.container_contact_phone}" />
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <label>{LANG.contact_address}</label>
                            <input class="form-control" type="text" name="container_contact_address" value="{ROW.container_contact_address}" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.container_remove}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <input class="form-control" type="text" name="container_remove" value="{ROW.container_remove}" />
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.other_opition}</div>
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.remove_string}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <textarea class="form-control" rows="5" name="other_remove_string">{ROW.other_remove_string}</textarea>
                    <em class="help-block">{LANG.remove_string_note}</em>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-5 control-label"><strong>{LANG.note}</strong></label>
                <div class="col-sm-19 col-md-19">
                    <textarea class="form-control" rows="5" name="note">{ROW.note}</textarea>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group" style="text-align: center">
        <input class="btn btn-primary" name="submit" type="submit" value="{LANG.save}" />
    </div>
</form>
<script type="text/javascript">
	//<![CDATA[
	$(".selectfile").click(function() {
		var area = "id_logo";
		var path = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
		var currentpath = "{NV_UPLOADS_DIR}/{MODULE_UPLOAD}";
		var type = "image";
		nv_open_browse(script_name + "?" + nv_name_variable + "=upload&popup=1&area=" + area + "&path=" + path + "&type=" + type + "&currentpath=" + currentpath, "NVImg", 850, 420, "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
		return false;
	});
	
	$('input[name="type"]').change(function(){
		if($(this).val() == 0){
			$('#dom_html').addClass('hidden');
			$('#dom_html').find('input.req').prop('required', false);
		}else{
			$('#dom_html').removeClass('hidden');
			$('#dom_html').find('input.req').prop('required', true);
		}
	});
	
	function nv_change_weight(id) {
		var nv_timer = nv_settimeout_disable('id_weight_' + id, 5000);
		var new_vid = $('#id_weight_' + id).val();
		$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler-groups&nocache=' + new Date().getTime(), 'ajax_action=1&id=' + id + '&new_vid=' + new_vid, function(res) {
			var r_split = res.split('_');
			if (r_split[0] != 'OK') {
				alert(nv_is_change_act_confirm[2]);
			}
			window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler-groups';
			return;
		});
		return;
	}

	function nv_change_status(id) {
		var new_status = $('#change_status_' + id).is(':checked') ? true : false;
		if (confirm(nv_is_change_act_confirm[0])) {
			var nv_timer = nv_settimeout_disable('change_status_' + id, 5000);
			$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler-groups&nocache=' + new Date().getTime(), 'change_status=1&id=' + id, function(res) {
				var r_split = res.split('_');
				if (r_split[0] != 'OK') {
					alert(nv_is_change_act_confirm[2]);
				}
			});
		} else {
			$('#change_status_' + id).prop('checked', new_status ? false : true);
		}
		return;
	}

	//]]>
</script>
<!-- END: main -->