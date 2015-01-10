module.exports =
  run: () ->

    updates = 0

    triggerMeasurements = (force) ->
      if force or updates <= 5 #do this a bunch of times and then stop
        atom.workspaceView.increaseFontSize()
        atom.workspaceView.decreaseFontSize()
        console.log('1')

    applyFont = (font) ->
      atom.workspaceView.attr('fonts-editor-font', font)
      triggerMeasurements()

    # apply fonts when atom is ready
    atom.workspaceView.ready ->
      applyFont(atom.config.get('fonts.fontFamily'))
      console.log('ready')

    # apply fonts when config changes
    atom.config.observe 'fonts.fontFamily', ->
      updates = 0
      applyFont(atom.config.get('fonts.fontFamily'))
      console.log('observe')

    #this triggers all the time something happens in an editor
    atom.workspaceView.on 'editor:display-updated', ->
      triggerMeasurements()
      console.log('displayupdate')
      if updates <= 5
        updates = updates + 1

    atom.workspaceView.on 'editor:path-changed', ->
      console.log(8)

    #force chromium to load all font files regardless of editor content
    atom.workspaceView.append '<div class="fonts-fixer">
        <span class="regular">r</span>
        <span class="bold">b</span>
        <span class="italic">i</span>
        <span class="bolditalic">bi</span>
      </div>'