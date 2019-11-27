<!-- BEGIN: main -->
<!-- BEGIN: loop -->
<div class="item" itemtype="https://schema.org/House">
    <a itemprop="url" href="{ROW.link}" title="{ROW.title}">
        <div class="image">
            <img src="{ROW.thumb}" alt="{ROW.thumbalt}" width='320' height='240' />
            <div class="photo">3</div>
        </div>
    </a>
    <div class="block-info">
        <div class="header">
            <h3 class="line2">
                <a href="{ROW.link}" title="{ROW.title}">{ROW.title}</a>
            </h3>
            <!-- BEGIN: location -->
            <p>
                <a href="{ROW.location_link}" title="{ROW.location}">{ROW.location}</a>
            </p>
            <!-- END: location -->
        </div>
        <div class="body">
            <div class="value">
                <ul>
                    <!-- BEGIN: field -->
                    <li>{FIELD.title}: {FIELD.value}</li>
                    <!-- END: field -->
                </ul>
            </div>
        </div>
        <div class="footer">
            <span class="price">{ROW.price}</span> <span class="date pull-right"><i class="fa fa-clock-o"></i> {ROW.addtime}</span>
        </div>
    </div>
</div>
<!-- END: loop -->
<!-- END: main -->
<div class="viewlist-simple">
    <table class="table table-striped table-bordered table-hover table-middle">
        <thead>
            <tr>
                <th>{LANG.title}</th>
                <th width="150" class="hidden-xs">{LANG.addtime}</th>
            </tr>
        </thead>
        <tbody>
            <!-- BEGIN: loop -->
            <tr>
                <td>
                    <h3>
                        <a href="{ROW.link}" title="{ROW.title}"
                            <!-- BEGIN: color -->style="color: {ROW.color}"<!-- END: color --> ><strong>{ROW.title}</strong></a>
                    </h3>
                    <span class="help-block"><a href="{ROW.location}" title="{ROW.location}">{ROW.location}</a></span>
                </td>
                <td class="hidden-xs pointer form-tooltip">
                    <span data-toggle="tooltip" data-original-title="{ROW.addtime_f}">{ROW.addtime}</span>
                </td>
            </tr>
            <!-- END: loop -->
        </tbody>
    </table>
    <!-- BEGIN: page -->
    <div class="text-center">{PAGE}</div>
    <!-- END: page -->
</div>