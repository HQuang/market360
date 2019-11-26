<!-- BEGIN: main -->
<div class="upgrade">
    <!-- BEGIN: rowinfo -->
    <ul class="list-info">
        <li><label>{LANG.title}:</label> {DATA.title}</li>
        <li><label>{LANG.cat}:</label> {DATA.cat}</li>
    </ul>
    <!-- END: rowinfo -->
    {CONTENT}
</div>
<script>
    $(document).ready(function () {
        $('a.btn-upgrade').click(function () {
            nv_upgrade_group('{MOD}', $(this).attr('id'), {DATA.id}, $(this).attr('title'));
        });
    });
</script>
<!-- END: main -->