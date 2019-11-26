<!-- BEGIN: main -->
<div class="widget-ft">
    <h4 class="title-menu text-right">
        <a role="button" class="collapsed" data-toggle="collapse" aria-expanded="false" data-target="#collapseListMenu04" aria-controls="collapseListMenu04"> {BLOCK_TITLE} <i class="fa fa-plus" aria-hidden="true"></i>
        </a>
    </h4>
    <div class="collapse time_work" id="collapseListMenu04">
        <ul class="list-menu">
            <!-- BEGIN: top_menu -->
            <li class="li_menu"><a href="{TOP_MENU.link}">{TOP_MENU.title_trim}</a></li>
            <!-- END: top_menu -->
        </ul>
    </div>
</div>
<!-- END: main -->
<!-- BEGIN: submenu -->
<!-- BEGIN: loop -->
<div class="col-xs-12">
    <a href="{SUBMENU.link}" title="{SUBMENU.note}"{SUBMENU.target}>{SUBMENU.title_trim}</a>
    <!-- BEGIN: item -->
    {SUB}
    <!-- END: item -->
</div>
<!-- END: loop -->
<!-- END: submenu -->