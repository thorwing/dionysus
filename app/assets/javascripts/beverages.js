function add_filter(link) {
    var $form = $("#filterForm");
    var filter = $(link).data("filter");
    var value = $(link).data("value");
    var new_id = new Date().getTime();
    $form.prepend('<input id="' + new_id + '" name="filter[' + filter + '][]" type="hidden" value="' + value + '">');
    $form.prepend('<a class="white mr10" href="#" onclick="remove_filter(this); return false;" style="background: orange;">' + value + ' ×</a>');

    $form.find("input[type=submit]").show();
}

function remove_filter(link) {
    $(link).prev("input").remove();
    $(link).remove();
}