// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("trix")
require("@rails/actiontext")

window.jQuery = $;
window.$ = $;

import Rails from "@rails/ujs";
window.Rails = Rails;


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap';
import './style.scss';

//import 'flickity';
//its worked import FA
import "./FontAwesome/fontawesome";
import "./FontAwesome/light";
import "./FontAwesome/regular";
import "./FontAwesome/solid";

document.addEventListener("turbolinks:load",() => {
	$('[data-toggle="tooltip"]').tooltip()
	$('[data-toggle="popover"]').popover()
	console.log("from wb");
})

//$(document).on('turbolinks:load', function() {
//	$('[data-toggle="tooltip"]').tooltip()
//	$('[data-toggle="popover"]').popover()
//})

$(function () {
  console.log('jquery worked');
});

document.addEventListener("turbolinks:load",() => {
  var checkBoxes = document.querySelectorAll(".form-check-test");
  var form = document.querySelector('.form-check-test');
  
  for (const check of checkBoxes) {
	  check.addEventListener( 'change', function() {
	    Rails.fire(form, 'submit');
	    //document.querySelector("form").submit()
	  });
  }

  
})

document.addEventListener("turbolinks:load",() => {
var checkBoxes2 = document.querySelectorAll("form.simple_form");
  var form2 = document.querySelector('form.simple_form');
  
  for (const check2 of checkBoxes2) {
	  check2.addEventListener( 'change', function() {
	    Rails.fire(form2, 'submit');
	    //document.querySelector("form").submit()
	  });
  }
  })