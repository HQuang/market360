<!-- BEGIN: main -->
<div id="detail">
    <h1>{DATA.title}</h1>
    <ul class="list-info list-inline text-muted">
        <li><label>{LANG.addtime}:</label> {DATA.addtime}</li>
        <li><label>{LANG.viewcount}:</label> {DATA.hitstotal}</li>
        <li><label>{LANG.useradd}:</label> {DATA.useradd}</li>
    </ul>
    <hr />
    <!-- BEGIN: image -->
    <!-- You can move inline styles to css file or css block. -->
    <div id="slider2_container" style="position: relative; top: 0px; left: 0px; width: 600px; height: 300px; overflow: hidden;">
        <!-- Loading Screen -->
        <div u="loading" style="position: absolute; top: 0px; left: 0px;">
            <div style="filter: alpha(opacity = 70); opacity: 0.7; position: absolute; display: block; background-color: #000000; top: 0px; left: 0px; width: 100%; height: 100%;"></div>
            <div class="loading">&nbsp;</div>
        </div>
        <!-- Slides Container -->
        <div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 600px; height: 300px; overflow: hidden;">
            <!-- BEGIN: loop -->
            <div>
                <img u="image" src="{IMAGE}" /> <img u="thumb" src="{IMAGE}" />
            </div>
            <!-- END: loop -->
        </div>
        <!-- Arrow Left -->
        <span u="arrowleft" class="jssora02l" style="width: 55px; height: 55px; top: 123px; left: 8px;"> </span>
        <!-- Arrow Right -->
        <span u="arrowright" class="jssora02r" style="width: 55px; height: 55px; top: 123px; right: 8px"> </span>
        <!-- Arrow Navigator Skin End -->
        <!-- ThumbnailNavigator Skin Begin -->
        <div u="thumbnavigator" class="jssort03" style="position: absolute; width: 600px; height: 60px; left: 0px; bottom: 0px;">
            <div style="background-color: #000; filter: alpha(opacity = 30); opacity: .3; width: 100%; height: 100%;"></div>
            <div u="slides" style="cursor: move;">
                <div u="prototype" class="p" style="POSITION: absolute; WIDTH: 62px; HEIGHT: 32px; TOP: 0; LEFT: 0;">
                    <div class=w>
                        <ThumbnailTemplate style=" WIDTH: 100%; HEIGHT: 100%; border: none;position:absolute; TOP: 0; LEFT: 0;"></ThumbnailTemplate>
                    </div>
                    <div class=c style="POSITION: absolute; BACKGROUND-COLOR: #000; TOP: 0; LEFT: 0"></div>
                </div>
            </div>
            <!-- Thumbnail Item Skin End -->
        </div>
        <!-- ThumbnailNavigator Skin End -->
    </div>
    <!-- END: image -->
    <!-- BEGIN: adminlink -->
    <div class="text-center" style="margin-top: 15px">
        <em class="fa fa-edit">&nbsp;</em><a href="{EDIT_URL}" title="{GLANG.edit}">{GLANG.edit}</a> - <em class="fa fa-trash-o">&nbsp;</em><a href="{EDIT_URL}" title="{GLANG.delete}">{GLANG.delete}</a>
    </div>
    <!-- END: adminlink -->
    <div class="detail_bar">
        <span><strong>{LANG.detail_info}</strong></span>
    </div>
    <ul class="item-list-info"> <!-- BEGIN: code -->
        <li><label>{LANG.code}</label>: {DATA.code}</li> <!-- END: code -->
        <li><label>{LANG.category}</label>: <a href="{DATA.cat_link}" title="{DATA.cat_title}"> {DATA.cat_title}</a></li> <!-- BEGIN: address -->
        <li><label>{LANG.address}</label>: <a href="{DATA.location_link}" title="{ADDRESS}"> {ADDRESS}</a></li> <!-- END: address --> <!-- BEGIN: area -->
        <li><label>{LANG.area}</label>: {DATA.area} m<sup>2</sup></li> <!-- END: area --> <!-- BEGIN: size -->
        <li><label>{LANG.size}</label>: {DATA.size_h} x {DATA.size_v} {LANG.met}</li> <!-- END: size --> <!-- BEGIN: room -->
        <li><label>{LANG.room_num}</label> <!-- BEGIN: loop --> {ROOM.title} <span class="label label-danger">{ROOM.num}</span> <!-- END: loop --></li> <!-- END: room -->
        <!-- BEGIN: project -->
        <li><label>{LANG.project}</label>: <a target="_blank" href="{DATA.project.link}" title="{DATA.project.title}">{DATA.project.title}</a></li>
        <!-- END: project -->
        <!-- BEGIN: way -->
        <li><label>{LANG.way}</label>: {DATA.way}</li>
        <!-- END: way -->
        <!-- BEGIN: legal -->
        <li><label>{LANG.legal}</label>: {DATA.legal}</li>
        <!-- END: legal -->
        <!-- BEGIN: field -->
        <li><label>{FIELD.title}</label>: {FIELD.value}</li>
        <!-- END: field -->
        <li><label>{LANG.price}</label>: <span class="price_bookhouse"> <!-- BEGIN: price -->{DATA.price}<!-- END: price --> <!-- BEGIN: contact -->{LANG.contact}<!-- END: contact --></span></li>
    </ul>
    <!-- BEGIN: contact_info -->
    <div class="panel panel-default">
        <div class="panel-heading">{LANG.contact_info}</div>
        <div class="panel-body">
            <ul class="list-contact-info">
                <li><label><em class="fa fa-user">&nbsp;</em>{LANG.contact_fullname}:</label> {DATA.contact_fullname}</li>
                <li><label><em class="fa fa-envelope-o">&nbsp;</em>Email:</label> <a href="mailto:{DATA.contact_email}">{DATA.contact_email}</a></li>
                <li><label><em class="fa fa-phone">&nbsp;</em>{LANG.contact_phone}:</label> {DATA.contact_phone}</li>
                <li><label><em class="fa fa-map-pin">&nbsp;</em>{LANG.contact_address}:</label> {DATA.contact_address}</li>
            </ul>
        </div>
    </div>
    <!-- END: contact_info -->
    <div class="panel panel-default socialbutton">
        <div class="panel-body">
            <ul class="pull-left" style="padding: 0" class="list-inline">
                <li class="pull-left"><div class="fb-like" data-href="{SELFURL}" data-layout="button_count" data-action="like" data-show-faces="false" data-share="true">&nbsp;</div></li>
                <li class="pull-left"><div class="g-plusone" data-size="medium"></div></li>
                <li class="pull-left"><a href="http://twitter.com/share" class="twitter-share-button">Tweet</a></li>
            </ul>
            <!-- BEGIN: save -->
            <div class="pull-right" id="btn-save">
                <label id="save"{DATA.style_save}><em class="fa fa-floppy-o fa-lg text-success">&nbsp;</em><a href="javascript:void(0)" onclick="nv_save_rows({DATA.id}, 'add', {DATA.is_user}); return !1;" title="{LANG.save}">{LANG.item_save}</a></label> <label id="saved"{DATA.style_saved}><em class="fa fa-minus-circle fa-lg text-danger">&nbsp;</em><a href="javascript:void(0)" onclick="nv_save_rows({DATA.id}, 'remove', {DATA.is_user}); return !1;" title="{LANG.save_remove}">{LANG.item_save_remove}</a></label>
            </div>
            <!-- END: save -->
        </div>
    </div>
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#bodytext" aria-controls="bodytext" role="tab" data-toggle="tab">{LANG.detail}</a></li>
        <!-- BEGIN: comment_title -->
        <li role="presentation"><a href="#comment" aria-controls="comment" role="tab" data-toggle="tab">{LANG.comment}</a></li>
        <!-- END: comment_title -->
        <li role="presentation"><a href="#rate" aria-controls="rate" role="tab" data-toggle="tab">{LANG.rate}</a></li>
        <!-- BEGIN: google_maps_title -->
        <li role="presentation"><a href="#maps" aria-controls="maps" role="tab" data-toggle="tab">{LANG.maps}</a></li>
        <!-- END: google_maps_title -->
    </ul>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="bodytext">
           {DATA.bodytext}
        </div>
        <div role="tabpanel" class="tab-pane" id="comment">
            <!-- BEGIN: comment_content -->
            {COMMENT}
            <!-- END: comment_content -->
        </div>
        <div role="tabpanel" class="tab-pane fade" id="rate">
            <!-- BEGIN: rate -->
            {RATE}
            <!-- END: rate -->
        </div>
        <!-- BEGIN: google_maps_div -->
        <div role="tabpanel" class="tab-pane" id="maps">
            <script>
			if (!$('#googleMapAPI').length) {
				var script = document.createElement('script');
				script.type = 'text/javascript';
				script.id = 'googleMapAPI';
				script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&callback=initializeMap&key={MAPS.maps_appid}';
				document.body.appendChild(script);
			} else {
				initializeMap();
			}
		
			function initializeMap() {
				var ele = 'company-map';
				var map, marker, ca, cf, a, f, z;
				ca = parseFloat($('#' + ele).data('clat'));
				cf = parseFloat($('#' + ele).data('clng'));
				a = parseFloat($('#' + ele).data('lat'));
				f = parseFloat($('#' + ele).data('lng'));
				z = parseInt($('#' + ele).data('zoom'));
				map = new google.maps.Map(document.getElementById(ele), {
					zoom: z,
					center: {
						lat: ca,
						lng: cf
					}
				});
				marker = new google.maps.Marker({
					map: map,
					position: new google.maps.LatLng(a, f),
					draggable: false,
					animation: google.maps.Animation.DROP
				});
			}
			</script>
            <div class="m-bottom" id="company-map" style="width: 100%; height: 300px" data-clat="{MAPS.maps_mapcenterlat}" data-clng="{MAPS.maps_mapcenterlng}" data-lat="{MAPS.maps_maplat}" data-lng="{MAPS.maps_maplng}" data-zoom="{MAPS.maps_mapzoom}"></div>
        </div>
        <!-- END: google_maps_div -->
    </div>
    <!-- BEGIN: keywords -->
    <div class="well">
        <em class="fa fa-tags">&nbsp;</em><strong>{LANG.keywords}: </strong>
        <!-- BEGIN: loop -->
        <a title="{KEYWORD}" href="{LINK_KEYWORDS}"><em class="label label-primary">{KEYWORD}</em></a>
        <!-- END: loop -->
    </div>
    <!-- END: keywords -->
    <!-- BEGIN: other -->
    <div class="detail_bar">
        <span><strong>{LANG.other}</strong></span>
    </div>
    {OTHER}
    <!-- END: other -->
