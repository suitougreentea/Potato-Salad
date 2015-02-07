Processor = require('./Processor.coffee')
RecipeMaterial = require('./RecipeMaterial.coffee')
RecipeItem = require('./RecipeItem.coffee')

class ProcessorHand extends Processor
  name: 'Hand'
  constructor: () ->
    super()
    @add() # TODO: debug
    il = Game.itemList
    ml = Game.materialList
    @itemRecipe = [
      new RecipeItem([], [[ml.id.woodStick, 25], [ml.id.stone, 50]], 20, null, [il.item[il.id.toolBox1]], null)
      new RecipeItem([], [[ml.id.woodStick, 50], [ml.id.stone, 50]], 20, null, [il.item[il.id.furnace1]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stoneShovel]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stoneAxe]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stonePickaxe]], null)
    ]
    @materialRecipe = []

module.exports = ProcessorHand
