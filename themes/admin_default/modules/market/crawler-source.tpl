<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css">
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
<form class="form-inline m-bottom">
    <select class="form-control" id="action_top">
        <!-- BEGIN: action_top -->
        <option value="{ACTION.key}">{ACTION.value}</option>
        <!-- END: action_top -->
    </select>
    <button class="btn btn-primary" onclick="nv_list_items_action( $('#action_top').val(), '{BASE_URL}', '{LANG.action_del_confirm_no_post}' ); return false;">{LANG.perform}</button>
    <a href="{URLADD}" class="btn btn-success">{LANG.items_add}</a>
</form>
<form action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}" method="post">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <colgroup>
                <col class="w50" />
                <col />
                <col class="w250" />
                <col width="120" />
                <col class="w150" />
                <col class="w100" />
                <col class="w200" />
            </colgroup>
            <thead>
                <tr>
                    <th class="text-center"><input name="check_all[]" type="checkbox" value="yes" onclick="nv_checkAll(this.form, 'idcheck[]', 'check_all[]',this.checked);" /></th>
                    <th>{LANG.title}</th>
                    <th>{LANG.groups}</th>
                    <th>{LANG.items_cronjobs}</th>
                    <th>{LANG.lasttime}</th>
                    <th class="text-center">{LANG.active}</th>
                    <th>&nbsp;</th>
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
                    <td><a href="{VIEW.url}" target="_blank" title="{VIEW.title}">{VIEW.title}</a></td>
                    <td>{VIEW.groups}</td>
                    <td><select class="form-control" id="id_timer_{VIEW.id}" onchange="nv_items_change_timer({VIEW.id});">
                            <!-- BEGIN: timer -->
                            <option value="{TIMER.key}"{TIMER.selected}>{TIMER.value}</option>
                            <!-- END: timer -->
                    </select></td>
                    <td class="text-center">{VIEW.lasttime}</td>
                    <td class="text-center"><input type="checkbox" name="status" id="change_status_{VIEW.id}" value="{VIEW.id}" {CHECK} onclick="nv_change_status({VIEW.id});" /></td>
                    <td class="text-center">
                        <!-- BEGIN: getnews --> <em class="fa fa-refresh fa-lg">&nbsp;</em><a href="#" class="fetch" data-id="{VIEW.id}">{LANG.action_fetch}</a> &nbsp; <!-- END: getnews --> <i class="fa fa-edit fa-lg">&nbsp;</i> <a href="{VIEW.link_edit}#edit">{LANG.edit}</a> &nbsp; <em class="fa fa-trash-o fa-lg">&nbsp;</em> <a href="{VIEW.link_delete}" onclick="return confirm(nv_is_del_confirm[0]);">{LANG.delete}</a>
                    </td>
                </tr>
                <!-- END: loop -->
            </tbody>
        </table>
    </div>
</form>
<form class="form-inline m-bottom">
    <select class="form-control" id="action_bottom">
        <!-- BEGIN: action_bottom -->
        <option value="{ACTION.key}">{ACTION.value}</option>
        <!-- END: action_bottom -->
    </select>
    <button class="btn btn-primary" onclick="nv_list_items_action( $('#action_bottom').val(), '{BASE_URL}', '{LANG.action_del_confirm_no_post}' ); return false;">{LANG.perform}</button>
</form>
<div id="ajax_loader" class="ajax-load-qa"> </div>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<script>
	var LANG = [];
	LANG.action_fetch_confirm = '{LANG.action_fetch_confirm}';
	LANG.action_fetch_error = '{LANG.action_fetch_error}';
	LANG.action_fetch_success_empty = '{LANG.action_fetch_success_empty}';
	LANG.action_fetch_success_ok = '{LANG.action_fetch_success_ok}';

	function nv_change_status(id) {
		var new_status = $('#change_status_' + id).is(':checked') ? true : false;
		if (confirm(nv_is_change_act_confirm[0])) {
			var nv_timer = nv_settimeout_disable('change_status_' + id, 5000);
			$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=crawler-source&nocache=' + new Date().getTime(), 'change_status=1&id='+id, function(res) {
				var r_split = res.split('_');
				if (r_split[0] != 'OK') {
					alert(nv_is_change_act_confirm[2]);
				}
			});
		}
		else{
			$('#change_status_' + id).prop('checked', new_status ? false : true );
		}
		return;
	}
</script>
<!-- END: main -->