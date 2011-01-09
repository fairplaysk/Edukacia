// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	cleanup_hashes();
	
	$('.remove').live('click', function () { 
		$(this).parent().prev().children("input[type=hidden]").val("1");
		$(this).parent().parent().parent().hide();
		return false;
	});
	$('.add_element').live('click', function () { 
		if($('.placement_comment_container:visible').length < 6) {
			var content = $(this).attr("data-element");
		  var new_id = new Date().getTime();
		  var regexp = new RegExp("new_" + $(this).attr("data-association"), "g");
			$(this).parent().before(content.replace(regexp, new_id));
	  }
	  cleanup_hashes();
		return false;  
	});
});

function cleanup_hashes() {
	$('input.remove,input.add_element').each(function(index, domElem){
		$(domElem).val($(domElem).val().replace(/\s+#\d+/, ''));
	});
}