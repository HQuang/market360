/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 1 - 31 - 2010 5 : 12
 */

var map, ele, mapH, mapW, addEle, mapL, mapN, mapZ;

ele = 'maps_mapcanvas';
addEle = 'maps_address';
mapLat = 'maps_maplat';
mapLng = 'maps_maplng';
mapZ = 'maps_mapzoom';
mapArea = 'maps_maparea';
mapCenLat = 'maps_mapcenterlat';
mapCenLng = 'maps_mapcenterlng';
mapAppid = 'maps_appid';

// Call Google MAP API
if( ! document.getElementById('googleMapAPI') ){
	var s = document.createElement('script');
	s.type = 'text/javascript';
	s.id = 'googleMapAPI';
	s.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places&callback=controlMap&key=' + $("#" + mapAppid).val();
	document.body.appendChild(s);
}else{
	controlMap();
}

// Creat map and map tools
function initializeMap(){
	var zoom = parseInt($("#" + mapZ).val()), lat = parseFloat($("#" + mapLat).val()), lng = parseFloat($("#" + mapLng).val()), Clat = parseFloat($("#" + mapCenLat).val()), Clng = parseFloat($("#" + mapCenLng).val());
	Clat || (Clat = 20.984516000000013, $("#" + mapCenLat).val(Clat));
	Clng || (Clng = 105.79547500000001, $("#" + mapCenLng).val(Clng));
	lat || (lat = Clat, $("#" + mapLat).val(lat));
	lng || (lng = Clng, $("#" + mapLng).val(lng));
	zoom || (zoom = 17, $("#" + mapZ).val(zoom));

	mapW = $('#' + ele).innerWidth();
	mapH = mapW * 3 / 4;

	// Init MAP
	$('#' + ele).width(mapW).height(mapH > 500 ? 500 : mapH);
	map = new google.maps.Map(document.getElementById(ele),{
		zoom: zoom,
		center: {
			lat: Clat,
			lng: Clng
		}
	});

	// Init default marker
	var markers = [];
	markers[0] = new google.maps.Marker({
        map: map,
        position: new google.maps.LatLng(lat,lng),
        draggable: true,
        animation: google.maps.Animation.DROP
    });
    markerdragEvent(markers);

	// Init search box
	var searchBox = new google.maps.places.SearchBox(document.getElementById(addEle));

	google.maps.event.addListener(searchBox, 'places_changed', function(){
	    var places = searchBox.getPlaces();

	    if (places.length == 0) {
	        return;
	    }

	    for (var i = 0, marker; marker = markers[i]; i++) {
	        marker.setMap(null);
	    }

	    markers = [];
	    var bounds = new google.maps.LatLngBounds();
	    for (var i = 0, place; place = places[i]; i++) {
	        var marker = new google.maps.Marker({
		        map: map,
		        position: place.geometry.location,
		        draggable: true,
		        animation: google.maps.Animation.DROP
	        });

	        markers.push(marker);
	        bounds.extend(place.geometry.location);
	    }

        markerdragEvent(markers);
	    map.fitBounds(bounds);
		console.log( places );
	});

	// Add marker when click on map
	google.maps.event.addListener(map, 'click', function(e) {
	    for (var i = 0, marker; marker = markers[i]; i++) {
	        marker.setMap(null);
	    }

	    markers = [];
		markers[0] = new google.maps.Marker({
	        map: map,
	        position: new google.maps.LatLng(e.latLng.lat(), e.latLng.lng()),
	        draggable: true,
	        animation: google.maps.Animation.DROP
	    });

	    markerdragEvent(markers);
	});

	// Event on zoom map
	google.maps.event.addListener(map, 'zoom_changed', function() {
	    $("#" + mapZ).val(map.getZoom());
	});

	// Event on change center map
	google.maps.event.addListener(map, 'center_changed', function() {
	    $("#" + mapCenLat).val(map.getCenter().lat());
	    $("#" + mapCenLng).val(map.getCenter().lng());
	    console.log( map.getCenter() );
	});
}

// Show, hide map on select change
function controlMap(manual){
	$('#' + mapArea).slideDown(100, function(){
		initializeMap();
	});

	return !1;
}

// Map Marker drag event
function markerdragEvent(markers){
    for (var i = 0, marker; marker = markers[i]; i++) {
	    $("#" + mapLat).val(marker.position.lat());
	    $("#" + mapLng).val(marker.position.lng());

		google.maps.event.addListener(marker, 'drag', function(e) {
		    $("#" + mapLat).val(e.latLng.lat());
		    $("#" + mapLng).val(e.latLng.lng());
		});
    }
}