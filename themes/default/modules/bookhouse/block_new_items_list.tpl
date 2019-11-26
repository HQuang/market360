<!-- BEGIN: main -->
<div class="block_new_items_list">
    <!-- BEGIN: newloop -->
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="image pull-left" style="width: {THUMB_WIDTH}px">
                <a title="{blocknew_items.title}" href="{blocknew_items.link}"> <img src="{blocknew_items.imgurl}" alt="{blocknew_items.title}" width="{THUMB_WIDTH}" class="img-thumbnail" />
                </a>
            </div>
            <div class="item-detail">
                <ul>
                    <li><h2>
                            <a title="{blocknew_items.title}" href="{blocknew_items.link}" style="color: {blocknew_items.color}">{blocknew_items.title}</a>
                        </h2></li>
                    <li><label><em class="fa fa-tag">&nbsp;</em>{LANG.price}:</label> {blocknew_items.price}</li>
                    <!-- BEGIN: area -->
                    <li><label><em class="fa fa-area-chart">&nbsp;</em>{LANG.area}:</label> <!-- BEGIN: acreage --> {blocknew_items.area} m<sup>2</sup> <!-- END: acreage --><!-- BEGIN: size --> {blocknew_items.size_h} x {blocknew_items.size_v} m <!-- END: size --></li>
                    <!-- END: area -->
                    <li><label><em class="fa fa-map-marker">&nbsp;</em>{LANG.items_location}:</label> <a href="{blocknew_items.location_link}" title="{blocknew_items.location}">{blocknew_items.location}</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- END: newloop -->
</div>
<!-- END: main -->