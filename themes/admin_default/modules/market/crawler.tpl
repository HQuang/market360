<!-- BEGIN: main -->
<div class="well">
    <form action="{NV_BASE_ADMINURL}index.php" method="get">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" /> <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />
        <div class="row">
            <div class="col-xs-24 col-md-6">
                <div class="form-group">
                    <input class="form-control" type="text" value="{SEARCH.q}" name="q" maxlength="255" placeholder="{LANG.search_title}" />
                </div>
            </div>
            <div class="col-xs-24 col-md-6">
                <div class="form-group">
                    <select name="groups_id" class="form-control">
                        <option value="0">---{LANG.crawler_groups_select}---</option>
                        <!-- BEGIN: groups -->
                        <option value="{GROUPS.id}"{GROUPS.selected}>{GROUPS.title}</option>
                        <!-- END: groups -->
                    </select>
                </div>
            </div>
            <div class="col-xs-24 col-md-4">
                <div class="form-group">
                    <select name="status" class="form-control">
                        <option value="-1">---{LANG.status_select}---</option>
                        <!-- BEGIN: status -->
                        <option value="{STATUS.key}"{STATUS.selected}>{STATUS.value}</option>
                        <!-- END: status -->
                    </select>
                </div>
            </div>
            <div class="col-xs-24 col-md-3">
                <div class="form-group">
                    <select name="per_page" class="form-control">
                        <option value="15">---{LANG.display}---</option>
                        <!-- BEGIN: per_page -->
                        <option value="{PER_PAGE.key}"{PER_PAGE.selected}>{PER_PAGE.key}</option>
                        <!-- END: per_page -->
                    </select>
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
    <select class="form-control" id="action-top">
        <!-- BEGIN: action_top -->
        <option value="{ACTION.key}">{ACTION.value}</option>
        <!-- END: action_top -->
    </select>
    <button class="btn btn-primary" onclick="nv_list_action( $('#action-top').val(), '{BASE_URL}', '{LANG.action_del_confirm_no_post}' ); return false;">{LANG.perform}</button>
</form>
<form action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}" method="post">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <colgroup>
                <col class="w50" />
                <col />
                <col class="w200" />
                <col class="w150" />
                <col class="w100" />
                <col width="80" />
            </colgroup>
            <thead>
                <tr>
                    <th class="w50 text-center"><input name="check_all[]" type="checkbox" value="yes" onclick="nv_checkAll(this.form, 'idcheck[]', 'check_all[]',this.checked);" /></th>
                    <th>{LANG.container_list}</th>
                    <th>{LANG.crawler_groups}</th>
                    <th>{LANG.addtime}</th>
                    <th>{LANG.status}</th>
                    <th>&nbsp;</th>
                </tr>
            </thead>
            <!-- BEGIN: generate_page -->
            <tfoot>
                <tr>
                    <td class="text-center" colspan="6">{NV_GENERATE_PAGE}</td>
                </tr>
            </tfoot>
            <!-- END: generate_page -->
            <tbody>
                <!-- BEGIN: loop -->
                <tr class="<!-- BEGIN: warning -->warning<!-- END: warning --> <!-- BEGIN: success -->success<!-- END: success -->" id="rows_{VIEW.id}">
                    <td class="text-center"><input type="checkbox" class="post" onclick="nv_UncheckAll(this.form, 'idcheck[]', 'check_all[]', this.checked);" value="{VIEW.id}" name="idcheck[]" /></td>
                    <td><a href="{VIEW.url}" target="_blank" data-toggle="tooltip" data-placement="top" title="" data-original-title="{VIEW.hometext}">{VIEW.title}</a> <span class="pull-right" id="newslink_{VIEW.id}"> <!-- BEGIN: newslink --> <a href="{VIEW.newslink}" target="_blank" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.newsview}"><em class="fa fa-external-link fa-pointer">&nbsp;</em></a> <!-- END: newslink -->
                    </span></td>
                    <td><a href="{VIEW.groups_url}" target="_blank" title="{VIEW.groups_title}">{VIEW.groups_title}</a></td>
                    <td>{VIEW.addtime}</td>
                    <td id="status_{VIEW.id}">{VIEW.status_str}</td>
                    <td class="text-center" id="action_{VIEW.id}">
                        <!-- BEGIN: repost --> <a href="#" data-id="{VIEW.id}" class="action" data-action="acept" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_repost}"><em class="fa fa-circle-o-notch fa-lg fa-point">&nbsp;</em></a> <!-- END: repost --> <!-- BEGIN: acept --> <a href="#" data-id="{VIEW.id}" class="action" data-action="acept" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_acept}"><em class="fa fa-save fa-lg fa-point">&nbsp;</em></a> <!-- END: acept --> <!-- BEGIN: break --> <a href="#" data-id="{VIEW.id}" class="action" data-action="break" data-toggle="tooltip" data-placement="top" title="" data-original-title="{LANG.action_break}"><em class="fa fa-times fa-lg fa-point">&nbsp;</em></a> <!-- END: break -->
                    </td>
                </tr>
                <!-- END: loop -->
            </tbody>
        </table>
    </div>
</form>
<form class="form-inline m-bottom">
    <select class="form-control" id="action-bottom">
        <!-- BEGIN: action_bottom -->
        <option value="{ACTION.key}">{ACTION.value}</option>
        <!-- END: action_bottom -->
    </select>
    <button class="btn btn-primary" onclick="nv_list_action( $('#action-bottom').val(), '{BASE_URL}', '{LANG.action_del_confirm_no_post}' ); return false;">{LANG.perform}</button>
</form>
<div id="ajax_loader" class="ajax-load-qa"> </div>
<script>
    var LANG = [];
    LANG.status_1 = '{LANG.status_1}';
    LANG.status_2 = '{LANG.status_2}';
</script>
<!-- END: main -->