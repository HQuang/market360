<!-- BEGIN: signed -->
<div class="menu-header">
    <a href="#" class="img-users" onclick="changeAvatar('{URL_AVATAR}');" style="position: relative;"><img src="{AVATA}"> <span class="span-camera"></span> </a>
</div>
<div id="main_menu">
    <ul class="nav nav-pills nav-stacked">
        <li class="header">Thông tin chung</li>
        <li><a href="/users/editinfo/" class="hvr-icon-up"><i class="fa fa-user hvr-icon"></i>{USER.full_name}</a></li>
        <li><a href="mailto:{USER.email}" class="hvr-icon-up"><i class="fa fa-envelope hvr-icon"></i> {USER.email}</a></li>
        <!-- BEGIN: change_login_note -->
        <div class="alert alert-danger">
            <em class="fa fa-exclamation-triangle ">&nbsp;</em> {USER.change_name_info}
        </div>
        <!-- END: change_login_note -->
        <!-- BEGIN: pass_empty_note -->
        <div class="alert alert-danger">
            <em class="fa fa-exclamation-triangle ">&nbsp;</em> {USER.pass_empty_note}
        </div>
        <!-- END: pass_empty_note -->
        <!-- BEGIN: question_empty_note -->
        <div class="alert alert-danger">
            <em class="fa fa-exclamation-triangle ">&nbsp;</em> {USER.question_empty_note}
        </div>
        <!-- END: question_empty_note -->
        <li class="header">Quản lý tin</li>
        <li><a href="/content/" class="hvr-icon-up"><i class="fa fa-pencil hvr-icon"></i> Đăng tin</a></li>
        <li><a href="/userarea/" class="hvr-icon-up"><i class="fa fa-paper-plane hvr-icon"></i> Tin đăng của tôi</a></li>
        <li><a href="/saved/" class="hvr-icon-up"><i class="fa fa-heart hvr-icon"></i> Tin đã lưu</a></li>
        <li class="header">Quản lý tài khoản</li>
        <li><a href="/users/editinfo/" class="hvr-icon-up"><i class="fa fa-user hvr-icon"></i> Thông Tin Cá Nhân</a></li>
        <li><a href="/wallet/main/" class="hvr-icon-up"><i class="fa fa-money hvr-icon"></i> Nạp tiền</a></li>
        <li><a href="/wallet/historyexchange/" class="hvr-icon-up"><i class="fa fa-history hvr-icon"></i> Lịch sử giao dịch</a></li>
        <li><a href="/wallet/exchange/" class="hvr-icon-up"><i class="fa fa-history hvr-icon"></i> Hệ thống đổi tiền</a></li>
        <li><a href="/wallet/money/" class="hvr-icon-up"><i class="fa fa-university hvr-icon"></i> Quản lý số dư</a></li>
        <li><a href="/users/memberlist/" class="hvr-icon-up"><i class="fa fa-address-book hvr-icon"></i> Danh sách thành viên</a></li>
        <li><a href="{URL_LOGOUT}" class="hvr-icon-up visible-xs"><i class="fa fa-sign-out hvr-icon"></i>Thoát</a></li>
    </ul>
</div>
<!-- END: signed -->