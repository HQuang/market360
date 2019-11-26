<!-- BEGIN: main -->
<form id="directtion-frm-submit" class="text-center">
    <div class="form-group">
        <label>{LANG.birthday_select}</label> &nbsp;&nbsp;<select class="form-control" name="year">
            <!-- BEGIN: year -->
            <option value="{YEAR.index}"{YEAR.selected}>{YEAR.index}</option>
            <!-- END: year -->
        </select>
    </div>
    <div class="form-group">
        <!-- BEGIN: gender -->
        <label><input type="radio" name="gender" value="{GENDER.index}" {GENDER.checked} />{GENDER.value}&nbsp;&nbsp;&nbsp;</label>
        <!-- END: gender -->
    </div>
    <input type="hidden" name="view" value="1" />
    <button type="submit" class="btn btn-primary">{LANG.view}</button>
</form>
<script>
    $('#directtion-frm-submit').submit(function(e) {
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