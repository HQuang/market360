<!-- BEGIN: main -->
<div class="row d-flex align-items-center">
    <div class="col-sm-20 col-xs-18">
        <div class="title st2">
            <h2 class="one-line">{BLOCK_TITLE}</h2>
        </div>
    </div>
    <div class="col-sm-4 col-xs-6">
        <a href="{BLOCK_LINK}" class="text-view-more">Xem thêm</a>
    </div>
</div>
<div class="row">
    <div id="top_listing" class="house_listing owl-carousel owl-theme">
        <!-- BEGIN: loop -->
        <div class="item " itemtype="https://schema.org/House">
            <a itemprop="url" href="{ROW.link}">
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
                    <p>{ROW.description}</p>
                    <div class="value">
                        <ul>
                            <!-- BEGIN: field -->
                            <li>{FIELD.title}: {FIELD.value}</li>
                            <!-- END: field -->
                            <!--                             <li><i class="fa fa-expand"></i> 60 m<sup>2</sup></li> -->
                            <!--                             <li><i class="fa fa-bed"></i> <span itemprop="numberOfRooms">5</span></li> -->
                            <!--                             <li><i class="fa fa-bath"></i> <span itemprop="numberOfRooms">6</span></li> -->
                        </ul>
                    </div>
                </div>
                <div class="footer">
                    <span class="price">{ROW.price}</span>
                    <!--                      <span class="unit">Tỷ</span> -->
                </div>
            </div>
        </div>
        <!-- END: loop -->
    </div>
</div>
<script>
    $(document).ready(function() {
        $('#top_listing').owlCarousel({
            loop : false,
            nav : true,
            autoplay : true,
            dots : false,
            autoplayTimeout : 2000,
            animateOut : 'fadeOut',
            autoHeight : true,
            navText : [ "<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>" ],
            responsive : {
                0 : {
                    items : 2
                },
                480 : {
                    items : 2
                },
                768 : {
                    items : 3
                },
                1200 : {
                    items : 5
                }
            }
        });
    });
</script>
<!-- END: main -->