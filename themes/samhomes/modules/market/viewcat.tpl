<!-- BEGIN: main -->
<div id="search_view_mode">
    <div class="row " id="tab_product_index">
        <div class="col-md-12  col-sm-8 col-xs-24 no-padding tab-left m-tb15">
            <div class="col-md-8 col-sm-24 col-xs-24 active text-center">
                <a href="#" class="text_content one-line">{CAT.title}</a>
            </div>
            <div class=" col-xs-8 text-center hidden-xs hidden-sm">
                <a href="#" class="text_content ">Cá nhân</a>
            </div>
            <div class=" col-xs-8 text-center hidden-xs hidden-sm">
                <a href="#" class="text_content">Môi giới</a>
            </div>
        </div>
        <!-- BEGIN: displays -->
        <div class="col-md-12 col-sm-16 col-xs-24 search-right text-center">
            <div class="m-tb15 d-flex ">
                <span class="lbl hidden-xs hidden-sm" style="min-width: 100px; line-height: 34px;">{LANG.displays_product}</span> 
                <select name="sort" id="sort" class="form-control col-xs-12 " onchange="nv_chang_price();" style="min-width: 85px;">
                    <!-- BEGIN: sorts -->
                    <option value="{key}"{se}>{value}</option>
                    <!-- END: sorts -->
                </select>
                <div class="view-list-gird col-xs-12">
                    <!-- BEGIN: viewtype -->
                    <a class="{VIEWTYPE.active} btn btn-sm iconLayout-{VIEWTYPE.icon} btn-default " href="#" onclick="nv_chang_viewtype('{VIEWTYPE.index}');" title="{VIEWTYPE.title}">Gird</a>
                    <!-- END: viewtype -->
                </div>
            </div>
        </div>
        <!-- END: displays -->
    </div>
</div>
<div id="page_listing">
    <div class="house_listing view_new">{DATA}</div>
</div>
<!-- END: main -->
<!-- BEGIN: subcat -->
<!-- BEGIN: loop -->
<h2 class="subcat">
    <a href="{SUBCAT.link}" title="{SUBCAT.title}">{SUBCAT.title}</a>
</h2>
<!-- END: loop -->
<div class="clear"></div>
<!-- END: subcat -->
<!-- BEGIN: description_html -->
<p>{CAT.description_html}</p>
<!-- END: description_html -->