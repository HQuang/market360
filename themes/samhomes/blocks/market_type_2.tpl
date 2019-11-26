<!-- BEGIN: main -->
<div class="row">
    <div class="house_listing owl-carousel owl-theme sale_type_2 owl-loaded owl-drag">
        <!-- BEGIN: loop -->
        <div class="item" itemtype="https://schema.org/House">
            <div class="block-info">
                <div class="header">
                    <div class="phone">
                        <h3>
                            <a href="{TYPE_LINK}"> {TYPE_TITLE}</a>
                        </h3>
                    </div>
                    <div class="title">
                        <h3 class="line2">
                            <a href="{ROW.link}">{ROW.title}</a>
                        </h3>
                    </div>
                    <div class="price-list-alert pb-10">
                        <p>
                            Giá: <span class="alert-price">{ROW.price}</span>
                        </p>
                    </div>
                </div>
                <div class="footer">
                    <a href="{ROW.link}">Xem chi tiết ...</a> <span class="date pull-right"><i class="fa fa-clock-o"></i> {ROW.addtime}</span>
                </div>
            </div>
        </div>
        <!-- END: loop -->
    </div>
    <div class="col-sm-24 text-right view-more no-padding">
        <a href="{TYPE_LINK}">Xem thêm</a>
    </div>
</div>
<script>
    $(document).ready(function() {
        $('.sale_type_2').owlCarousel({
            loop : false,
            nav : true,
            autoplay : true,
            dots : false,
            autoplayTimeout : 35000,
            animateOut : 'fadeOut',
            autoHeight : true,
            navText : [ "<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>" ],
            responsive : {
                0 : {
                    autoWidth : true
                },
                480 : {
                    items : 2
                },
                768 : {
                    items : 3
                },
                1200 : {
                    items : 4
                }
            }
        });
    });
</script>
<!-- END: main -->