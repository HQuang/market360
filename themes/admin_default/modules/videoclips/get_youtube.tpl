<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<!-- BEGIN: list -->
<div class="panel panel-default">
    <div class="panel-heading">
        <strong>{LIST.snippet.title}</strong>
    </div>
    <div class="panel-body">
        <div class="row">
            <!-- BEGIN: video -->
            <div class="col-md-4">
                <img src="{VIDEO.snippet.thumbnails.medium.url}" width="100%"> {VIDEO.snippet.title}
            </div>
            <!-- END: video -->
        </div>
    </div>
<!--     <div class="panel-footer text-center"> -->
<!--         <ul class="pagination"> -->
<!--             <li><a href="#">1</a></li> -->
<!--             <li class="active"><a href="#">2</a></li> -->
<!--             <li><a href="#">3</a></li> -->
<!--             <li><a href="#">4</a></li> -->
<!--             <li><a href="#">5</a></li> -->
<!--         </ul> -->
<!--     </div> -->
</div>
<!-- END: list -->
<div class="text-center">
    <div class="text-center button_fixed_bottom">
        <input type="hidden" name="submit" value="1">
        <input type="submit" id="submit" class="btn btn-primary" value="Lưu lại">
        <a class="cancelLink" href="javascript:history.back()" type="reset">Hủy</a>
    </div>
</div>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript">
    //<![CDATA[
    $(document).ready(function() {
        $('#submit').click(function(e) {
            $('body').append('<div class="ajax-load-qa"></div>');
            e.preventDefault();
            
            $.ajax({
                type : 'POST',
                url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=get_youtube&nocache=' + new Date().getTime(),
                data : 'submit=1',
                success : function(json) {
                    if (json.error) {
                        alert(json.msg);
                        $(".ajax-load-qa").remove();
                        $('#' + json.input).focus();
                    } else {
                        $(".ajax-load-qa").remove();
//                         window.location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main';
                    }
                }
            });
        });
    });
    //]]>
</script>
<!-- END: main -->