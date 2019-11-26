<!-- BEGIN: main -->
<div id="banner_slider" class="owl-carousel carousel_banner">
    <!-- BEGIN: loop -->
    <div class="item">
        <img src="{ROW.image}">
        <div class="container">
            <div class="text">
                <h2 class="hidden-xs">
                    {ROW.title}
                </h2>
                <p class="hidden-xs">{ROW.description}</p>
            </div>
        </div>
    </div>
    <!-- END: loop -->
</div>
 <script>
                    $(document).ready(function() {
                        $('.carousel_banner').owlCarousel({
                            loop : true,
                            margin : 10,
                            dots: false,
                            smartSpeed:450,
                            responsiveClass: true,
                            autoplayHoverPause: true,
                            navText : [ '<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>' ],
                            responsive : {
                                0 : {
                                    items : 1
                                },
                                600 : {
                                    items : 1
                                },
                                1000 : {
                                    items : 1 
                                }
                            }
                        })
                    });
                </script>
<!-- END: main -->