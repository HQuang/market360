<!-- BEGIN: main -->
<script src="https://cdn.firebase.com/js/client/2.4.2/firebase.js"></script>
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/simply-toast/simply-toast.min.css" />
<script src="{NV_BASE_SITEURL}themes/{TEMPLATE}/js/simply-toast/simply-toast.min.js"></script>
<script>
	var myFirebaseRef = new Firebase("https://mynukeviet-98d98.firebaseio.com/messenger-notify");
	var newItems = false;
	var title = $('title').text();
	var count = $('#notification-number').val();
	count = Number(count);
	
	myFirebaseRef.on("child_added", function(snapshot) {
		if (!newItems) return;
		var message = snapshot.val();
		var userid = {USERID};
		var feedback = message.feedback;
		if($.inArray(String(userid), feedback) > -1 && message.poster_id != userid){
			var html = '';
			var content = '<strong>' + message.poster_name + '</strong> đã bình luận trong chủ đề <a href="' + message.url + '"><strong>' + message.title + '</strong></a>';
			html += '<li class="item view" onclick="nv_viewitem($(this));" data-item-id="' + message.notifyid + '" data-item-url="' + message.url + '" data-view="0" data-item-module="hoat-dong">';
			html += '	<div class="row">';
			html += '		<div class="col-xs-3">';
			html += '			<img src="/themes/default/images/users/no_avatar.png" alt="" class="img-thumbnail" style="background: #dddddd">';
			html += '		</div>';
			html += '		<div class="col-xs-21">';
			html += '			<p>';
			html += '				<span class="show">' + content + '</span>';
			html += '				<abbr class="timeago" title="2016-07-25T19:20:02+0700">' + message.addtime + '</abbr>';
			html += '			</p>';
			html += '		</div>';
			html += '	</div>';
			html += '</li>';
			
			$.extend(true, $.simplyToast.defaultOptions,
			{
				delay: 6000,
				align: 'left',
				offset: {
					from: "bottom"
				}
			});
			$.simplyToast(content);

			count = count + 1;
			$('#notification-number').html(count);
			document.title = '(' + count + ') ' + title;
			$('.notification-list').prepend(html);
		}
	});
	
	myFirebaseRef.once('value', function(messages) {
		newItems = true;
	});
</script>
<!-- END: main -->