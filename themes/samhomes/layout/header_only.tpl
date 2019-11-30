<!DOCTYPE html>
	<html lang="{LANG.Content_Language}" xmlns="http://www.w3.org/1999/xhtml" prefix="og: http://ogp.me/ns#">
	<head>
		<title>{THEME_PAGE_TITLE}</title>
		<!-- BEGIN: metatags --><meta {THEME_META_TAGS.name}="{THEME_META_TAGS.value}" content="{THEME_META_TAGS.content}">
		<!-- END: metatags -->
		<link rel="shortcut icon" href="{SITE_FAVICON}">
		<!-- BEGIN: links -->
		<link<!-- BEGIN: attr --> {LINKS.key}<!-- BEGIN: val -->="{LINKS.value}"<!-- END: val --><!-- END: attr -->>
		<!-- END: links -->
        
		<!-- BEGIN: js -->
		<script<!-- BEGIN: ext --> src="{JS_SRC}"<!-- END: ext -->><!-- BEGIN: int -->{JS_CONTENT}<!-- END: int --></script>
		<!-- END: js -->
        <script>$(document).ready(function() {
        $("#news_updated ul.dropdown-menu li a").on("click",function(){var t=$(this).text(),a=$(this).attr("data-url");if($(this).parent().parent().prev().html(t+' <b class="caret">'),void 0!==a){var i=$(this);$(this.hash).load(a,function(t){return i.tab("show"),!1})}});
        initHomepage();        
        $("#popup_sildeup1").owlCarousel({nav:!1,dots:!1,autoHeight:!1,autoplay:!0,autoplayTimeout:3e3,loop:!0,singleItem:!0,items:1}),$("#toggle-product .affix").on("click",function(){$("#popup_slideup").slideToggle("slow")});        
    });</script>
	</head>
	<body class="custom_page_layout_site_index">

