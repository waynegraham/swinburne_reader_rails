overlay = $('#overlay')
overlayClose = $('#overlay button')
header = $('#header')
switchButton = $('#header button.slider-switch')

closeOverlay = ->
  $('#overlay').hide()
  return

overlayClose.click ->
  closeOverlay()
  document.cookie="showInfo=false"
  return

