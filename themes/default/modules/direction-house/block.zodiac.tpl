<!-- BEGIN: main -->
<form id="zodiac-frm-submit" class="text-center form-inline">
    <label>{LANG.birthday}</label>
    <div class="form-group m-bottom">
        <select class="form-control" name="day">
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
<script>
    $('#zodiac-frm-submit').submit(function(e) {
        e.preventDefault();
        $.ajax({
            type : 'POST',
            url : '{URL}&nocache=' + new Date().getTime(),
            data : $(this).serialize(),
            success : function(html) {
                modalShow('', html)
            }
        });
    });
</script>
<!-- END: main -->