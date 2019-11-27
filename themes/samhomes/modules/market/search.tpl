<!-- BEGIN: main -->
<div class="search">
    <h1 class="hidden">{TITLE}</h1>
    <h3 class="title st1">{TITLE}</h3>
    <!-- BEGIN: result -->
    <div class="alert alert-info text-center">{LANG.search_result_number}</div>
    <!-- BEGIN: nomaps -->
    <div id="page_listing" class="m-t15"> <div class="house_listing view_new"> {DATA} </div> </div>
    <!-- END: nomaps -->
    <!-- BEGIN: maps -->
        <!-- BEGIN: maps_top -->
        <div class="col-xs-24">
            <div class="m-bottom" id="company-map" style="width: 100%; height: 500px"></div>
        </div>
        <div class="col-xs-24"><div id="page_listing" class="m-t15"> <div class="house_listing view_new"> {DATA} </div> </div></div>
        <!-- END: maps_top -->
        <!-- BEGIN: maps_right -->
        <div class="col-sm-14 col-xs-24"><div id="page_listing" > <div class="house_listing view_new"> {DATA} </div> </div></div>
        <div class="col-sm-10 col-xs-24">
            <div class="m-bottom" id="company-map" style="width: 100%; height: 500px"></div>
        </div>
        <!-- END: maps_right -->
        <!-- BEGIN: maps_bottom -->
        <div class="col-xs-24"><div id="page_listing"> <div class="house_listing view_new"> {DATA} </div> </div></div>
        <div class="col-xs-24">
            <div class="m-bottom" id="company-map" style="width: 100%; height: 500px"></div>
        </div>
        <!-- END: maps_bottom -->
        <!-- BEGIN: maps_left -->
        <div class="col-sm-10 col-xs-24">
            <div class="m-bottom" id="company-map" style="width: 100%; height: 500px"></div>
        </div>
        <div class="col-sm-14 col-xs-24"><div id="page_listing"> <div class="house_listing view_new"> {DATA} </div> </div></div>
        <!-- END: maps_left -->
    <!-- END: maps -->
    <!-- BEGIN: page -->
    <div class="text-center clear">{PAGE}</div>
    <!-- END: page -->
    <!-- END: result -->
    <!-- BEGIN: result_empty -->
    <div class="alert alert-info text-center">{LANG.search_result_empty}</div>
    <!-- END: result_empty -->
    <!-- BEGIN: empty -->
    <div class="alert alert-info text-center">{LANG.search_empty}</div>
    <!-- END: empty -->
</div>
<!-- BEGIN: maps -->
<script>
    if (!$('#googleMapAPI').length) {
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.id = 'googleMapAPI';
        script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&callback=initializeMap&key={ARRAY_CONFIG.maps_appid}';
        document.body.appendChild(script);
    } else {
        initializeMap();
    }
    
    function initializeMap() {
        var ele = 'company-map';
        var map;
        var obj = {JSON_OUT};
        map = new google.maps.Map(document.getElementById(ele), {
            zoom : 15,
            center : {
                lat : parseFloat(obj[0].lat),
                lng : parseFloat(obj[0].lng)
            }
        });
        
        for (var i = 0; i < obj.length; i++) {
            var object = obj[i];
            var marker = new google.maps.Marker({
              position: {lat: parseFloat(object.lat), lng: parseFloat(object.lng)},
              map: map,
              title: object.title
            });
        }
    }
</script>
<!-- END: maps -->
<!-- END: main -->