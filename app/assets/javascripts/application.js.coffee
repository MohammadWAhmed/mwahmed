# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery_2
#= require jquery_ujs
#= require bootstrap
#= require jquery.turbolinks
#= require turbolinks
#= require nprogress
#= require nprogress-turbolinks
#= require rails_confirm_dialog
#= require jquery.scrollto

# Add error class to .avatar images if they fail to load
# See avatar.scss and _avatar.html.haml
#= require imagesloaded
#= require avatar.errors
cHeight = 0
$('#carousel500px').on 'slide.bs.carousel', (e) ->
  $nextImage = null
  $activeItem = $('.active.item', this)
  if e.direction == 'left'
    $nextImage = $activeItem.next('.item').find('img')
  else
    if $activeItem.index() == 0
      $nextImage = $('img:last', $activeItem.parent())
    else
      $nextImage = $activeItem.prev('.item').find('img')
  # prevents the slide decrease in height
  if cHeight == 0
    cHeight = $(this).height()
    $activeItem.next('.item').height cHeight
  # prevents the loaded image if it is already loaded
  src = $nextImage.data('lazy-load-src')
  if typeof src != 'undefined' and src != ''
    $nextImage.attr 'src', src
    $nextImage.data 'lazy-load-src', ''
  return

###!
# Start Bootstrap - Grayscale Bootstrap Theme (http://startbootstrap.com)
# Code licensed under the Apache License v2.0.
# For details, see http://www.apache.org/licenses/LICENSE-2.0.
###

# jQuery to collapse the navbar on scroll
$(window).scroll ->
  if $('.navbar').offset().top > 50
    $('.navbar-fixed-top').addClass 'top-nav-collapse'
  else
    $('.navbar-fixed-top').removeClass 'top-nav-collapse'
  return
# jQuery for page scrolling feature - requires jQuery Easing plugin
$ ->
  $('a.page-scroll').bind 'click', (event) ->
    $anchor = $(this)
    $('html, body').stop().animate { scrollTop: $($anchor.attr('href')).offset().top }, 1500, 'easeInOutExpo'
    event.preventDefault()
    return
  return
# Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click ->
  $('.navbar-toggle:visible').click()
  return

  