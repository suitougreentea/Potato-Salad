Item = require('./Item.coffee')

class ItemTool extends Item
  constructor: (type, name, @material, @modifier) ->
    super(type, name)
class ItemShovel extends ItemTool
  constructor: (name, material, modifier) ->
    super(Game.itemList.TYPE_SHOVEL, name, material, modifier)
class ItemAxe extends ItemTool
  constructor: (name, material, modifier) ->
    super(Game.itemList.TYPE_AXE, name, material, modifier)
class ItemPickaxe extends ItemTool
  constructor: (name, material, modifier) ->
    super(Game.itemList.TYPE_PICKAXE, name, material, modifier)

module.exports = {
  ItemShovel: ItemShovel
  ItemAxe: ItemAxe
  ItemPickaxe: ItemPickaxe
}
