Processor = require('./Processor.coffee')
RecipeMaterial = require('./RecipeMaterial.coffee')
RecipeItem = require('./RecipeItem.coffee')

class ProcessorHand extends Processor
  constructor: () ->
    il = Game.itemList
    ml = Game.materialList
    @itemRecipe = [
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], null, [il.item[il.id.stoneShovel]], null)
    ]
    @materialRecipe = [
      new RecipeMaterial([[ml.id.oreCoal, 1]], null, [[ml.id.rawCoal, 1]])
    ]
    super()

module.exports = ProcessorHand
