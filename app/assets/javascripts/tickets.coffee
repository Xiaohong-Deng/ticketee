# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#add_file").on "ajax:success", (event, data) ->
    # console.log "add_file succeeded"
    # $("#attachments").append('<%= hello %>')
    $("#attachments").append(data)
    $(this).data "params", { index: $("#attachments div.file").length }
    # I guess this is the element with id=add_file
    # .length counts the number of div.file under id=attachments, which is
    # inside id=add_file
