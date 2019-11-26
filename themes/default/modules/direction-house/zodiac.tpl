<!-- BEGIN: main -->
<div class="panel panel-default">
    <div class="panel-heading">{LANG.zodiac}</div>
    <div class="panel-body">
        <form class="form-inline text-center" id="frm-submit">
            <div class="form-group">
                <label>{LANG.birthday}</label> &nbsp;&nbsp; <select class="form-control" name="day">
                    <!-- BEGIN: day -->
                    <option value="{DAY.index}"{DAY.selected}>{DAY.index}</option>
                    <!-- END: day -->
                </select>&nbsp;<select class="form-control" name="month">
                    <!-- BEGIN: month -->
                    <option value="{MONTH.index}"{MONTH.selected}>{MONTH.index}</option>
                    <!-- END: month -->
                </select>&nbsp;<select class="form-control" name="year">
                    <!-- BEGIN: year -->
                    <option value="{YEAR.index}"{YEAR.selected}>{YEAR.index}</option>
                    <!-- END: year -->
                </select>
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
        <strong>{DATA.title}:</strong> {DATA.description}
    </div>
</div>
<!-- END: result -->