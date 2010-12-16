// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	$('.hide_following_containers').live('click', function () { 
		var containers = $(this).parent().find('.'+$(this).attr('data-container'))
		containers.each(function(index, domElem) {
		  $(domElem).toggle('medium');
		});
		return false;
	});
	$('.remove').live('click', function () { 
		$(this).parent().prev().children("input[type=hidden]").val("1");
		$(this).parent().parent().parent().hide();
		return false;
	});
	$('.add_element').live('click', function () { 
		if($('.placement_comment_container:visible').length < 6) {
			var content = $(this).attr("data-element");
		  var new_id = new Date().getTime();
		  var regexp = new RegExp("new_" + $(this).attr("data-association"), "g")
			$(this).parent().before(content.replace(regexp, new_id));
	  }
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