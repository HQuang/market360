<!-- BEGIN: main -->
<div class="panel panel-default">
    <div class="panel-heading">{LANG.main}</div>
    <div class="panel-body">
        <form class="form-inline text-center" id="frm-submit">
            <div class="form-group">
                <label>{LANG.birthday_select}</label> &nbsp;&nbsp;<select class="form-control" name="year">
                    <!-- BEGIN: year -->
                    <option value="{YEAR.index}"{YEAR.selected}>{YEAR.index}</option>
                    <!-- END: year -->
                </select>&nbsp;&nbsp;
                <!-- BEGIN: gender -->
                <label><input type="radio" name="gender" value="{GENDER.index}" {GENDER.checked} />{GENDER.value}&nbsp;&nbsp;&nbsp;</label>
                <!-- END: gender -->
            </div>
            <input type="hidden" name="view" value="1" />
            <button type="submit" class="btn btn-primary">{LANG.view}</button>
        </form>
    </div>
</div>
<div id="result"></div>
<script>
    $('#frm-submit').submit(function(e) {
        e.preventDefault();
        $.ajax({
            type : 'POST',
            url : script_name + '?' + nv_name_variable + '=' + nv_module_name + '&nocache=' + new Date().getTime(),
            data : $(this).serialize(),
            success : function(html) {
                $('#result').html(html);
            }
        });
    });
</script>
<!-- END: main -->
<!-- BEGIN: result -->
<div class="panel panel-default result">
    <div class="panel-heading">{LANG.result}</div>
    <div class="panel-body">
        <!-- BEGIN: data -->
        <!-- BEGIN: good_direction -->
        <h3>{LANG.good_direction}</h3>
        <hr />
        <!-- END: good_direction -->
        <!-- BEGIN: bad_direction -->
        <h3 class="bad_direction">{LANG.bad_direction}</h3>
        <hr />
        <!-- END: bad_direction -->
        <p class="m-bottom">
            <strong>{DATA.direction_house.title}:</strong> <span class="blue">{DATA.direction}</span> ({DATA.direction_house.description})
        </p>
        <!-- END: data -->
    </div>
</div>
<!-- END: result -->