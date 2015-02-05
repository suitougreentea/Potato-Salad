Processor = require('./Processor.coffee')
RecipeMaterial = require('./RecipeMaterial.coffee')
RecipeItem = require('./RecipeItem.coffee')

class ProcessorToolbox extends Processor
  name: 'Tool Box'
  constructor: () ->
    super()
    @add() # TODO: debug
    il = Game.itemList
    ml = Game.materialList
    @itemRecipe = [
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stoneShovel]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stoneAxe]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stonePickaxe]], null)
    ]
    @materialRecipe = [
      new RecipeMaterial([[ml.id.oreCoal, 1]], 10, null, [[ml.id.rawCoal, 1]])
    ]

module.exports = ProcessorToolbox
