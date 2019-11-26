<!-- BEGIN: main -->
<!-- BEGIN: mainleft -->
<div class="row">
    <!-- BEGIN: newsmain -->
    <div class="col-xs-24 col-sm-12">
        <div class="item first">
            <div class="image">
            <!-- BEGIN: image --> 
                <a href='{ROW.link}' title='{ROW.title}'><img src="{ROW.thumb}" alt="{ROW.title}" /></a>
                <!-- END: image --> 
            </div>
            <div class="text">
                <h3 class="line2">
                    <a href='{ROW.link}' title='{ROW.title}'>{ROW.title}</a>
                </h3>
                <p>{ROW.hometext}</p>
            </div>
        </div>
    </div>
    <!-- END: newsmain -->
    <div class="col-xs-24 col-sm-12">
     <!-- BEGIN: newssub -->
        <div class="item">
            <div class="image">
                <a href='{ROW.link}' title='{ROW.title}'><img src="{ROW.thumb}" alt="{ROW.title}" width='80' height='80' class="img-responsive" /></a>
            </div>
            <div class="text">
                <h3 class="line2">
                    <a href='{ROW.link}' title='{ROW.title}'>{ROW.title}</a>
                </h3>
                <span class="time_post"> <i class="fa fa-calendar"></i>&nbsp;{ROW.publtime}
                </span> </span>
            </div>
        </div>
         <!-- END: newssub -->
    </div>
</div>
<div class="row">
    <p align="center">
        <a href="{NV_BASE_SITEURL}{MODULE_LINK}" class="btn btn-border">Xem thêm thông tin</a>
    </p>
</div>
<!-- END: mainleft -->
<!-- BEGIN: maintop -->
<div style="text-align: center; padding-top: 5px;"></div>
<div class="list">
    <!-- BEGIN: newsmain -->
    <!-- BEGIN: image -->
    <div class="aligncenter col-sm-24 col-xs-12  col-min-24 overflow-hidden">
        <a href="{ROW.link}" class="effect-image"><img src="{ROW.thumb}" alt="{ROW.title}" title="{ROW.title}" class="img-responsive" /></a>
        <!-- END: image -->
        <div style="display: block; margin: 5px 0; border-bottom: 1px solid #ccc; padding-bottom: 5px;" class="two-line">
            <a href="{ROW.link}" style="color: #055699 !important; font-weight: bold;">{ROW.title}</a>
        </div>
    </div>
    <!-- END: newsmain -->
    <div class="col-sm-24 col-xs-12  col-min-24">
        <ul>
            <!-- BEGIN: newssub -->
            <li uid="0"><a href='{ROW.link}' title='{ROW.title}' class="two-line">{ROW.title}</a></li>
            <!-- END: newssub -->
        </ul>
    </div>
</div>
<!-- END: maintop -->
<!-- END: main -->
<!-- BEGIN: config -->
<tr>
    <td>Chon giao dien</td>
    <td>
        <select class="form-control" name="config_module_name">
            <!-- BEGIN: loop -->
            <option value="{MODULE.title}"{MODULE.selected}>{MODULE.custom_title}</option>
            <!-- END: loop -->
        </select>
    </td>
</tr>
<!-- BEGIN: module -->
<tr class="listcat {HIDDEN}" id="module_{MODULE.title}">
    <td>Chon chu de tin tuc</td>
    <td>
        <!-- BEGIN: cat_loop -->
        <label class="show"><input type="checkbox" name="config_catid[]" value="{CAT.catid}"{CAT.checked}>{CAT.title}</label>
        <!-- END: cat_loop -->
    </td>
</tr>
<!-- END: module -->
<tr>
    <td>{LANG.numrow}</td>
    <td>
        <input type="text" name="config_numrow" value="{DATA.numrow}" class="form-control">
    </td>
</tr>
<tr>
    <td>{LANG.style}</td>
    <td>
        <select class="form-control w200" name="config_style">
            <!-- BEGIN: style -->
            <option value="{STYLE.index}"{STYLE.selected}>{STYLE.value}</option>
            <!-- END: style -->
        </select>
    </td>
</tr>
<tr>
    <td>{LANG.imagesize}</td>
    <td>
        <div class="row">
            <div class="col-xs-12">
                <input type="text" name="config_imagesize_w" value="{DATA.imagesize_w}" class="form-control">
            </div>
            <div class="col-xs-12">
                <input type="text" name="config_imagesize_h" value="{DATA.imagesize_h}" class="form-control">
            </div>
        </div>
    </td>
</tr>
<script>
    $('select[name="config_module_name"]').change(function() {
        $('.listcat').addClass('hidden');
        $('#module_' + $(this).val()).removeClass('hidden');
    });
</script>
<!-- END: config -->