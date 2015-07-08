# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

(($) ->
  'use strict'
  # Start of use strict
  # jQuery for page scrolling feature - requires jQuery Easing plugin
  $('a.page-scroll').bind 'click', (event) ->
    $anchor = $(this)
    $('html, body').stop().animate { scrollTop: $($anchor.attr('href')).offset().top - 50 }, 1250, 'easeInOutExpo'
    event.preventDefault()
    return
  # Highlight the top nav as scrolling occurs
  $('body').scrollspy
    target: '.navbar-fixed-top'
    offset: 51
  # Closes the Responsive Menu on Menu Item Click
  $('.navbar-collapse ul li a').click ->
    $('.navbar-toggle:visible').click()
    return
  # Fit Text Plugin for Main Header
  $('h1').fitText 1.2,
    minFontSize: '35px'
    maxFontSize: '65px'
  # Offset for Main Navigation
  $('#mainNav').affix offset: top: 100
  # Initialize WOW.js Scrolling Animations
  (new WOW).init()
  return
) jQuery
