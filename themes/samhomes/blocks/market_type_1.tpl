<!-- BEGIN: main -->
<div class="nav-tabs-custom">
    <ul class="nav nav-tabs">
        <!-- BEGIN: group_title -->
        <li class="{active}"><a href="#tab_{STT}" data-toggle="tab">{GROUP_TITLE.title}</a></li>
        <!-- END: group_title -->
    </ul>
    <div class="tab-content data_content">
        <!-- BEGIN: group_content -->
        <div class="tab-pane {active}" id="tab_{STT}">
            <div class="row">
                <div class="house_listing owl-carousel owl-theme sale_type_1 owl-loaded owl-drag">
                    <!-- BEGIN: loop -->
                    <div class="item" itemtype="https://schema.org/House">
                        <div class="block-info">
                            <div class="header">
                                <div class="phone p-b10">
                                    <h3>
                                        <a href="{CAT.alias}"> {CAT.title}</a>
                                    </h3>
                                </div>
                                <div class="title p-b10">
                                    <h3 class="line2">
                                        <a href="{ROW.link}">{ROW.title}</a>
                                    </h3>
                                </div>
                                <div class="price-list-alert p-b10">
                                    <p class="p-b10">
                                        Giá: <span class="alert-price">{ROW.price}</span>
                                    </p>
                                </div>
                            </div>
                            <div class="footer p-b10">
                                <a href="{ROW.link}">Xem chi tiết ...</a> <span class="date pull-right"><i class="fa fa-clock-o"></i> {ROW.addtime}</span>
                            </div>
                        </div>
                    </div>
                    <!-- END: loop -->
                </div>
                <div class="col-sm-24 text-right view-more no-padding hidden-xs">
                    <a href="{CAT.alias}">Xem thêm</a>
                </div>
            </div>
        </div>
        <!-- END: group_content -->
    </div>
</div>
<script>$(document).ready(function(){$(".sale_type_1").owlCarousel({loop:!1,nav:!0,autoplay:!0,dots:!1,autoplayTimeout:35e3,animateOut:"fadeOut",autoHeight:!0,navText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],responsive:{0:{autoWidth:!0},480:{items:2},768:{items:3},1200:{items:4}}})}),$(".carousel-inner .carousel-item").first().addClass("active");</script>
<!-- END: main -->
