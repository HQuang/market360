<!-- BEGIN: main -->
<!-- BEGIN: loop -->
<div class="item" itemtype="https://schema.org/House">
    <a itemprop="url" href="{ROW.link}" title="{ROW.title}">
        <div class="image">
            <img src="{ROW.thumb}" alt="{ROW.thumbalt}" width='320' height='240' />
            <!-- BEGIN: count_image -->
            <div class="photo">{ROW.count_image}</div>
            <!-- END: count_image -->
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
            <div class="saved saved_176667 hidden-xs">
                <button type="button" onclick="nv_save_rows({ROW.id}, 'add', {ROW.is_user}); return !1;" {ROW.style_save}  class="save_button_{ROW.id}">
                    <i class="fa fa-heart-o">&nbsp;</i>
                </button>
                <button type="button" onclick="nv_save_rows({ROW.id}, 'remove', {ROW.is_user}); return !1;" {ROW.style_saved}  class="saved_button_{ROW.id}">
                    <i class="fa fa-minus-circle">&nbsp;</i>
                </button>
            </div>
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
<script>
var LANG = [];
LANG.error_save_login = '{LANG.error_save_login}';
LANG.auction_register_confirm = '{LANG.auction_register_confirm}';
LANG.auction_cancel = '{LANG.auction_cancel}';
LANG.auction_register_success = '{LANG.auction_register_success}';
LANG.auction_cancel_succes = '{LANG.auction_cancel_succes}';
LANG.auction_cancel_confirm = '{LANG.auction_cancel_confirm}';
</script>
<!-- END: main -->