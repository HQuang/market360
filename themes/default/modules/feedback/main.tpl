<!-- BEGIN: main -->
<!-- BEGIN: header -->
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/{TEMPLATE_JS}/js/feedback.js"></script>
<link rel="StyleSheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE_CSS}/css/feedback.css" type="text/css" />
<!-- END: header -->
<div id="feedback" class="nv-fullbg">
    <div id="formfeedback" class="feedback-form">
        <!-- BEGIN: allowed_comm -->
        <!-- BEGIN: feedback_result -->
        <div class="alert alert-info" id="alert-info">{STATUS_FEEDBACK}</div>
        <script type="text/javascript">
                                    $('#alert-info').delay(5000).fadeOut('slow');
                                </script>
        <!-- END: comment_result -->
        <div class="dropdown">
            <form id="frmFeeback" method="post" role="form" target="submitfeedbackarea" action="{FORM_ACTION}" data-module="{MODULE_COMM}" data-content="{MODULE_DATA}_feedbackcontent" data-area="{AREA_COMM}" data-id="{ID_COMM}" data-allowed="{ALLOWED_COMM}" data-checkss="{CHECKSS_COMM}" data-gfxnum="{GFX_NUM}" data-editor="{EDITOR_COMM}"
                <!-- BEGIN: enctype -->enctype="multipart/form-data"<!-- END: enctype -->>
                <input type="hidden" name="module" value="{MODULE_COMM}" />
                <input type="hidden" name="area" value="{AREA_COMM}" />
                <input type="hidden" name="id" value="{ID_COMM}" />
                <input type="hidden" id="feedbackpid" name="pid" value="0" />
                <input type="hidden" name="allowed" value="{ALLOWED_COMM}" />
                <input type="hidden" name="checkss" value="{CHECKSS_COMM}" />
                <button class="btn btn-primary btn-block btn-sm dropdown-toggle" type="button" data-toggle="dropdown">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;Phản hồi
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    <div class="form-group clearfix">
                        <div class="col-xs-24 m-b10 p-lr0">
                            <input id="feedbackname" type="text" name="name" value="{NAME}" {DISABLED} class="form-control" placeholder="{LANG.feedback_name}" />
                        </div>
                        <div class="col-xs-24 m-b10 p-lr0">
                            <input id="feedbackemail_iavim" type="text" name="email" value="{EMAIL}" {DISABLED} class="form-control" placeholder="{LANG.feedback_email}" />
                        </div>
                        <textarea class="form-control m-b10" style="width: 100%" name="content" id="feedbackcontent" cols="20" rows="5" placeholder="{LANG.content_edit}" ></textarea>
                        <!-- BEGIN: editor -->
                        <script type="text/javascript" src="{NV_BASE_SITEURL}{NV_EDITORSDIR}/ckeditor/ckeditor.js?t={TIMESTAMP}"></script>
                        <script type="text/javascript">
                                                                                                    nv_commment_buildeditor();
                                                                                                </script>
                        <!-- END: editor -->
                        <!-- BEGIN: attach -->
                        <div class="form-group">
                            <div class="row">
                                <label class="col-xs-12 col-sm-8 col-md-6 control-label">{LANG.attach}</label>
                                <div class="col-xs-12 col-sm-16 col-md-18">
                                    <input type="file" name="fileattach" />
                                </div>
                            </div>
                        </div>
                        <!-- END: attach -->
                        <!-- BEGIN: captcha -->
                        <div class="form-group clearfix">
                            <div class="row">
                                <label class="col-xs-24 hidden-xs">{LANG.feedback_seccode}</label>
                                <div class="col-xs-12 col-sm-8">
                                    <img class="captchaImg" alt="{N_CAPTCHA}" src="{SRC_CAPTCHA}" width="{GFX_WIDTH}" height="{GFX_HEIGHT}" /> &nbsp;<em class="fa fa-pointer fa-refresh fa-lg" onclick="change_captcha('#commentseccode_iavim');">&nbsp;</em>
                                </div>
                                <div class="col-xs-12">
                                    <input id="commentseccode_iavim" type="text" class="form-control" maxlength="{GFX_NUM}" name="code" />
                                </div>
                            </div>
                        </div>
                        <!-- END: captcha -->
                        <!-- BEGIN: recaptcha -->
                        <div class="form-group clearfix">
                            <div class="nv-recaptcha-default">
                                <div id="{RECAPTCHA_ELEMENT}"></div>
                            </div>
                            <script type="text/javascript">
                                                                                                                    nv_recaptcha_elements.push({
                                                                                                                        id : "{RECAPTCHA_ELEMENT}",
                                                                                                                        btn : $("#buttoncontent", $('#{RECAPTCHA_ELEMENT}').parent().parent().parent())
                                                                                                                    })
                                                                                                                </script>
                        </div>
                        <!-- END: recaptcha -->
                        <div class="form-group text-center">
                            <input id="buttoncontent" type="submit" value="{LANG.feedback_submit}" class="btn btn-primary btn-sm" />
                        </div>
                </ul>
            </form>
        </div>
        <iframe class="hidden" id="submitfeedbackarea" name="submitfeedbackarea"></iframe>
        <script type="text/javascript">
                                    $("#reset-cm").click(function() {
                                        $("#feedbackcontent,#feedbackseccode_iavim").val("");
                                        $("#feedbackpid").val(0);
                                    });
                                </script>
        <!-- END: allowed_comm -->
        <!-- BEGIN: form_login-->
        <div class="alert alert-danger fade in">
            <!-- BEGIN: message_login -->
            <a title="{GLANG.loginsubmit}" href="#" onclick="return loginForm('');">{LOGIN_MESSAGE}</a>
            <!-- END: message_login -->
            <!-- BEGIN: message_register_group -->
            {LANG_REG_GROUPS}
            <!-- END: message_register_group -->
        </div>
        <!-- END: form_login -->
    </div>
</div>
<script type="text/javascript">
    var nv_url_comm = '{BASE_URL_COMM}';
    $("#sort").change(function() {
        $.post(nv_url_comm + '&nocache=' + new Date().getTime(), 'sortcomm=' + $('#sort').val(), function(res) {
            $('#feedback').html(res);
        });
    });
</script>
<!-- END: main -->
