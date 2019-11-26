<!-- BEGIN: main -->
<!-- BEGIN: vertical -->
<div class="row">
    <!-- BEGIN: newloop -->
    <div class="col-sm-12 col-md-8">
        <div class="thumbnail text-center">
            <div class="image" style="height: {thumb_height">
                <a title="{blockhitstotal_items.title}" href="{blockhitstotal_items.link}"> <img src="{blockhitstotal_items.imgurl}" alt="{blockhitstotal_items.title}" width="{THUMB_WIDTH}" class="img-thumbnail" />
                </a>
            </div>
            <div class="text-danger">
                <h3>
                    <a title="{blockhitstotal_items.title}" href="{blockhitstotal_items.link}" style="color: {blockhitstotal_items.color">{blockhitstotal_items.title}</a>
                </h3>
                <p class="text-danger">
                    <span class="price">{LANG.price}:</label> {blockhitstotal_items.price}
                    </span>
                </p>
            </div>
        </div>
    </div>
    <!-- END: newloop -->
</div>
<!-- END: vertical -->
<!-- BEGIN: gridview -->
<div class="row">
    <!-- BEGIN: newloop -->
    <div class="col-sm-12 col-md-8">
        <div class="thumbnail text-center">
            <div class="image" style="height: {thumb_height">
                <a title="{blockhitstotal_items.title}" href="{blockhitstotal_items.link}"> <img src="{blockhitstotal_items.imgurl}" alt="{blockhitstotal_items.title}" width="{THUMB_WIDTH}" class="img-thumbnail" />
                </a>
            </div>
            <div class="text-danger">
                <h3>
                    <a title="{blockhitstotal_items.title}" href="{blockhitstotal_items.link}" style="color: {blockhitstotal_items.color">{blockhitstotal_items.title}</a>
                </h3>
                <p class="text-danger">
                    <span class="price">{LANG.price}:</label> {blockhitstotal_items.price}
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