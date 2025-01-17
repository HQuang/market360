<!-- BEGIN: main -->
<div id="news_updated">
    <div class="row">
        <div class="col-sm-8 col-xs-18">
            <div class="title st2">
                <h2>{BLOCK_TITLE}</h2>
            </div>
        </div>
        <div class="col-sm-16 col-xs-6">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="tab-link"><a href="{BLOCK_LINK}">Xem thêm</a></li>
                    </ul>
                </div>
        </div>
    </div>
    <div class="row">
        <div class="tab-content data_content">
            <div class="tab-pane active" id="nha">
                <div class="house_listing small nopadding">
                    <!-- BEGIN: loop -->
                    <div class="col-sm-12">
                        <div class="item " itemtype="https://schema.org/House">
                            <a itemprop="url" href="{ROW.link}" title="{ROW.title}">
                                <div class="image">
                                    <div class="ribbon ribbon-top-right">
                                        <span>{BLOCKCAT.description}</span>
                                    </div>
                                    <img alt="{ROW.title}" width="320" height="240" src="{ROW.thumb}">
                                    <!-- BEGIN: count_image -->
                                    <div class="photo">{ROW.count_image}</div>
                                    <!-- END: count_image -->
                                </div>
                            </a>
                            <div class="block-info">
                                <div class="header header_group">
                                    <h3 class="line2">
                                        <a href="{ROW.link}">{ROW.title}</a>
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
                                    <div class="value">
                                        <ul>
                                            <!-- BEGIN: field -->
                                            <li>{FIELD.title}: {FIELD.value}</li>
                                            <!-- END: field -->
                                        </ul>
                                    </div>
                                </div>
                                <div class="footer">
                                    <span class="price">{ROW.price}</span> <span class="date pull-right"><i class="fa fa-clock-o"></i> {ROW.addtime_f}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: loop -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->