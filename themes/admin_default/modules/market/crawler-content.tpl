<!-- BEGIN: main -->
<!-- BEGIN: error -->
<div class="alert alert-warning">{ERROR}</div>
<!-- END: error -->
<form class="form-horizontal" action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}={OP}" method="post">
    <input type="hidden" name="id" value="{ROW.id}" /> <input type="hidden" name="typeid" value="{ROW.typeid}" />
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.crawler_source_info}</div>
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.title}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-20">
                    <input class="form-control" type="text" name="title" value="{ROW.title}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.groups}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-20">
                    <select class="form-control" name="groups_id">
                        <!-- BEGIN: groups -->
                        <option value="{GROUPS.id}"{GROUPS.selected}>{GROUPS.title}</option>
                        <!-- END: groups -->
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 control-label"><strong id="item_url">{LANG.url}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-20">
                    <input class="form-control" type="url" name="url" value="{ROW.url}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.type}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-20">
                    <!-- BEGIN: type -->
                    <label><input type="radio" name="typeid" value="{TYPE.id}" {TYPE.checked} />{TYPE.title}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <!-- END: type -->
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
                <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.location}</strong></label>
                <div class="col-sm-19 col-md-20">{LOCATION}</div>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.option}</div>
        <div class="panel-body">
            <div class="form-group">
                <label class="col-sm-5 col-md-4 control-label"><strong>{LANG.save_limit}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <input class="form-control" type="number" name="save_limit" value="{ROW.save_limit}" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.queue}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <label><input type="checkbox" name="queue" value="1" {ROW.ck_queue} />{LANG.queue_note}</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.save_image}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <label><input type="checkbox" name="save_image" value="1" {ROW.ck_save_image} />{LANG.save_image_note}</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.auto_getkeyword}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <label><input type="checkbox" name="auto_getkeyword" value="1" {ROW.ck_auto_getkeyword} />{LANG.auto_getkeyword_note}</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.auto_keyword}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <label><input type="checkbox" name="auto_keyword" value="1" {ROW.ck_auto_keyword} />{LANG.auto_keyword_note}</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.auto_homeimage}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <label><input type="checkbox" name="auto_homeimage" value="1" {ROW.ck_auto_homeimage} />{LANG.auto_homeimage_note}</label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-4 text-right"><strong>{LANG.remove_link}</strong></label>
                <div class="col-sm-19 col-md-20">
                    <label><input type="checkbox" name="remove_link" value="1" {ROW.ck_remove_link} />{LANG.remove_link_note}</label>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group" style="text-align: center">
        <input class="btn btn-primary" name="submit" type="submit" value="{LANG.save}" />
    </div>
</form>
<script>
    var CFG = [];
    CFG.news_groups = '{ROW.news_groups}';
    CFG.is_edit = '{ROW.is_edit}';
</script>
<!-- END: main -->