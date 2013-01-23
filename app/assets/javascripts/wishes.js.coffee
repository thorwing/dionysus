# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#star').raty
    path: '/assets/'
    scoreName: 'wish[rating]'
    score: ->
      return $(this).attr('data-rating')

  $('.wish_rating').raty
    readOnly: true
    score: ->
      return $(this).attr('data-rating')
    path: '/assets/'