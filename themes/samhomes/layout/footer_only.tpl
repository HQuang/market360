    	<!-- BEGIN: lt_ie9 --><p class="chromeframe">{LANG.chromeframe}</p><!-- END: lt_ie9 -->
        <div id="timeoutsess" class="chromeframe">
            {LANG.timeoutsess_nouser}, <a onclick="timeoutsesscancel();" href="#">{LANG.timeoutsess_click}</a>. {LANG.timeoutsess_timeout}: <span id="secField"> 60 </span> {LANG.sec}
        </div>
        <div id="openidResult" class="nv-alert" style="display:none"></div>
        <div id="openidBt" data-result="" data-redirect=""></div>
        <script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/bootstrap.min.js"></script>
        <script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/360/jquery.plugins.js"></script>
        <script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/360/client.js"></script>
        <script>
    $(document).ready(function() {

        
        $('#news_updated ul.dropdown-menu li a').on('click', function() {
            var text = $(this).text();
            var url = $(this).attr("data-url");
            var tab = $(this);
            tab.parent().parent().prev().html(text + ' <b class="caret">');
            if (typeof url !== "undefined") {
                var pane = $(this);
                var $div_content = $(this.hash);
                $div_content.load(url, function(result) {
                    pane.tab('show');
                    return false;
                });
            }
        });
        initHomepage();
        


    });
</script>
	</body>
</html>