# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#star').raty
    path: '/assets/'
    scoreName: 'wish[rating]'

  $('#wishRating').raty
    score: ->
      return $(this).attr('data-rating')
    path: '/assets/'