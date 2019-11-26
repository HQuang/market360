<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css" />
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css" />
<div class="viewlist m-bottom">
    <div class="well">
        <form name="search_form" action="{NV_BASE_ADMINURL}index.php" method="GET">
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />
            <div class="col-xs-12 col-md-6">
                <div class="form-group">
                    <input type="text" class="form-control" name="keyword" value="{KEYWORD}" placeholder="{LANG.search_key}" />
                </div>
            </div>
            <div class="col-xs-12 col-md-8">
                <div class="form-group">
                    <select name="catid" class="form-control select2">
                        <option value="0">---{LANG.cat_chose}---</option>
                        <!-- BEGIN: cat -->
                        <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                        <!-- END: cat -->
                    </select>
                </div>
            </div>
            <input type="submit" class="btn btn-primary" value="{LANG.search}" name="search" /> <a href="{ADD_URL}" class="btn btn-success">{LANG.items_add}</a>
        </form>
    </div>
    <blockquote>
        <ul class="items_note">
            <li>{LANG.items_note1}</li>
            <li>{LANG.items_note2}</li>
            <li>{LANG.items_note3}</li>
        </ul>
    </blockquote>
    <form name="items_form">
        <!-- BEGIN: loop -->
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="image pull-left">
                    <a href="{DATA.view_url}" title="{DATA.title}"><img src="{DATA.imghome}" width="{THUMB_WIDTH}" class="img-thumbnail" /></a>
                </div>
                <ul class="list-info">
                    <li><h2>
                            <a href="{DATA.view_url}" title="{DATA.title}" style="color: {DATA.color">{DATA.title}</a>
                        </h2></li>
                    <li><strong>{LANG.code}:</strong> <span class="price_bookhouse">{DATA.code}</span> - <strong>{LANG.viewcount}:</strong> {DATA.hitstotal} - <strong>{LANG.refresh}:</strong> {DATA.ordertime} - <strong>{LANG.status}:</strong> <a class="{COLOR}">{DATA.status_s}</a></li>
                    <li><strong>{LANG.type}:</strong> {DATA.cat}</li>
                    <li><em class="fa fa-image">&nbsp;</em><a href="{DATA.images_link}">{LANG.images}</a><span class="text-danger"> ({DATA.images_count})</span>&nbsp;&nbsp;&nbsp; <!-- BEGIN: group_buy1 --> <em class="fa fa-edit">&nbsp;</em><a href="{DATA.url_upgrade}" title="{LANG.payment_group}">{LANG.payment_group}</a>&nbsp;&nbsp;&nbsp; <!-- END: group_buy1 --> <!-- BEGIN: refresh_allow --> <em class="fa fa-refresh">&nbsp;</em> <!-- BEGIN: refresh --> <a href="javascript:void(0)" onclick="nv_refresh({DATA.id}, '{DATA.checkss}'); return !1;">{LANG.refresh}</a>&nbsp;&nbsp;&nbsp; <!-- END: refresh --> <!-- BEGIN: refresh_label --> {LANG.refresh}&nbsp;&nbsp;&nbsp; <!-- END: refresh_label --> <!-- END: refresh_allow --> <em class="fa fa-edit">&nbsp;</em><a href="{DATA.edit_url}" title="{GLANG.edit}">{GLANG.edit}</a>&nbsp;&nbsp;&nbsp; <em class="fa fa-trash-o">&nbsp;</em><a href="javascript:void(0)" onclick="nv_del_items({DATA.id})">{GLANG.delete}</a></li>
                    <!-- BEGIN: group_buy -->
                    <li><strong>{LANG.group_add}:</strong> <!-- BEGIN: loop --> <a href="javasctipt:void(0);" onclick="nv_upgrade_group('group', {GROUP.bid}, {DATA.id}, ''); return !1;" style="color: {GROUP.color" title="{LANG.buy} {GROUP.title}">{LANG.buy} {GROUP.title}</a>&nbsp;&nbsp;&nbsp; <!-- END: loop --></li>
                    <!-- END: group_buy -->
                </ul>
            </div>
        </div>
        <!-- END: loop -->
    </form>
    <!-- BEGIN: generate_page -->
    <div class="text-center">{GENERATE_PAGE}</div>
    <!-- END: generate_page -->
</div>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript">
    var LANG = {};
    LANG['refresh_confirm'] = '{LANG.refresh_confirm}';

    $('.select2').select2({
        language: '{NV_LANG_INTERFACE}',
        theme: 'bootstrap'
    });

    function nv_change_status(id) {
        var new_status = $('#change_status_' + id).is(':checked') ? true : false;
        if (confirm(nv_is_change_act_confirm[0])) {
            var nv_timer = nv_settimeout_disable('change_status_' + id, 5000);
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '={OP}&nocache=' + new Date().getTime(), 'change_status=1&id=' + id, function (res) {
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
</script>
<!-- END: main -->