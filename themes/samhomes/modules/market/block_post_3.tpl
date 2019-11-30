<!-- BEGIN: main -->
<div class="row d-flex align-items-center">
    <div class="col-sm-20 col-xs-18">
        <div class="title st2 ">
            <h2 class="one-line">{BLOCK_TITLE}</h2>
        </div>
    </div>
    <div class="col-sm-4 col-xs-6">
        <a href="{BLOCK_LINK}" class="text-view-more">Xem thêm</a>
    </div>
</div>
<div class="row">
    <div id="hot_listing" class="house_listing nopadding">
        <!-- BEGIN: loop -->
        <div class="col-sm-24">
            <div class="item adshot" itemtype="https://schema.org/House">
                <a itemprop="url" href="{ROW.link}" title="{ROW.title}">
                    <div class="image">
                        <div class="ribbon ribbon-top-right">
                            <span>{BLOCKCAT.description}</span>
                        </div>
                        <img src="{ROW.thumb}" alt="{ROW.title}" width='320' height='240' />
                        <!-- BEGIN: count_image -->
                        <div class="photo">{ROW.count_image}</div>
                        <!-- END: count_image -->
                    </div>
                </a>
                <div class="block-info">
                    <div class="header header_group">
                        <h3 class="line2">
                            <a href="{ROW.link}" title="{ROW.title}">{ROW.title}</a>
                        </h3>
                        <p>
                            <a href="{ROW.location_link}">{ROW.location}</a>
                        </p>
                        <div class="saved saved_176667 hidden-xs">
                            <button type="button" onclick="nv_save_rows({ROW.id}, 'add', {ROW.is_user}); return !1;" {ROW.style_save} class="save_button_{ROW.id}">
                                <i class="fa fa-heart-o">&nbsp;</i>
                            </button>
                            <button type="button" onclick="nv_save_rows({ROW.id}, 'remove', {ROW.is_user}); return !1;" {ROW.style_saved} class="saved_button_{ROW.id}">
                                <i class="fa fa-minus-circle">&nbsp;</i>
                            </button>
                        </div>
                    </div>
                    <div class="body">
                        <p>{ROW.description}</p>
                        <div class="value">
                            <!-- BEGIN: field -->
                            <li>{FIELD.title}: {FIELD.value}</li>
                            <!-- END: field -->
                            <!--                             <ul> -->
                            <!--                                 <li><i class="fa fa-expand"></i> 40 m<sup>2</sup></li> -->
                            <!--                                 <li><i class="fa fa-bed"></i> <span itemprop="numberOfRooms">6</span></li> -->
                            <!--                                 <li><i class="fa fa-bath"></i> <span itemprop="numberOfRooms">6</span></li> -->
                            <!--                                 <li class="text-right"><i class="fa fa-location-arrow"></i> <a href="https://samhomes.vn/mua/nha-ha-noi-huong-dong-bac">Đông Bắc</a></li> -->
                            <!--                             </ul> -->
                        </div>
                    </div>
                    <div class="footer">
                        <span class="price">{ROW.price}</span> <span class="date pull-right"><i class="fa fa-clock-o"></i> {ROW.addtime_f}</span>
                    </div>
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
    </div>
</div>
<!-- END: main -->
<div class="viewlist">
    <!-- BEGIN: loop -->
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-24 col-sm-6 col-md-5">
                    <div class="image" style="width: {WIDTH">
                        <a href="{ROW.link}" title="{ROW.title}"><img src="{ROW.thumb}" alt="{ROW.thumbalt}" class="img-thumbnail img-responsive" /></a>
                    </div>
                </div>
                <div class="col-xs-24 col-sm-18 col-md-19">
                    <h2>
                        <a href="{ROW.link}" title="{ROW.title}">{ROW.title}</a>
                    </h2>
                    <!-- BEGIN: type -->
                    <span class="type">({ROW.type})</span>
                    <!-- END: type -->
                    <div class="row">
                        <div class="col-xs-24 col-sm-14 col-md-14">
                            <ul class="list-info">
                                <li><em class="fa fa-folder-open-o">&nbsp;</em><a href="{ROW.cat_link}" title="{ROW.cat}">{ROW.cat}</a></li>
                                <!-- BEGIN: location -->
                                <li><em class="fa fa-map-marker">&nbsp;</em>{ROW.location}</li>
                                <!-- END: location -->
                                <!-- BEGIN: auction -->
                                <li><em class="fa fa-gavel text-success">&nbsp;</em>{LANG.auction}</li>
                                <!-- END: auction -->
                                <!-- BEGIN: field -->
                                <li>{FIELD.title}: {FIELD.value}</li>
                                <!-- END: field -->
                            </ul>
                        </div>
                        <div class="col-xs-24 col-sm-10 col-md-10 text-right">
                            <ul>
                                <li><em class="fa fa-clock-o">&nbsp;</em>{ROW.addtime}</li>
                                <li><span class="money">{ROW.price}</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END: loop -->
</div>