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
//= require_tree .


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

