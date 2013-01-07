# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $(".slider").slider
    min: 1
    max: 25
    range: "min"
    value: 22
    slide: (event, ui) ->
      score = $(this).next().find(".score")
      score.text ui.value
      score_input = $(this).next().find(".score_input")
      score_input.val parseInt ui.value

      total = 0
      for item in $(".score_fields .score")
        total += parseInt ui.value
      $("#review_score").val total
