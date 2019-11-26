<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2-bootstrap.min.css">
<!-- BEGIN: error -->
<div class="alert alert-warning">{ERROR}</div>
<!-- END: error -->
<div class="panel panel-default">
    <div class="panel-body">
        <form class="form-horizontal" action="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_FILE}&amp;{NV_OP_VARIABLE}={OP}" method="post">
            <input type="hidden" name="id" value="{ROW.id}" />
            <div class="form-group">
                <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.projects_name}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-21">
                    <input class="form-control" type="text" name="title" value="{ROW.title}" required="required" oninvalid="setCustomValidity( nv_required )" oninput="setCustomValidity('')" />
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.alias}</strong></label>
                <div class="col-sm-19 col-md-21">
                    <div class="input-group">
                        <input class="form-control" type="text" name="alias" value="{ROW.alias}" id="id_alias" /> <span class="input-group-btn">
                            <button class="btn btn-default" type="button">
                                <i class="fa fa-refresh fa-lg" onclick="nv_get_alias('id_alias');">&nbsp;</i>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.description}</strong> <span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-21">
                    <textarea class="form-control" style="height: 100px;" cols="75" rows="5" name="description">{ROW.description}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.descriptionhtml}</strong></label>
                <div class="col-sm-19 col-md-21">{ROW.descriptionhtml}</div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.items_location}</strong><span class="red">(*)</span></label>
                <div class="col-sm-19 col-md-21">{LOCATION}</div>
            </div>
            <div class="form-group">
                <label class="col-sm-5 col-md-3 control-label"><strong>{LANG.image}</strong></label>
                <div class="col-sm-19 col-md-21">
                    <div id="uploader" class="m-bottom">
                        <p>{LANG.images_none_support}</p>
                    </div>
                    <div class="other-image row" id="image-other">
                        <!-- BEGIN: data -->
                        <div class="col-xs-4 col-sm-3 col-md-3 other-image-item text-center thumb_booth new-images-append" id="other-image-div-{DATA.number}">
                            <input type="hidden" name="otherimage[{DATA.number}][id]" value="{DATA.number}"> <input type="hidden" name="otherimage[{DATA.number}][basename]" value="{DATA.basename}"> <input type="hidden" name="otherimage[{DATA.number}][homeimgfile]" value="{DATA.homeimgfile}"> <input type="hidden" name="otherimage[{DATA.number}][thumb]" value="{DATA.thumb}"> <input type="hidden" name="otherimage[{DATA.number}][name]" value="{DATA.title}"> <input type="hidden" name="otherimage[{DATA.number}][description]" value="{DATA.description}"> <a href="#" onclick="modalShow('{DATA.basename}', '<img src=\'{DATA.filepath}\' class=\'img-responsive\' />'); return false;"> <img style="height: 110px" class="img-thumbnail m-bottom responstyle {DATA.box_img}" src="{DATA.filepath}">
                            </a> <em title="{LANG.title_btn_closeimg}" class="fa fa-times-circle fa-lg fa-pointer btn-close_img" onclick="nv_delete_other_images( {DATA.number} ); return false;">&nbsp;</em> <input type="radio" class="input_img hidden" name="homeimg" value="{DATA.number}"{DATA.checked}> <input type="button" class="btn btn-success btn-xs avatar" value="{LANG.choose_img}" onclick="click_btn_avatar({DATA.number})">
                        </div>
                        <!-- END: data -->
                    </div>
                </div>
            </div>
            <div class="form-group text-center">
                <input class="btn btn-primary" name="submit" type="submit" value="{LANG.save}" />
            </div>
        </form>
    </div>
</div>
<link type="text/css" href="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css" rel="stylesheet" />
<script type="text/javascript" src="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/i18n/{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript">

