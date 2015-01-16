class Recipe
  constructor: (@requiredMaterial, @output) ->
  craft: ->
    for e in @requiredMaterial
      [materialId, amount] = e
      if Game.material[materialId] < amount
        Game.logger.log('Not enough material')
        return

    for e in @requiredMaterial
      [materialId, amount] = e
      Game.material[materialId] -= amount

    Game.item.push(@output)
    Game.logger.log('Craft complete')
    Game.refreshMaterialList()
    Game.refreshItemList()

module.exports = Recipe
