<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<form method="post" class="form-horizontal" id="frm-warehouse-import">
<!-- BEGIN: list -->
<div class="panel panel-default">
    <div class="panel-heading">
        <strong>{LIST.snippet.title}</strong>
    </div>
    <div class="panel-body" style="max-height: 300px; overflow: auto;">
        <div class="row">
            <table class="table table-striped">
                <tbody id="area1_{LIST.id}"></tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    //<![CDATA[
        getVids('{CONFIG.api_key}', '{KEY_LIST}', '{LIST.id}');
    //]]>
</script>
<!-- END: list -->
<div class="text-center">
    <div class="text-center button_fixed_bottom">
        <input type="hidden" name="submit" value="1">
        <input type="submit" id="submit" class="btn btn-primary" value="Lưu lại">
        <a class="cancelLink" href="javascript:history.back()" type="reset">Hủy</a>
    </div>
</div>
</form>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
    //<![CDATA[
        
    $('#frm-warehouse-import').submit(function(e) {
        $('body').append('<div class="ajax-load-qa"></div>');
        e.preventDefault();
        $.ajax({
            type : 'POST',
            url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=get_youtube_v2&nocache=' + new Date().getTime(),
            data : $(this).serialize(),
            success : function(json) {
                if (json.error) {
                    alert(json.msg);
                    $(".ajax-load-qa").remove();
                } else {
                    $(".ajax-load-qa").remove();
                    window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main';
                }
            }
        });
    }) 
        
//     $(document).ready(function() {
//         $('#submit').click(function(e) {
//             $('body').append('<div class="ajax-load-qa"></div>');
//             e.preventDefault();
            
//             $.ajax({
//                 type : 'POST',
//                 url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=get_youtube_v2&nocache=' + new Date().getTime(),
//                 data : 'submit=1',
//                 success : function(json) {
//                     if (json.error) {
//                         alert(json.msg);
//                         $(".ajax-load-qa").remove();
//                     } else {
//                         $(".ajax-load-qa").remove();
// //                         window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main';
//                     }
//                 }
//             });
//         });
//     });
    //]]>
</script>
<!-- END: main -->