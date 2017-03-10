// //font chooser
// var fonts = [
// 	'Barrio',
// 	'Anton','Francois One','Patua One','Archivo Black','Alfa Slab One','Bevan']

// var fontCounter = 0;

// $('#font-name h3').text('font: ' + (fontCounter+1) + "/" + fonts.length + ": " + fonts[fontCounter])


// $('h1, .section h2').css('font-family',fonts[fontCounter]).on('click',function(){
// 	if(fontCounter < (fonts.length - 1)){
// 		fontCounter ++
// 	} else if(fontCounter == (fonts.length -1)){
// 		fontCounter = 0;
// 	}
// 	$('h1, .section h2, #titleblock h3 span').css('font-family',fonts[fontCounter])
// $('#font-name h3').text('font: ' + (fontCounter+1) + "/" + fonts.length + ": " + fonts[fontCounter])
// });

$('.js-scroll-to').click(function(e) {

	target = $($(this).attr('href'));

	if (target.offset()) {
		$('html, body').animate({scrollTop: target.offset().top + 'px'}, 600);
	}

	e.preventDefault();
});



$('.js-next').click(function(e) {
	console.log("click down");
  var selected = $(".section.js-current-panel");
  var anchors = $(".section");

  var pos = anchors.index(selected);
  var next = anchors.get(pos+1);
  var prev = anchors.get(pos-1);

  target = $(next);

  $(selected).removeClass("js-current-panel");
  $(next).addClass("js-current-panel");

	if (target.offset()) {
		$('html, body').animate({scrollTop: target.offset().top + 'px'}, 600);
	}


	e.preventDefault();
});




//toggle help
$('#mobile-menu-toggler, #main-menu-toggler').on('click',function(){
	console.log("toggle that menu!")
	TweenMax.to($('#helpbar'),.2,{autoAlpha:1})
});


$('#close-help').on('click',function(){
	TweenMax.to($('#helpbar'),.2,{autoAlpha:0})
});
