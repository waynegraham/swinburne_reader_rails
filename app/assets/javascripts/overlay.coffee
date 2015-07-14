do ->
  overlay = document.getElementById('overlay')
  overlayClose = overlay.querySelector('button')
  header = document.getElementById('header')
  switchBtnn = header.querySelector('button.slider-switch')

  toggleBtnn = ->
    if slideshow.isFullscreen
      classie.add switchBtnn, 'view-maxi'
    else
      classie.remove switchBtnn, 'view-maxi'
    return

  toggleCtrls = ->
    if !slideshow.isContent
      classie.add header, 'hide'
    return

  toggleCompleteCtrls = ->
    if !slideshow.isContent
      classie.remove header, 'hide'
    return

  slideshow = new DragSlideshow(document.getElementById('slideshow'),
    onToggle: toggleBtnn
    onToggleContent: toggleCtrls
    onToggleContentComplete: toggleCompleteCtrls)

  toggleSlideshow = ->
   	slideshow.toggle()
    toggleBtnn()
    return

  closeOverlay = ->
    classie.add overlay, 'hide'
    return

  # toggle between fullscreen and small slideshow
  switchBtnn.addEventListener 'click', toggleSlideshow
  # close overlay
  overlayClose.addEventListener 'click', closeOverlay
  return
