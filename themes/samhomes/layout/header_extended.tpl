<noscript>
    <div class="alert alert-danger">{LANG.nojs}</div>
</noscript>
<nav class="navbar navbar-inverse " id="nav_header_top" data-spy="affix" data-offset-top="50" data-interval=5000>
    <div class="container">
        <div class="navbar-header row">
            <div class=" col-xs-8 navbar-header-left">
                <!-- BEGIN: image -->
                <a title="{SITE_NAME}" href="{THEME_SITE_HREF}" class="navbar-brand"><img src="{LOGO_SRC}" width="{LOGO_WIDTH}" height="{LOGO_HEIGHT}" alt="{SITE_NAME}" /></a>
                <!-- END: image -->
                <!-- BEGIN: swf -->
                <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="{LOGO_WIDTH}" height="{LOGO_HEIGHT}">
                    <param name="wmode" value="transparent" />
                    <param name="movie" value="{LOGO_SRC}" />
                    <param name="quality" value="high" />
                    <param name="menu" value="false" />
                    <param name="seamlesstabbing" value="false" />
                    <param name="allowscriptaccess" value="samedomain" />
                    <param name="loop" value="true" />
                    <!--[if !IE]> <-->
                    <object type="application/x-shockwave-flash" width="{LOGO_WIDTH}" height="{LOGO_HEIGHT}" data="{LOGO_SRC}">
                        <param name="wmode" value="transparent" />
                        <param name="pluginurl" value="http://www.adobe.com/go/getflashplayer" />
                        <param name="loop" value="true" />
                        <param name="quality" value="high" />
                        <param name="menu" value="false" />
                        <param name="seamlesstabbing" value="false" />
                        <param name="allowscriptaccess" value="samedomain" />
                    </object>
                    <!--> <![endif]-->
                </object>
                <!-- END: swf -->
                <!-- BEGIN: site_name_h1 -->
                <h1 class="hidden">{SITE_NAME}</h1>
                <h2 class="hidden">{SITE_DESCRIPTION}</h2>
                <!-- END: site_name_h1 -->
                <!-- BEGIN: site_name_span -->
                <span class="site_name hidden">{SITE_NAME}</span> <span class="site_description hidden">{SITE_DESCRIPTION}</span>
                <!-- END: site_name_span -->
            </div>
        </div>
        <div class="row">
            [MENU_SITE]
            <ul class="nav navbar-nav" id="user_menu">
                <li class="dropdown">[USERS]</li>
                <li class="p-lr0">[HEAD_RIGHT]</li>
            </ul>
        </div>
    </div>
</nav>
[THEME_ERROR_INFO]
