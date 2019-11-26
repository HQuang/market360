<!-- BEGIN: main -->
<div class="row our-team">
    <!-- BEGIN: loop -->
    <div class="col-md-6 col-sm-12  team">
        <div class="team-images row m0">
            <a href="{ROW.link}" title="{ROW.title}" target="_blank"><img src="{ROW.image}" alt="{ROW.title}" title="{ROW.title}"></a>
        </div>
        <ul class="nav social-icons">
            <li><a href="{ROW.link}" title="{ROW.title}" target="_blank"><i class="fa fa-facebook-square"></i></a></li>
        </ul>
        <div class="team-content">
            <a href="{ROW.link}" title="{ROW.title}" target="_blank"><h4>{BLOCK_TITLE}</h4></a>
            <p>{ROW.description}</p>
        </div>
    </div>
    <!-- END: loop -->
</div>
<!-- END: main -->
