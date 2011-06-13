// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	cleanup_hashes();
	
	$('.remove').live('click', function () { 
		$(this).parent().prev().children("input[type=hidden]").val("1");
		$(this).closest('fieldset').hide();
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
	$('input.ui-date-picker').datepicker({ dateFormat: 'yy-mm-dd' });
	
	$('a.poplight').click(function() {
	    var popID = $(this).attr('rel'); //Get Popup Name
	    var popURL = $(this).attr('href'); //Get Popup href to define size

	    //Pull Query & Variables from href URL
	    var query= popURL.split('?');
	    var dim= query[1].split('&');
	    var popWidth = dim[0].split('=')[1]; //Gets the first query string value

	    //Fade in the Popup and add close button
	    $('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="/images/frontend/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>');

	    //Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
	    var popMargTop = ($('#' + popID).height() + 80) / 2;
	    var popMargLeft = ($('#' + popID).width() + 80) / 2;

	    //Apply Margin to Popup
	    $('#' + popID).css({
	        'margin-top' : -popMargTop,
	        'margin-left' : -popMargLeft
	    });

	    //Fade in Background
	    $('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
	    $('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer - .css({'filter' : 'alpha(opacity=80)'}) is used to fix the IE Bug on fading transparencies 

	    return false;
	});

	//Close Popups and Fade Layer
	$('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
	    $('#fade , .popup_block').fadeOut(function() {
	        $('#fade, a.close').remove();  //fade them both out
	    });
	    return false;
	});
	
	ajax_rating_combo();
});

function ajax_rating_combo() {
	update_checked_rationgs();
	rating_form_status();
	submit_rating_form();
	rating_form_hover();
}

function update_checked_rationgs(){
	var checkedId = 'rating_' + $('form.rating_ballot input:checked').attr('value');
	$("form.rating_ballot label[for="+checkedId+"]").parent().prevAll().andSelf().addClass('bright');
}

function rating_form_status() {
	$('form.rating_ballot').ajaxSuccess(function(e, xhr, settings) {
		$(this).parent().html(xhr.responseText);
		$('.ajax_loader').addClass('hidden')
		ajax_rating_combo();
	});
	$('form.rating_ballot').bind("ajax:failure", function(){
	  alert('fail');
	});
}

function submit_rating_form() {
	$('form.rating_ballot li').click(function() {
		$(this).children().last().attr('checked', true);
  	$('form.rating_ballot').submit();
		$('.ajax_loader').removeClass('hidden')
  });
}

function rating_form_hover() {
	$('form.rating_ballot li').hover( function() {    // mouseover
		  $(this).siblings().andSelf().removeClass('bright');
			$(this).prevAll().andSelf().addClass('bright');
		}, function() {
			$(this).siblings().andSelf().removeClass('bright');
			update_checked_rationgs();
		}
	);
}

function cleanup_hashes() {
	$('input.remove,input.add_element').each(function(index, domElem){
		$(domElem).val($(domElem).val().replace(/\s+#\d+/, ''));
	});
}
