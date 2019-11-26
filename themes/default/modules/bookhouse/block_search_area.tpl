<!-- BEGIN: main -->
<div class="block_search_area">
    <form action="{NV_BASE_SITEURL}" method="get" class="form-horizontal">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" /> <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP_NAME}" />
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-md-8">
                <select name="typeid" class="form-control">
                    <!-- BEGIN: type -->
                    <option value="{TYPE.id}"{TYPE.selected}>{TYPE.title}</option>
                    <!-- END: type -->
                </select>
            </div>
            <div class="col-xs-12 col-sm-8 col-md-8">{LOCATION}</div>
            <div class="col-xs-12 col-sm-8 col-md-8">
                <input type="text" class="form-control" name="keywords" placeholder="{LANG.keywords}">
            </div>
        </div>
        <button type="submit" name="search" class="btn btn-primary">{LANG.search}</button>
    </form>
</div>
<!-- END: main -->