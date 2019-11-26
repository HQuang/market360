<!-- BEGIN: main -->
<ul class="block_location_list">
    <!-- BEGIN: location -->
    <li><a href="{LOCATION.link}" title="{LOCATION.title}">{LOCATION.title}</a></li>
    <!-- END: location -->
</ul>
<!-- END: main -->
<!-- BEGIN: config -->
<div class="form-group">
    <label class="control-label col-sm-6">{LANG.type}</label>
    <div class="col-sm-18">
        <select name="config_typeid" class="form-control">
            <!-- BEGIN: type -->
            <option value="{TYPE.id}"{TYPE.selected}>{TYPE.title}</option>
            <!-- END: type -->
        </select>
    </div>
</div>
<tr>
    <td>{LANG.location}</td>
    <td>{LOCATION}</td>
</tr>
<!-- END: config -->