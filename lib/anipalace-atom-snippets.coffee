AnipalaceAtomSnippetsView = require './anipalace-atom-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AnipalaceAtomSnippets =
  anipalaceAtomSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @anipalaceAtomSnippetsView = new AnipalaceAtomSnippetsView(state.anipalaceAtomSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @anipalaceAtomSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'anipalace-atom-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @anipalaceAtomSnippetsView.destroy()

  serialize: ->
    anipalaceAtomSnippetsViewState: @anipalaceAtomSnippetsView.serialize()

  toggle: ->
    console.log 'AnipalaceAtomSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
