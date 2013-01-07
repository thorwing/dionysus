// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//=require reviews
//= require jquery.masonry
//= require redactor-rails
//= require raphael
//= require morris

$(function() {
    $('.hover_area').hover(
        function(){
            $(this).find(".display_on_hover").show();
        },
        function(){
            $(this).find(".display_on_hover").hide();
        }
    );

    $('.piece_flavor').focus(function(){
        $(this).parents(".removable_fields").find(".display_on_focus").show();
    });
});
//Add fields to DOM
function add_fields(link, association, content, selector) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(selector).append(content.replace(regexp, new_id));
}

//Remove fields from DOM
function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).parent(".removable_fields").remove();
}



$(function(){
    var $container = $('#masonryContainer');

    $container.imagesLoaded(function(){
        $container.masonry({
            itemSelector: '.masonary_item'
        }); //.masonry('reload');
    });
});


$(document).ready(function(){
    $("#back-to-top").hide();

    $(function () {
        $(window).scroll(function(){
            if ($(window).scrollTop()>100){
                $("#back-to-top").fadeIn(1500);
            }
            else {
                $("#back-to-top").fadeOut(1500);
            }
        });
        $("#back-to-top").click(function(){
            $('body,html').animate({scrollTop:0},1000);
            return false;
        });
    });
});