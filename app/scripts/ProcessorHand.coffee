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
    ]
    @materialRecipe = []

module.exports = ProcessorHand
