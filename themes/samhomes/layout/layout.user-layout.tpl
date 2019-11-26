<!-- BEGIN: main -->
{FILE "header_only.tpl"} {FILE "header_extended.tpl"}
<section class="custom_my clearfix">
    <div id="my_full_page" role="main">
        <section id="my_action_content" class="col-sm-18 col-md-19 col-sm-push-6 col-md-push-5">
            {MODULE_CONTENT}
        </section>
        <nav id="my_actions" class="col-sm-6 col-md-5 col-sm-pull-18 col-md-pull-19">
           [LEFT]
        </nav>
    </div>
</section>
{FILE "footer_extended.tpl"} {FILE "footer_only.tpl"}
<!-- END: main -->
<div class="row">[HEADER]</div>
<div class="row">
    <div class="col-sm-18 col-md-19 col-sm-push-6 col-md-push-5">[TOP] {MODULE_CONTENT} [BOTTOM]</div>
    <div class="col-sm-6 col-md-5 col-sm-pull-18 col-md-pull-19">[LEFT]</div>
</div>
<div class="row">[FOOTER]</div>