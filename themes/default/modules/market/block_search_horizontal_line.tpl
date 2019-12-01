<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<!-- BEGIN: select2 -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css">
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<!-- END: select2 -->
<div id="box_search">
    <div class="row">
        <div class="col-xs-24 col-sm-18 col-md-18 form-search" style="margin: 0 auto 15px auto; float: unset;">
            <form id="frmBoxSearch" action="{SEARCH.action}" method="get">
            <!-- BEGIN: no_rewrite -->
                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                <input type="hidden" name="{NV_OP_VARIABLE}" value="search" />
                <!-- END: no_rewrite -->
                <div class="group_insearch">
                    <div class="group_block group_1 advance_normal">
                        <select name="type" id="type">
                            <!-- BEGIN: type -->
                            <option value="{TYPE.id}"{TYPE.selected}>{TYPE.space}{TYPE.title}</option>
                            <!-- END: type -->
                        </select>
                    </div>
                    <div class="group_block group_2 advance_normal">
                        <div class="wrap_option_search">
                            <div class="input-group search_form">
                                <input type="text" name="q" value="{SEARCH.q}" placeholder="{LANG.keywords_input}... " class="input-group-field st-default-search-input search-text tdq_input" autocomplete="off">
                            </div>
                        </div>
                        <div class="button_search_sm">
                            <input type="hidden" name="is_search" value="1" />
                            <button type="submit" value="{LANG.search}">
                                <span><i class="fa fa-search"></i><span class="hidden-xs hidden-sm">{LANG.search}</span></span>
                            </button>
                        </div>
                    </div>
                    <div class="advance_option hidden">
                        <div class="col-xs-24 col-sm-8">
                            <div class="option_ advance_1">
                                <select name="catid" class="form-control select2">
                                    <option value="0">---{LANG.cat_select}---</option>
                                    <!-- BEGIN: cat -->
                                    <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                                    <!-- END: cat -->
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-24 col-sm-16">
                            <div class="option_ advance_2">{LOCATION}</div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<script>
    $('.select2').select2({
        theme : 'bootstrap',
        language : '{NV_LANG_INTERFACE}'
    });
</script>
<!-- END: main -->