<!-- BEGIN: main -->
<div class="block_search_vertical">
    <form action="{NV_BASE_SITEURL}" method="get" class="form-horizontal">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" /> <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" /> <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP_NAME}" />
        <div class="form-group">
            <label>{LANG.type}</label>
            <!-- BEGIN: type -->
            <label><input type="radio" name="typeid" value="{TYPE.id}"{TYPE.checked}>{TYPE.title}</label>
            <!-- END: type -->
        </div>
        <div class="form-group">
            <label>{LANG.keywords}</label> <input type="text" class="form-control" name="q" value="{SEARCH.q}" placeholder="{LANG.keywords}">
        </div>
        <div class="form-group">
            <label>{LANG.category}</label> <select name="catid" id="search_catid" class="form-control">
                <option value=0>---{LANG.all_category}---</option>
                <!-- BEGIN: cat -->
                <option value="{CAT.id}"{CAT.selected}>{CAT.space}{CAT.title}</option>
                <!-- END: cat -->
            </select>
        </div>
        <!-- BEGIN: area -->
        <div class="form-group">
            <label>{LANG.area} (m<sup>2</sup>)
            </label>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <input type="text" class="form-control" name="area_from" value="{SEARCH.area_from}" placeholder="{LANG.area_from}" />
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <input type="text" class="form-control" name="area_to" value="{SEARCH.area_to}" placeholder="{LANG.to}" />
                </div>
            </div>
        </div>
        <!-- END: area -->
        <!-- BEGIN: size -->
        <div class="form-group">
            <label>{LANG.size}</label> <input type="text" class="form-control" name="size_v" value="{SEARCH.size_v}" placeholder="{LANG.size_v}" />
        </div>
        <div class="form-group">
            <input type="text" class="form-control" name="size_h" value="{SEARCH.size_h}" placeholder="{LANG.size_h}" />
        </div>
        <!-- END: size -->
        <div class="form-group">
            <label>{LANG.price}</label> <select name="price" class="form-control">
                <option value="0">---{LANG.price_spread_c}---</option>
                <!-- BEGIN: price -->
                <option value="{PRICE.index}"{PRICE.selected}>{PRICE.title}</option>
                <!-- END: price -->
            </select>
        </div>
        <div class="form-group">
            <label>{LANG.items_location}</label> {LOCATION}
        </div>
        <button type="submit" name="search" class="btn btn-primary">{LANG.search}</button>
    </form>
</div>
<script>
$('.block_search_vertical input[name="typeid"]').change(function(){
	$.ajax({
		type : 'POST',
		dataType: 'html',
		url : nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '={MODULE_NAME}&' + nv_fc_variable + '=ajax&nocache=' + new Date().getTime(),
		data : 'getcat=1&typeid=' + $(this).val(),
		success : function(data) {
			$('.block_search_vertical #search_catid').html(data);
		}
	});
});
</script>
<!-- END: main -->