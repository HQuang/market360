<!-- BEGIN: main -->
<!-- BEGIN: loop -->
<div class="item  col-xs-24 no-padding" itemtype="https://schema.org/House">
    <a itemprop="url" href="{ROW.link}" title="{ROW.title}">
        <div class="image">
            <div class="ribbon ribbon-top-right">
                <span>VIP</span>
            </div>
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
            <div class="saved saved_176667 hidden-xs">
                <button type="button" onclick="nv_save_rows({ROW.id}, 'add', {ROW.is_user}); return !1;" {ROW.style_save}>
                    <i class="fa fa-heart-o">&nbsp;</i>
                </button>
                <button type="button" onclick="nv_save_rows({ROW.id}, 'remove', {ROW.is_user}); return !1;" {ROW.style_saved}>
                    <i class="fa fa-minus-circle">&nbsp;</i>
                </button>
            </div>
        </div>
        <div class="body">
            <p>{ROW.description}</p>
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
<!-- BEGIN: block -->
{BLOCK}
<!-- END: block -->
<!-- END: loop -->
<!-- BEGIN: page -->
<div class="text-center clear">{PAGE}</div>
<!-- END: page -->
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