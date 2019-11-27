<!-- BEGIN: main -->
<div id="product_box_ads">
    <section class="house_listing">
        <h2 class="title st1">
            {BLOCK_TITLE} <span>VIP</span>
        </h2>
        <div class="item " itemtype="https://schema.org/House">
            <a itemprop="url" href="{ROW.link}">
                <div class="image">

                    <div class="ribbon ribbon-top-right">
                        <span>{BLOCKCAT.description}</span>
                    </div>

                    <img alt="{ROW.title}" width="320" height="240" src="{ROW.thumb}">
                    <!-- BEGIN: count_image -->
                    <div class="photo">{ROW.count_image}</div>
                    <!-- END: count_image -->
                </div>
            </a>
            <div class="block-info">
                <div class="header">
                    <h3 class="line2">
                        <a href="{ROW.link}">{ROW.title}</a>
                    </h3>
                    <p>
                        <a href="{ROW.location_link}">{ROW.location}</a>
                    </p>
                </div>
                <div class="body">
                    <p>{ROW.description}</p>
                    <div class="value">
                        <ul>
                            <!-- BEGIN: field -->
                            <li>{FIELD.title}: {FIELD.value}</li>
                            <!-- END: field -->
                        </ul>
                    </div>
                </div>
                <div class="footer">
                    <span class="price">{ROW.price}</span>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- END: main -->