<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<!-- BEGIN: select2 -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<!-- END: select2 -->
<form action="{SEARCH.action}" method="get" id="frmSearchHouse">
    <section id="box_product_search">
        <div class="container">
            <div class="search-light">
                <div class="input-group col-xs-24">
                    <!-- BEGIN: no_rewrite -->
                    <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                    <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                    <input type="hidden" name="{NV_OP_VARIABLE}" value="search" />
                    <!-- END: no_rewrite -->
                    <div class="col-sm-6 col-xs-12 col-min-24 p-lr0 p-xs-b5">
                        <div class="input-keyword">
                            <input type="text" class="form-control" name="q" value="{SEARCH.q}" placeholder="{LANG.keywords_input}" />
                        </div>
                    </div>
                   
                    <div class="col-sm-3 col-xs-12 col-min-24 p-lr0 p-xs-b5">
                        <div class="form-group">
                            <select name="type" class="form-control">
                                <!-- BEGIN: type -->
                                <option value="{TYPE.id}"{TYPE.selected}>{TYPE.space}{TYPE.title}</option>
                                <!-- END: type -->
                            </select>
                        </div>
                    </div>
                     <div class="col-sm-8 col-xs-24">{LOCATION}</div>
                    <div class="col-sm-4 col-xs-12 col-min-24 p-xs-lr0 p-xs-b5">
                        <select name="catid" class="form-control select2">
                            <option value="0">---{LANG.cat_select}---</option>
                            <!-- BEGIN: cat -->
                            <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                            <!-- END: cat -->
                        </select>
                    </div>
                    <input type="hidden" name="is_search" value="1" />
                    <input type="submit" class="btn btn-primary col-sm-3 col-xs-12 col-min-24" value="{LANG.search}" />
                </div>
            </div>
        </div>
    </section>
</form>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
    $('.select2').select2({
        theme : 'bootstrap',
        language : '{NV_LANG_INTERFACE}'
    });
    
    $("#date_begin,#date_end").datepicker({
        dateFormat : "dd/mm/yy",
        changeMonth : true,
        changeYear : true,
        showOtherMonths : true,
    });
</script>
<!-- END: main -->