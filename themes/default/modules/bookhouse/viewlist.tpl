<!-- BEGIN: main -->
<div class="viewlist">
    <!-- BEGIN: loop -->
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="image pull-left" style="width: {THUMB_WIDTH}px">
                <a title="{DATA.title}" href="{DATA.link}"> <img src="{DATA.imghome}" alt="{DATA.title}" width="{THUMB_WIDTH}" class="img-thumbnail" />
                </a>
            </div>
            <ul class="item-detail">
                <li><h3>
                        <a title="{DATA.title}" href="{DATA.link}" style="color: {DATA.color}">{DATA.title}</a>
                    </h3></li>
                <li><label><em class="fa fa-tag">&nbsp;</em>{LANG.price}:</label> <span class="price"> <!-- BEGIN: price --> {DATA.price} <!-- END: price --> <!-- BEGIN: contact --> {LANG.contact} <!-- END: contact -->
                </span></li>
                <!-- BEGIN: size_0 -->
                <li><label><em class="fa fa-area-chart">&nbsp;</em>{LANG.area}:</label> {DATA.size} m<sup>2</sup></li>
                <!-- END: size_0 -->
                <!-- BEGIN: size_1 -->
                <li><label><em class="fa fa-area-chart">&nbsp;</em>{LANG.size}:</label> {DATA.size} {LANG.met}</li>
                <!-- END: size_1 -->
                <li><label><em class="fa fa-map-marker">&nbsp;</em>{LANG.items_location}:</label> <a href="{DATA.location_link}" title="{DATA.location}">{DATA.location}</a></li>
            </ul>
        </div>
    </div>
    <!-- END: loop -->
</div>
<!-- END: main -->