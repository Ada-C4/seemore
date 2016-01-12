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
//= require turbolinks
//= require_tree .

window.onload = (function(){

  var tweetList = $(".tweet");

  for (var i = 0; i < tweetList.length; i++) {
    var id = tweetList[i].getAttribute("tweetID");

    twttr.widgets.createTweet(
      id, tweetList[i],
      {
        conversation : 'none',    // or all
        cards        : 'visible',
        linkColor    : 'black', // default is blue
        theme        : 'light',    // or dark
        width        : '550', // amount in pixels, between 250 and 550
        align        : 'center' // float the Tweet left, right, or center
      });
  }
});
