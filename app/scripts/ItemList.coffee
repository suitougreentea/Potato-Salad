ItemTool = require('./ItemTool.coffee')
ItemProcessor = require('./ItemProcessor.coffee')
ProcessorToolbox = require('./ProcessorToolbox.coffee')

class ItemList
  @TYPE_SHOVEL: 1
  @TYPE_AXE: 2
  @TYPE_PICKAXE: 3
  @TYPE_PROCESSOR: 100

  @id:
    stoneShovel: 1
    stoneAxe: 2
    stonePickaxe: 3
    furnace1: 4
  @item: []
  @init: ->
    @register @id.stoneShovel, new ItemTool.ItemShovel('Stone Shovel', Game.materialList.id.stone, [])
    @register @id.stoneAxe, new ItemTool.ItemAxe('Stone Axe', Game.materialList.id.stone, [])
    @register @id.stonePickaxe, new ItemTool.ItemPickaxe('Stone Pickaxe', Game.materialList.id.stone, [])
    @register @id.furnace1, new ItemProcessor('Furnace', Game.processorList.id.furnace1)
    
  @register: (id, item) -> @item[id] = item

module.exports = ItemList
