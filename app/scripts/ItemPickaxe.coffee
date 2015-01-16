Item = require('./Item.coffee')

class ItemPickaxe extends Item
  constructor: (name, @material, @modifier) ->
    super(Game.itemList.TYPE_PICKAXE, name)

module.exports = ItemPickaxe
