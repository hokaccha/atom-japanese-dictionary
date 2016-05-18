JapaneseDictionaryView = require './japanese-dictionary-view'
Dialog = require './japanese-dictionary-dialog'
{CompositeDisposable} = require 'atom'
url = require 'url'

module.exports =
  config:
    service:
      title: 'Service'
      type: 'string'
      enum: ['weblio', 'alc']
      default: 'weblio'

  activate: ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace',
      'japanese-dictionary:open-by-selection': => @openBySelection()
      'japanese-dictionary:open-by-input': => @openDialog()

    @subscriptions.add atom.workspace.addOpener (uriToOpen) =>
      try
        {protocol, host, pathname} = url.parse(uriToOpen)
      catch error
        return

      return unless protocol is 'japanese-dictionary:'

      new JapaneseDictionaryView(word: decodeURIComponent(pathname.slice(1)))

  deactivate: ->
    @subscriptions?.dispose()

  open: (word) ->
    return unless word
    word = encodeURIComponent(word)
    atom.workspace.open("japanese-dictionary://word/#{word}", {
      searchAllPanes: true
      split: 'right'
    })

  openBySelection: ->
    editor = atom.workspace.getActiveTextEditor()
    @open(editor.getSelectedText())

  openDialog: ->
    dialog = new Dialog(onConfirm: (text) => @open(text))
    dialog.attach()
