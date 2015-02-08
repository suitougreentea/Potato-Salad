Item = require('./Item.coffee')

class ItemProcessor extends Item
  constructor: (name, @processorId) ->
    super(Game.itemList.TYPE_PROCESSOR, name)
    
  use: ->
    Game.processorList.processor[@processorId].add()
    Game.view.refresh(Game.view.PROCESSOR, @processorId)
    return true

module.exports = ItemProcessor
