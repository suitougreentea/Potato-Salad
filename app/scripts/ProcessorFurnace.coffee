Processor = require('./Processor.coffee')
RecipeMaterial = require('./RecipeMaterial.coffee')
RecipeItem = require('./RecipeItem.coffee')

class ProcessorFurnace extends Processor
  name: 'Furnace'
  constructor: () ->
    super()
    @add() # TODO: debug
    il = Game.itemList
    ml = Game.materialList
    @itemRecipe = []
    @materialRecipe = [
      new RecipeMaterial([[ml.id.oreCoal, 1]], 10, null, [[ml.id.rawCoal, 1]])
      new RecipeMaterial([[ml.id.oreCopper, 1]], 10, null, [[ml.id.rawCopper, 1]])
    ]

module.exports = ProcessorFurnace
