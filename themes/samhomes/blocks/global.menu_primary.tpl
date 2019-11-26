<!-- BEGIN: submenu -->
<ul class="dropdown-menu">
    <!-- BEGIN: loop -->
    <li
        <!-- BEGIN: submenu -->class="dropdown-submenu"<!-- END: submenu -->> <!-- BEGIN: icon --> <img src="{SUBMENU.icon}" />&nbsp; <!-- END: icon --> <a href="{SUBMENU.link}" title="{SUBMENU.note}"{SUBMENU.target}>{SUBMENU.title_trim}</a> <!-- BEGIN: item --> {SUB} <!-- END: item -->
    </li>
    <!-- END: loop -->
</ul>
<!-- END: submenu -->
<!-- BEGIN: main -->
<div class="widget-ft">
    <h4 class="title-menu text-right">
        <a role="button" class="collapsed" data-toggle="collapse" aria-expanded="false" data-target="#collapseListMenu02" aria-controls="collapseListMenu02"> {BLOCK_TITLE} <i class="fa fa-plus" aria-hidden="true"></i>
        </a>
    </h4>
    <div class="collapse time_work" id="collapseListMenu02">
        <ul class="list-menu">
            <!-- BEGIN: top_menu -->
            <li class="li_menu"><a href="{TOP_MENU.link}">{TOP_MENU.title_trim}</a></li>
            <!-- END: top_menu -->
        </ul>
    </div>
</div>
<!-- END: main -->
<!-- BEGIN: top_menu -->
<li {TOP_MENU.current} role="presentation"><a class="dropdown-toggle" {TOP_MENU.dropdown_data_toggle} href="{TOP_MENU.link}" role="button" aria-expanded="false" title="{TOP_MENU.note}"{TOP_MENU.target}> <!-- BEGIN: icon --> <img src="{TOP_MENU.icon}" />&nbsp; <!-- END: icon --> {TOP_MENU.title_trim}<!-- BEGIN: has_sub --> <strong class="caret">&nbsp;</strong> <!-- END: has_sub --></a></li>
<!-- END: top_menu -->