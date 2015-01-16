ItemPickaxe = require('./ItemPickaxe.coffee')

class ItemList
  @TYPE_PICKAXE: 1
  @id:
    stonePickaxe: 1
  @item: []
  @init: ->
    @register @id.stonePickaxe, new ItemPickaxe('Stone Pickaxe', Game.materialList.id.stone, [])
    
  @register: (id, item) -> @item[id] = item

module.exports = ItemList
