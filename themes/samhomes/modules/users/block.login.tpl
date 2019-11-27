<!-- BEGIN: main -->
<!-- BEGIN: display_button -->
<li class="dropdown" id="mnuGuest"><a href="#" onclick="return showLogin();" rel="nofollow"><i class="fa fa-user" aria-hidden="true"></i> Thành viên</a>
    <ul class="dropdown-menu dropdown-menu-right">
        <li><a href="#" onclick="modalShowByObj('#guestLogin_{BLOCKID}', 'recaptchareset')">Đăng nhập</a></li>
        <!-- BEGIN: allowuserreg2 -->
        <li><a href="#" onclick="modalShowByObj('#guestReg_{BLOCKID}', 'recaptchareset')">{GLANG.register}</a></li>
        <!-- END: allowuserreg2 -->
        <!-- BEGIN: allowuserreg_link -->
        <li><a href="{USER_REGISTER}" rel="nofollow">{GLANG.register}</a></li>
        <!-- END: allowuserreg_link -->
    </ul> <!-- START FORFOOTER -->
    <div id="guestLogin_{BLOCKID}" class="hidden">
        <div class="text-center" align="center">
            <img src="{NV_BASE_SITEURL}themes/{BLOCK_JS}/images/logo-2.png" alt="{SITE_NAME}" style="max-height: 90px;">
        </div>
        {FILE "login_form.tpl"}
    </div> <!-- END FORFOOTER --></li>
<!-- END: display_button -->
<!-- BEGIN: display_form -->
{FILE "login_form.tpl"}
<!-- END: display_form -->
<!-- BEGIN: allowuserreg -->
<div id="guestReg_{BLOCKID}" class="hidden">
    <h2 class="text-center margin-bottom-lg">{LANG.register}</h2>
    {FILE "register_form.tpl"}
</div>
<!-- END: allowuserreg -->
<!-- BEGIN: datepicker -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<!-- END: datepicker -->
<script src="{NV_BASE_SITEURL}themes/default/js/users.js"></script>
<!-- END: main -->
<!-- BEGIN: signed -->
<li class="dropdown" id="mnuGuest"><a href="#" title="{LANG.edituser}" rel="nofollow"><span class="one-line"><i class="fa fa-user-circle" aria-hidden="true"></i> {USER.full_name}</span></a>
    <ul class="dropdown-menu dropdown-menu-right">
        <li><a href="{URL_HREF}editinfo"> Thông Tin Cá Nhân</a></li>
        <li><a href="/wallet/main/"> Nạp tiền</a></li>
        <li><a href="/wallet/historyexchange/"> Lịch sử giao dịch</a></li>
        <li><a href="/wallet/exchange/"> Hệ thống đổi tiền</a></li>
        <li><a href="/wallet/money/"> Quản lý số dư</a></li>
        <li><a href="#" onclick="{URL_LOGOUT}(this);">{LANG.logout_title}</a></li>
    </ul></li>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/{BLOCK_JS}/js/users.js"></script>
<!-- END: signed -->