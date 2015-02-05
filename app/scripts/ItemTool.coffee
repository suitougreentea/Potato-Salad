Item = require('./Item.coffee')

class ItemTool extends Item
  constructor: (type, name, @material, @modifier) ->
    super(type, name)
class ItemShovel extends ItemTool
  constructor: (name, material, modifier) ->
    super(Game.itemList.TYPE_SHOVEL, name, material, modifier)
  use: ->
    Game.have.shovel = @
    return true

class ItemAxe extends ItemTool
  constructor: (name, material, modifier) ->
    super(Game.itemList.TYPE_AXE, name, material, modifier)
  use: ->
    Game.have.axe = @
    return true

class ItemPickaxe extends ItemTool
  constructor: (name, material, modifier) ->
    super(Game.itemList.TYPE_PICKAXE, name, material, modifier)
  use: ->
    Game.have.pickaxe = @
    return true

module.exports = {
  ItemShovel: ItemShovel
  ItemAxe: ItemAxe
  ItemPickaxe: ItemPickaxe
}