var initUploader = function () {
    $("#uploader").pluploadQueue({
        runtimes: 'html5,flash,silverlight,html4',
        url: '{UPLOAD_URL}',
//         resize: {
//             width: '{MAXIMAGESIZEULOAD.0}',
//             height: '{MAXIMAGESIZEULOAD.1}'
//         },
        chunk_size: '{MAXFILESIZEULOAD}',
        max_retries: 3,
        rename: false,
        dragdrop: true,
        filters: {
            max_file_size: '{MAXFILESIZEULOAD}',            
            mime_types: [{
                title: "Image files",
                extensions: "jpg,gif,png,jpeg"
            }, ]
        },
        flash_swf_url: '{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/Moxie.swf',
        silverlight_xap_url: '{NV_BASE_SITEURL}modules/{MODULE_FILE}/plupload/Moxie.xap',
        multi_selection: true,
        prevent_duplicates: true,
        multiple_queues: false,
        init: {
            FilesAdded: function (up, files) {
                this.start();
                return false;
            },
            UploadComplete: function (up, files) {
                $(".plupload_buttons").css("display", "inline");
                $(".plupload_upload_status").css("display", "inline");
            }
        }
    });
    
    var uploader = $("#uploader").pluploadQueue();
    uploader.bind('BeforeUpload', function(up) {
         up.settings.multipart_params = {
                'folder': ''
         };
    });
    
    var j = '{COUNT_UPLOAD}';
    var i = '{COUNT}';
    uploader.bind('FileUploaded', function(up, file, response) {
        if($.parseJSON(response.response).error.length == 0){
            var content = $.parseJSON(response.response).data;
            var item='';
            item+='<div class="col-xs-4 col-sm-3 col-md-3 other-image-item text-center thumb_booth new-images-append" id="other-image-div-' + i + '">';
            item+='                 <input type="hidden" name="otherimage['+ i +'][id]" value="'+i+'">';
            item+='                 <input type="hidden" name="otherimage['+ i +'][basename]" value="'+ content['basename'] +'">';
            item+='                 <input type="hidden" name="otherimage['+ i +'][homeimgfile]" value="'+ content['homeimgfile'] +'">';
            item+='                 <input type="hidden" name="otherimage['+ i +'][thumb]" value="'+ content['thumb'] +'">';
            item+='                 <input type="hidden" name="otherimage['+ i +'][name]" value="' + content['basename'] + '" >';
            item+='                 <input type="hidden" name="otherimage['+ i +'][description]" value="' + content['description'] + '" >';
            item+='                 <a href="#" onclick="modalShow(\'' + content['basename'] + '\', \'<img src=' + content['image_url'] + ' class=img-responsive />\' ); return false;" >';
            item+='                     <img class="img-thumbnail m-bottom responstyle" src="'+ content['thumb'] +'">';
            item+='                 </a>';
            item+='                 <em title="{LANG.title_btn_closeimg}" class="fa fa-times-circle fa-lg fa-pointer btn-close_img" onclick="nv_delete_other_images_tmp(\'' + content['image_url'] + '\', \'' + content['thumb'] + '\', ' + i + '); return false;">&nbsp;</em>';
            item+='                 <input type="radio" class="radio_btn input_img hidden" name="homeimg" value="'+ i +'">';
            item+='                 <input type="button" class="btn btn-success btn-xs avatar" value="{LANG.choose_img}" onclick="click_btn_avatar(' + i + ')">';
            item+='</div>';
            item+='</div>';

            $('#image-other').append(item);
            ++i;    
        }else{
            alert($.parseJSON(response.response).error.message);
        }
    });
    
    {RADIO_JS}

    uploader.bind("UploadComplete", function (up, files) {
        initUploader();
    });

    uploader.bind('QueueChanged', function() {

    });

    uploader.bind('FilesAdded', function(up, files) {
        if( files.length > j )
        {
            alert( strip_tags( '{LANG.error_required_otherimage}' ) );
            $.each(files, function(i, file) {
                up.removeFile(file);
            });
        }
    });
};

$(document).ready(function(){
    initUploader();
});

$('.images-add').click(function(){
    $('#uploader').show();
    $('.images-add').hide();
});
</script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/select2.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript">
    //<![CDATA[
    function click_btn_avatar(id){
        $("#other-image-div-"+id+" .input_img").prop("checked", true);
        $(".responstyle").removeClass('box_img');$
        $("#other-image-div-"+id+" .responstyle").addClass('box_img');$
    }    
    
    $('.select2').select2({
        theme : 'bootstrap',
        language : '{NV_LANG_INTERFACE}'
    });
    
    function nv_get_alias(id) {
        var title = strip_tags($("[name='title']").val());
        if (title != '') {
            $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=projects-content&nocache=' + new Date().getTime(), 'get_alias_title=' + encodeURIComponent(title), function(res) {
                $("#" + id).val(strip_tags(res));
            });
        }
        return false;
    }
    //]]>
</script>
<!-- BEGIN: auto_get_alias -->
<script type="text/javascript">
    //<![CDATA[
    $("[name='title']").change(function() {
        nv_get_alias('id_alias');
    });
    //]]>
</script>
<!-- END: auto_get_alias -->
<!-- END: main -->