
<!-- BEGIN: lt_ie9 -->
<p class="chromeframe">{LANG.chromeframe}</p>
<!-- END: lt_ie9 -->
<div id="timeoutsess" class="chromeframe">
    {LANG.timeoutsess_nouser}, <a onclick="timeoutsesscancel();" href="#">{LANG.timeoutsess_click}</a>. {LANG.timeoutsess_timeout}: <span id="secField"> 60 </span> {LANG.sec}
</div>
<div id="openidResult" class="nv-alert" style="display: none"></div>
<div id="openidBt" data-result="" data-redirect=""></div>
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/bootstrap.min.js"></script>
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/360/jquery.plugins.js"></script>
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/360/client.js"></script>
<script>$(document).ready(function() {
        $("#news_updated ul.dropdown-menu li a").on("click",function(){var t=$(this).text(),a=$(this).attr("data-url");if($(this).parent().parent().prev().html(t+' <b class="caret">'),void 0!==a){var i=$(this);$(this.hash).load(a,function(t){return i.tab("show"),!1})}});
        initHomepage();        
        $("#popup_sildeup1").owlCarousel({nav:!1,dots:!1,autoHeight:!1,autoplay:!0,autoplayTimeout:3e3,loop:!0,singleItem:!0,items:1}),$("#toggle-product .affix").on("click",function(){$("#popup_slideup").slideToggle("slow")});        
    });</script>
</body>
</html>