<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css" />
<div class="well">
    <form name="search_form" action="{NV_BASE_ADMINURL}index.php" method="GET">
        <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />
        <div class="col-xs-12 col-md-4">
            <div class="form-group">
                <input type="text" class="form-control" name="keyword" value="{KEYWORD}" placeholder="{LANG.search_key}" />
            </div>
        </div>
        <div class="col-xs-12 col-md-4">
            <div class="form-group">
                <select name="catid" class="form-control select2">
                    <option value="0">---{LANG.cat_chose}---</option>
                    <!-- BEGIN: category -->
                    <option value="{CAT.key}"{CAT.selected}>{CAT.title}</option>
                    <!-- END: category -->
                </select>
            </div>
        </div>
        <div class="col-xs-12 col-md-4">
            <div class="form-group">
                <select name="status" class="form-control">
                    <option value="-1">---{LANG.status_select}---</option>
                    <!-- BEGIN: status -->
                    <option value="{STATUS.index}"{STATUS.selected}>{STATUS.value}</option>
                    <!-- END: status -->
                </select>
            </div>
        </div>
        <!-- BEGIN: transaction -->
        <div class="col-xs-12 col-md-4">
            <div class="form-group">
                <select name="status" class="form-control">
                    <option value="">---{LANG.items_status_all}---</option>
                    <!-- BEGIN: status -->
                    <option value="{STATUS.key}"{STATUS.selected}>{STATUS.title}</option>
                    <!-- END: status -->
                </select>
            </div>
        </div>
        <!-- END: transaction -->
        <input type="submit" class="btn btn-primary" value="{LANG.search}" name="search" />
    </form>
</div>
<form name="items_form">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover table-middle">
            <col class="w50" />
            <col />
            <col class="w200" />
            <col class="w100" />
            <col class="w250" />
            <col class="w100" />
            <col width="120" />
            <thead>
                <tr>
                    <th class="text-center"><input name="check_all[]" type="checkbox" value="yes" onclick="nv_checkAll(this.form, 'idcheck[]', 'check_all[]',this.checked);" /></th>
                    <th>{LANG.title}</th>
                    <th>{LANG.cat}</th>
                    <th>{LANG.items_price} ({DATA.money_unit})</th>
                    <th>{LANG.items_location}</th>
                    <th class="text-center">{LANG.active}</th>
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <tbody>
                <!-- BEGIN: loop -->
                <tr>
                    <td class="text-center"><input type="checkbox" onclick="nv_UncheckAll(this.form, 'idcheck[]', 'check_all[]', this.checked);" value="{DATA.id}" name="idcheck[]" class="post"></td>
                    <td><a href="{DATA.view_url}" target="_blank" title="{DATA.title}" class="show"><strong>{DATA.title}</strong></a>
                        <ul class="list-inline help-block">
                            <li><strong>{LANG.addtime}:</strong> {DATA.addtime}</li>
                            <li><strong>{LANG.useradd}:</strong> {DATA.useradd}</li>
                        </ul></td>
                    <td><a href="{DATA.catlink}" title="{DATA.cattitle}">{DATA.cattitle}</a></td>
                    <td>{DATA.price}</td>
                    <td>{DATA.location}</td>
                    <td class="text-center"><input type="checkbox" name="status" id="change_status_{DATA.id}" value="{DATA.id}" {CHECK} onclick="nv_change_status({DATA.id});" /></td>
                    <td class="text-center"><a class="btn btn-default btn-xs" href="{DATA.images_link}" title="{LANG.images}"><em class="fa fa-image">&nbsp;{DATA.images_count}</em></a> <!-- BEGIN: url_edit --> <a class="btn btn-default btn-xs" href="{DATA.edit_url}" title="{GLANG.edit}"><em class="fa fa-edit"></em></a> <!-- END: url_edit --> <!-- BEGIN: label_edit -->
                        <button class="btn btn-default btn-xs disabled" title="{GLANG.edit}">
                            <em class="fa fa-edit"></em>
                        </button> <!-- END: label_edit --> <!-- BEGIN: url_del --> <a class="btn btn-default btn-xs" href="javascript:void(0)" onclick="nv_del_items({DATA.id})" title="{GLANG.delete}"><em class="fa fa-trash-o"></em></a> <!-- END: url_del --> <!-- BEGIN: label_del -->
                        <button class="btn btn-default btn-xs disabled" title="{GLANG.delete}">
                            <em class="fa fa-trash-o"></em>
                        </button> <!-- END: label_del --></td>
                </tr>
                <!-- END: loop -->
            </tbody>
        </table>
    </div>
</form>
<form class="form-inline m-bottom pull-left">
    <select class="form-control" id="action">
        <!-- BEGIN: action -->
        <option value="{ACTION.key}">{ACTION.value}</option>
        <!-- END: action -->
    </select>
    <button class="btn btn-primary" onclick="nv_list_action( $('#action').val(), '{BASE_URL}', '{LANG.error_empty_data}' ); return false;">{LANG.perform}</button>
</form>
<!-- BEGIN: generate_page -->
<div class="pull-right">{GENERATE_PAGE}</div>
<!-- END: generate_page -->
<div class="clearfix"></div>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript">
	var no_chose = '{LANG.items_error_chosen}';
	var items_queue_confirm = '{LANG.items_queue_confirm}';
    var error_unknow = '{LANG.error_unknow}';
    
	$('.select2').select2({
		language: '{NV_LANG_INTERFACE}',
		theme: 'bootstrap'
	});
	
	$('#del_chose').click(function() {
		var fa = this.form['idcheck[]'];
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

		if( listid != '' ){
			if (confirm(nv_is_del_confirm[0])) {
				$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=items&del&nocache=' + new Date().getTime(), 'listid=' + listid, function(res) {
					if (res == 'OK') {
						window.location.href = window.location.href;
					}
					else{
						alert( nv_is_del_confirm[2] );
					}
				});
			}
		}
		else{
			alert( no_chose );
		}
	});

    function nv_change_status(id) {
        var new_status = $('#change_status_' + id).is(':checked') ? true : false;
        if (confirm(nv_is_change_act_confirm[0])) {
            var nv_timer = nv_settimeout_disable('change_status_' + id, 5000);
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '={OP}&nocache=' + new Date().getTime(), 'change_status=1&id=' + id, function(res) {
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