<!-- BEGIN: main -->
{FILE "header_only.tpl"} {FILE "header_extended.tpl"} [CONTENT_ONE]
<!-- BEGIN: breadcrumbs -->
<section id="breadcrumb">
    <span class="crumb-border"></span>
    <div class="container">
        <div class="row">
            <div class="col-xs-24 a-left no-padding">
                <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
                    <li class="breadcrumb-item"><a href="{THEME_SITE_HREF}">Trang chủ</a></li>
                    <!-- BEGIN: loop -->
                    <li class="breadcrumb-item active"><a href="{BREADCRUMBS.link}"><span>{BREADCRUMBS.title}</span></a></li>
                    <!-- END: loop -->
                </ul>
            </div>
        </div>
    </div>
</section>
<!-- END: breadcrumbs -->
<div id="body_content" class="custom_page_product_index" role="main">
    <div class="container">
        <div class="row">
            <div class="col-sm-16 col-md-18">
            [CONTENT_TWO]
            {MODULE_CONTENT}</div>
            <div class="col-sm-8 col-md-6 hidden-xs">
                <div id="boxLocations">[RIGHT]</div>
            </div>
        </div>
    </div>
</div>
{FILE "footer_extended.tpl"} {FILE "footer_only.tpl"}
<!-- END: main -->