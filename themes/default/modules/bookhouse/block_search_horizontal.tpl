<!-- BEGIN: main -->
<div class="block_search_horziontal">
    <form action="{NV_BASE_SITEURL}index.php" method="get">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" /> <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP_NAME}" />
        <div class="stv-radio-tabs-wrapper">
            <!-- BEGIN: type -->
            <input type="radio" class="stv-radio-tab" name="typeid" value="{TYPE.id}" id="block_{BLOCK_CONFIG.bid}_type_{TYPE.id}" {TYPE.checked} /> <label for="block_{BLOCK_CONFIG.bid}_type_{TYPE.id}">{TYPE.title}</label>
            <!-- END: type -->
        </div>
        <div class="row">
            <div class="col-xs-24 col-md-12">
                <div class="form-group">
                    <label>{LANG.keywords}</label> <input type="text" class="form-control" name="q" value="{SEARCH.q}" placeholder="{LANG.keywords}">
                </div>
            </div>
            <div class="col-xs-24 col-md-12">
                <div class="form-group">
                    <label>{LANG.category}</label> <select name="catid" class="form-control" id="search_catid">
                        <option value=0>---{LANG.all_category}---</option>
                        <!-- BEGIN: cat -->
                        <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                        <!-- END: cat -->
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-24 col-md-12">
                <div class="form-group">
                    <!-- BEGIN: area -->
                    <label>{LANG.area}</label>
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <input type="text" class="form-control" name="area_from" value="{SEARCH.area_from}" placeholder="{LANG.area_from}" />
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <input type="text" class="form-control" name="area_to" value="{SEARCH.area_from}" placeholder="{LANG.to}" />
                        </div>
                    </div>
                    <!-- END: area -->
                    <!-- BEGIN: size -->
                    <label>{LANG.size}</label>
                    <div class="row">
                        <div class="col-xs-12 col-md-12">
                            <input type="text" class="form-control" name="size_v" value="{SEARCH.size_v}" placeholder="{LANG.size_v}" />
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <input type="text" class="form-control" name="size_h" value="{SEARCH.size_h}" placeholder="{LANG.size_h}" />
                        </div>
                    </div>
                    <!-- END: size -->
                </div>
            </div>
            <div class="col-xs-24 col-md-12">
                <div class="form-group">
                    <label>{LANG.price}</label> <select name="price" class="form-control">
                        <option value="0">---{LANG.price_spread_c}---</option>
                        <!-- BEGIN: price -->
                        <option value="{PRICE.index}"{PRICE.selected}>{PRICE.title}</option>
                        <!-- END: price -->
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-24 col-md-12">
                <div class="form-group">
                    <label>{LANG.items_location}</label> {LOCATION}
                </div>
            </div>
        </div>
        <div class="text-center">
            <button type="submit" name="search" class="btn btn-primary">{LANG.search}</button>
        </div>
    </form>
</div>
<script>
    $(document).ready(function() {
        $('.block_search_horziontal input[name="typeid"]').change(function() {
            $.ajax({
                type : 'POST',
                dataType : 'html',
                url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '={MODULE_NAME}&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
                data : 'getcat=1&typeid=' + $(this).val(),
                success : function(data) {
                    $('.block_search_horziontal #search_catid').html(data);
                }
            });
        });
    });
</script>
<!-- END: main -->