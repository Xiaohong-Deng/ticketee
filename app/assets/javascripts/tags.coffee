# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".tag .remove").on "ajax:success", ->
    # "this" is the remove link_to element
    $(this).parent().fadeOut()
