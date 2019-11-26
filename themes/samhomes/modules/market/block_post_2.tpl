<!-- BEGIN: main -->
<div class="row d-flex align-items-center">
    <div class="col-xs-24 col-sm-20">
        <div class="title st2">
            <h2>{BLOCK_TITLE}</h2>
        </div>
    </div>
    <div class="col-sm-4">
        <a href="{BLOCK_LINK}" class="text-view-more hidden-xs">Xem thêm</a>
    </div>
</div>
<div class="row">
    <div id="top_listing" class="house_listing owl-carousel owl-theme">
        <!-- BEGIN: loop -->
        <div class="item " itemtype="https://schema.org/House">
            <a itemprop="url" href="{ROW.link}">
                <div class="image">
                    <div class="ribbon ribbon-top-right">
                        <span>VIP</span>
                    </div>
                    <img src="{ROW.thumb}" alt="{ROW.title}" width='320' height='240' />
                    <div class="photo">6</div>
                </div>
            </a>
            <div class="block-info">
                <div class="header">
                    <h3 class="line2">
                        <a href="{ROW.link}">{ROW.title}</a>
                    </h3>
                    <p>
                        <a href="{ROW.location_link}">{ROW.location}</a>
                    </p>
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
    <div class="col-sm-12 text-right view-more no-padding visible-xs">
        <a href="{BLOCK_LINK}">Xem thêm</a>
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
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/owlcarousel/assets/owl.carousel.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/owlcarousel/assets/owl.theme.default.min.css">
<div class="block-articles">
    <ul class="list-unstyled qc_doitac  owl-carousel">
        <!-- BEGIN: loop -->
        <li class="item">
            <div class="entry">
                <a href="{ROW.link}"> <img src="{ROW.thumb}" data-src="{ROW.thumb}" alt="{ROW.title}"></a>
                <div class="summary">
                    <a href="{ROW.link}" title="{ROW.title}"><div class="title">{ROW.title}</div></a>
                    <div class="price">{LANG.price}: {ROW.price}</div>
                    <div class="location">{ROW.location}</div>
                    <div class="location">{ROW.addtime}</div>
                </div>
            </div>
        </li>
        <!-- END: loop -->
    </ul>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('.qc_doitac').owlCarousel({
            loop : true,
            margin : 10,
            navText : [ '<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>' ],
            responsive : {
                0 : {
                    items : 1
                },
                600 : {
                    items : 3
                },
                1000 : {
                    items : 4
                }
            }
        })
        $('.owl-carousel').find('.owl-nav').removeClass('disabled');
        $('.owl-carousel').on('changed.owl.carousel', function(event) {
            $(this).find('.owl-nav').removeClass('disabled');
        });
    });
    $(".qc_doitac-inner .item:first").addClass("active");
</script>
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/owlcarousel/owl.carousel.min.js"></script>