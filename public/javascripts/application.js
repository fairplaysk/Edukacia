// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
		$(".remove").click(function() {
			$(this).prev().children("input[type=hidden]").val("1");
			$(this).parent().hide();
			return false;
		});
});


function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().find(".inputs .remove").last().after(content.replace(regexp, new_id));
	return false;

	$(".remove").click(function() {
		$(this).prev().children("input[type=hidden]").val("1");
		$(this).parent().hide();
		return false;
	});
}