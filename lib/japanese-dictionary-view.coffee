{View} = require 'atom-space-pen-views'

module.exports =
class JapaneseDictionaryView extends View
  @content: ->
    @div class: 'japanese-dictionary-view', =>
      @tag 'webview'

  getTitle: ->
    "#{@word} - #{@service}"

  constructor: ({@word}) ->
    super
    @service = atom.config.get('japanese-dictionary.service')

    atom.commands.add @element,
      'core:copy': => @webview.copy()
      'core:paste': => @webview.paste()
      'core:cut': => @webview.cut()

  attached: ->
    word = encodeURIComponent(@word)
    @webview ?= @element.querySelector('webview')
    @webview.src = switch @service
      when 'weblio' then "http://ejje.weblio.jp/content/#{word}"
      when 'alc'    then "http://eow.alc.co.jp/search?q=#{word}"

  destroy: ->
    @element.remove()
