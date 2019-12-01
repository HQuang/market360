<!-- BEGIN: main -->
<div class="title st2">
    <h2>{BLOCK_TITLE}</h2>
</div>
<div id="top_duan" class="owl-carousel owl-theme">
    <!-- BEGIN: loop -->
    <div class="item">
        <a href="{ROW.link}" title="{ROW.title}">
            <div class="image">
                <img src="{ROW.thumb}" alt="" width='496' height='270' class="img-responsive" />
            </div>
            <div class="desc_detail">
                <ul>
                    <!-- BEGIN: field -->
                    <li>{FIELD.title}: {FIELD.value}</li>
                    <!-- END: field -->
                </ul>
            </div>
            <div class="value">
                <div class="row d-flex align-items-center">
                    <div class="col-xs-24 col-sm-16">
                        <h3>{ROW.title}</h3>
                    </div>
                    <div class="col-xs-24 col-sm-8">
                        <span class="btn btn-sm btn-primary pull-right">Xem Ngay</span>
                    </div>
                </div>
            </div>
        </a>
    </div>
    <!-- END: loop -->
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('#top_duan').owlCarousel({
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
                    items : 2
                },
                480 : {
                    items : 2
                },
                768 : {
                    items : 2
                },
                1000 : {
                    items : 3
                }
            }
        });
    });
</script>
<!-- END: main -->