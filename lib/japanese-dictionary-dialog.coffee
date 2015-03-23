{TextEditorView, View} = require 'atom-space-pen-views'

module.exports =
class JapaneseDictionaryDialog extends View
  @content: ({prompt} = {}) ->
    @div class: 'japanese-dictionary-dialog', =>
      @label 'Input word:'
      @subview 'miniEditor', new TextEditorView(mini: true)
      @div class: 'error-message', outlet: 'errorMessage'

  initialize: ({onConfirm}) ->
    atom.commands.add @element,
      'core:confirm': =>
        onConfirm(@miniEditor.getText())
        @close()
      'core:cancel': => @cancel()
    @miniEditor.on 'blur', => @close()
    @miniEditor.getModel().onDidChange => @showError()

  attach: ->
    @panel = atom.workspace.addModalPanel(item: this.element)
    @miniEditor.focus()
    @miniEditor.getModel().scrollToCursorPosition()

  close: ->
    panelToDestroy = @panel
    @panel = null
    panelToDestroy?.destroy()
    atom.workspace.getActivePane().activate()

  cancel: ->
    @close()

  showError: (message='') ->
    @errorMessage.text(message)
    @flashError() if message
