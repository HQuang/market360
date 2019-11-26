<!-- BEGIN: main -->
<div id="search_view_mode">
    <div class="row">
        <div class="col-sm-24">
            <span>Tìm được 41,680 kết quả</span>
            <h1 style="padding: 0"></h1>
        </div>
    </div>
    <div class="row" id="tab_product_index">
        <div class="col-sm-12 col-md-14 col-xs-24 no-padding tab-left">
            <div class="col-sm-8 col-xs-8 active text-center">
                <a href="#" class="text_content">{CAT.title}</a>
            </div>
            <div class="col-sm-8 col-xs-8 text-center">
                <a href="#" class="text_content">Cá nhân</a>
            </div>
            <div class="col-sm-8 col-xs-8 text-center">
                <a href="#" class="text_content">Môi giới</a>
            </div>
        </div>
        <!-- BEGIN: displays -->
        <div class="col-sm-12 col-md-10 col-xs-24 search-right">
            <div class="view-list-gird  ">
                <!-- BEGIN: viewtype -->
                <a class="{VIEWTYPE.active} btn btn-sm iconLayout-{VIEWTYPE.icon} btn-default " href="#" onclick="nv_chang_viewtype('{VIEWTYPE.index}');" title="{VIEWTYPE.title}">Gird</a>
                <!-- END: viewtype -->
            </div>
            <div class="dropdown hidden-xs">
                <span class="lbl">{LANG.sort}</span>
                <div class="fld inline m-l5">
                    <select name="sort" id="sort" class="form-control input-sm" onchange="nv_chang_price();">
                        <!-- BEGIN: sorts -->
                        <option value="{key}"{se}>{value}</option>
                        <!-- END: sorts -->
                    </select>
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