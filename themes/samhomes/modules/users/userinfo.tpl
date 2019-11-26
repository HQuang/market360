<!-- BEGIN: main -->
<h2 class="title">{LANG.user_info}</h2>
<div class="content-body">
    <div class="panel-body">
        <div class="row">
            <div>
                <ul class="nv-list-item xsm">
                    <li><em class="fa fa-angle-right">&nbsp;</em> {LANG.account2}: <strong>{USER.username}</strong> ({USER.email})</li>
                    <li><em class="fa fa-angle-right">&nbsp;</em> {USER.current_mode}</li>
                    <li><em class="fa fa-angle-right">&nbsp;</em> {LANG.current_login}: {USER.current_login}</li>
                    <li><em class="fa fa-angle-right">&nbsp;</em> {LANG.ip}: {USER.current_ip}</li>
                </ul>
            </div>
        </div>
    </div>
</div>
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
<div class="content-body">
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <colgroup>
                <col style="width: 45%" />
            </colgroup>
            <tbody>
                <tr>
                    <td>{LANG.name}</td>
                    <td>{USER.full_name}</td>
                </tr>
                <tr>
                    <td>{LANG.birthday}</td>
                    <td>{USER.birthday}</td>
                </tr>
                <tr>
                    <td>{LANG.gender}</td>
                    <td>{USER.gender}</td>
                </tr>
                <tr>
                    <td>{LANG.showmail}</td>
                    <td>{USER.view_mail}</td>
                </tr>
                <tr>
                    <td>{LANG.regdate}</td>
                    <td>{USER.regdate}</td>
                </tr>
                <!-- BEGIN: group_manage -->
                <tr>
                    <td>{LANG.group_manage_count}</td>
                    <td>
                        {USER.group_manage} <a href="{URL_GROUPS}" title="{LANG.group_manage_list}">({LANG.group_manage_list})</a>
                    </td>
                </tr>
                <!-- END: group_manage -->
                <tr>
                    <td>{LANG.st_login2}</td>
                    <td>{USER.st_login}</td>
                </tr>
                <tr>
                    <td>{LANG.2step_status}</td>
                    <td>
                        {USER.active2step} (<a href="{URL_2STEP}">{LANG.2step_link}</a>)
                    </td>
                </tr>
                <tr>
                    <td>{LANG.last_login}</td>
                    <td>{USER.last_login}</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<!-- END: main -->