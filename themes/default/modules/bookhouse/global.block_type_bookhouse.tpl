<!-- BEGIN: main -->
<!-- BEGIN: vertical -->
<ul class="listnews">
    <!-- BEGIN: newloop -->
    <li class="clearfix">
        <!-- BEGIN: imgblock --> <a title="{blocknew_items.title}" href="{blocknew_items.link}"><img src="{blocknew_items.imgurl}" alt="{blocknew_items.title}" width="70px" class="img-thumbnail pull-left" /></a> <!-- END: imgblock --> <a href="{blocknew_items.link}" title="{blocknew_items.title}" style="color: {blocknew_items.color">{blocknew_items.title}</a>
    </li>
    <!-- END: newloop -->
</ul>
<!-- END: vertical -->
<!-- BEGIN: list -->
<div class="block_new_items_list">
    <!-- BEGIN: newloop -->
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="image pull-left" style="width: {THUMB_WIDTH">
                <a title="{blocknew_items.title}" href="{blocknew_items.link}"> <img src="{blocknew_items.imgurl}" alt="{blocknew_items.title}" width="{THUMB_WIDTH}" class="img-thumbnail" />
                </a>
            </div>
            <div class="item-detail">
                <ul>
                    <li><h2>
                            <a title="{blocknew_items.title}" href="{blocknew_items.link}" style="color: {blocknew_items.color">{blocknew_items.title}</a>
                        </h2></li>
                    <li><label><em class="fa fa-tag">&nbsp;</em>{LANG.price}:</label> {blocknew_items.price}</li>
                    <!-- BEGIN: area -->
                    <li><label><em class="fa fa-area-chart">&nbsp;</em>{LANG.area}:</label> <!-- BEGIN: acreage --> {blocknew_items.area} m<sup>2</sup> <!-- END: acreage --> <!-- BEGIN: size --> {blocknew_items.size_h} x {blocknew_items.size_v} m <!-- END: size --></li>
                    <!-- END: area -->
                    <li><label><em class="fa fa-map-marker">&nbsp;</em>{LANG.items_location}:</label> {blocknew_items.location}</li>
                </ul>
            </div>
        </div>
    </div>
    <!-- END: newloop -->
</div>
<!-- END: list -->
<!-- BEGIN: gridview -->
<div class="row">
    <!-- BEGIN: newloop -->
    <div class="col-sm-12 col-md-8">
        <div class="thumbnail text-center">
            <div class="image" style="height: {thumb_height">
                <a title="{blocknew_items.title}" href="{blocknew_items.link}"> <img src="{blocknew_items.imgurl}" alt="{blocknew_items.title}" width="{THUMB_WIDTH}" class="img-thumbnail" />
                </a>
            </div>
            <div class="text-danger">
                <h3>
                    <a title="{blocknew_items.title}" href="{blocknew_items.link}" style="color: {blocknew_items.color">{blocknew_items.title}</a>
                </h3>
                <p class="text-danger">
                    <span class="price">{LANG.price}:</label> {blocknew_items.price}
                    </span>
                </p>
            </div>
        </div>
    </div>
    <!-- END: newloop -->
</div>
<!-- END: gridview -->
<div id="main_div">{DATA}</div>
<!-- BEGIN: generate_page -->
<div class="text-center">{PAGE}</div>
<!-- END: generate_page -->
<!-- END: main -->