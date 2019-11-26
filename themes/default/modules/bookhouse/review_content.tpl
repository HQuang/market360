<!-- BEGIN: main -->
<script src='https://www.google.com/recaptcha/api.js'></script>
<div class="panel panel-default">
    <div class="panel-body">
        <div class="row form-review">
            <div class="col-xs-24 col-sm-11 border border-right">
                <form id="review_form">
                    <div class="form-group">
                        <input type="text" class="form-control" name="sender" value="{SENDER}" placeholder="{LANG.profile_user_name}">
                    </div>
                    <div class="form-group">
                        <div class="rate-ex2-cnt">
                            <div id="1" class="rate-btn-1 rate-btn"></div>
                            <div id="2" class="rate-btn-2 rate-btn"></div>
                            <div id="3" class="rate-btn-3 rate-btn"></div>
                            <div id="4" class="rate-btn-4 rate-btn"></div>
                            <div id="5" class="rate-btn-5 rate-btn"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <textarea name="comment" class="form-control" placeholder="{LANG.rate_comment}"></textarea>
                    </div>
                    <!-- BEGIN: recaptcha -->
                    <div class="form-group">
                        <div class="middle text-center clearfix">
                            <div class="nv-recaptcha-default">
                                <div id="{RECAPTCHA_ELEMENT}"></div>
                            </div>
                            <script type="text/javascript">
                                 nv_recaptcha_elements.push({
                                    id: "{RECAPTCHA_ELEMENT}",
                                    btn: $('[type="submit"]', $('#{RECAPTCHA_ELEMENT}').parent().parent().parent().parent())
                                })
                               
                            </script>
                        </div>
                    </div>
                    <!-- END: recaptcha -->
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary" value="{LANG.rate}" />
                    </div>
                </form>
            </div>
            <div class="col-xs-24 col-sm-13 border">
                <div id="rate_list">
                    <p class="text-center">
                        <em class="fa fa-spinner fa-spin fa-3x">&nbsp;</em>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" data-show="after">
	$("#rate_list").load('{LINK_REVIEW}&showdata=1');
	var rating = 0;
	$('.rate-btn').hover(function() {
		$('.rate-btn').removeClass('rate-btn-hover');
		rating = $(this).attr('id');
		for (var i = rating; i >= 0; i--) {
			$('.rate-btn-' + i).addClass('rate-btn-hover');
		};
	});

	$('#review_form').submit(function() {
		var sender = $(this).find('input[name="sender"]').val();
		var comment = $(this).find('textarea[name="comment"]').val();
		var fcode = $(this).find('input[name="fcode"]').val();
		if(rating !=0) {
		    if(sender == '') {
			    $('input[name="sender"]').focus();
			}
			else if(fcode == '') {
			    $('input[name="fcode"]').focus();
			}
		}		
		
		$.ajax({
			type : "POST",
			url : '{LINK_REVIEW}' + '&nocache=' + new Date().getTime(),
			data : 'sender=' + sender + '&rating=' + rating + '&comment=' + comment + '&fcode=' + fcode,
			success : function(data) {
			
			var s = data.split('_');
				alert(s[1]);
				if (s[0] == 'OK') {
					$('#review_form input[name="sender"], #review_form input[name="fcode"], #review_form textarea').val('');
					$('.rate-btn').removeClass('rate-btn-hover');
					$("#rate_list").load('{LINK_REVIEW}&showdata=1');
				}
				change_captcha();
						
			}
		});		
		return !1;
	});
</script>
<!-- END: main -->