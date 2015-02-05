Processor = require('./Processor.coffee')
RecipeMaterial = require('./RecipeMaterial.coffee')
RecipeItem = require('./RecipeItem.coffee')

class ProcessorHand extends Processor
  name: 'Hand'
  constructor: () ->
    super()
    @add()
    il = Game.itemList
    ml = Game.materialList
    @itemRecipe = [
      new RecipeItem([], [[ml.id.woodStick, 25], [ml.id.stone, 50]], 20, null, [il.item[il.id.toolBox1]], null)
    ]
    @materialRecipe = []

module.exports = ProcessorHand