</div>
<script type="text/javascript">
var LANG = [];
LANG.error_save_login = '{LANG.error_save_login}';

$(document).ready(function(e) {
	$('#rent_info').hide();

    $("#form-rent").submit(function() {
    	var form_data = $("#form-rent").serialize();
    	$('#waiting').html( '<p class="text-center"><em class="fa fa-spinner fa-spin fa-4x">&nbsp;</em><br />{LANG.waiting}</p>' );
    	$('#rent_info').hide();
    	$.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=rent&nocache=' + new Date().getTime(), form_data, function(res) {
    		var r_split = res.split('_');
    		if( r_split[0] == 'OK' )
    		{
    			$('#waiting').html('');
    			$('#rent_info').show();
    			$('#rent_info').html( '<div class="alert alert-info text-center">{LANG.rent_success}</div>' );
    		}
    		else
    		{
    			alert( r_split[1] );
    			$('#rent_info').show();
    			$('#waiting').html('');
    			nv_change_captcha('vimg','fcode_iavim');
    		}
    	});
        return false;
    });

    $('#rent_button').click(function() {
        $('#rent_info').slideDown();
        $('#rent_button').hide();
        $('html, body').animate({
            scrollTop: $('#rent_info').offset().top + 'px'
        }, {
            duration: 500,
            easing: 'swing'
        });
        return false;
    });

    $('.btn-close').click(function() {
        $('#rent_button').show();
        $('#rent_info').slideUp();
    });

    //Change hash for page-reload
    $('.nav-tabs a').on('shown.bs.tab', function(e) {
//         window.location.hash = e.target.hash;
    })

    //Javascript to enable link to tab
    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
    } 
});
 </script>
<!-- END: main -->