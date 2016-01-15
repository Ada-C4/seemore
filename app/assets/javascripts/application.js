// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets


$(function(){
  $('#nav').affix({
    offset: {
      top: $('header').height()
    }
  });
});

/**
 * Listen to scroll to change header opacity class
 */
function checkScroll(){
    var startY = $('.navbar').height(); //The point where the navbar changes in px
    if($(window).scrollTop() > startY || $(window).width() < 768){
      $('.navbar').addClass("scrolled");
    }
    else{
      $('.navbar').removeClass("scrolled");
    }
}
// 
// $(window).on("scroll resize", function(){
//   checkScroll();
// });
