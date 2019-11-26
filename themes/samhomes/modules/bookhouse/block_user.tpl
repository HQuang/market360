<!-- BEGIN: main -->
<div class="block_user">
    <ul>
        <!-- BEGIN: refresh -->
        <!-- BEGIN: refresh_free -->
        <li><label>{LANG.refresh_free}:</label> {DATA.refresh_free}</li>
        <!-- END: refresh_free -->
        <li><label>{LANG.refresh}:</label> {DATA.refresh} <!-- BEGIN: buy_refresh -->(<a href="javascript:void(0);" onclick="nv_buy_refresh(0, '{MODULE_NAME}');">{LANG.buy_refresh}</a>)<!-- END: buy_refresh --></li>
        <!-- END: refresh -->
        <li><label>{LANG.rowactived}:</label> {DATA.actived}</li>
        <li><label>{LANG.queue_rows}:</label> {DATA.queue}</li>
        <li><label>{LANG.queue_decline_rows}:</label> {DATA.decline}</li>
    </ul>
    <hr />
    <div class="text-center">
        <a href="{ADD_URL}" class="btn btn-success">{LANG.items_add}</a>
    </div>
</div>
<!-- END: main -->