class Processor
  name: undefined
  itemRecipe: []
  materialRecipe: []

  num: -> @state.length
  add: -> @state.push null
  remove: -> @state.splice(@num - 1, 1)
  
  constructor: () ->
    @state = []
    @queue = []

  craftItemRecipe: (index) ->
    recipe = @itemRecipe[index]
    for e in recipe.requiredMaterial
      [materialId, amount] = e
      if Game.material[materialId] < amount
        Game.logger.log('Not enough material')
        return false

    for e in recipe.requiredMaterial
      [materialId, amount] = e
      Game.material[materialId] -= amount

    for output in recipe.outputItem
      Game.item.push(output)

    if recipe.outputMaterial then for output in recipe.outputMaterial
      [materialId, amount] = output
      Game.material[materialId] += amount * times

    Game.logger.log('Craft complete')
    Game.view.refreshMaterialList()
    Game.view.refreshItemList()
    return true

  craftMaterialRecipe: (index, times) ->
    recipe = @materialRecipe[index]
    for source in recipe.requiredMaterial
      [materialId, amount] = source
      if Game.material[materialId] < amount * times
        Game.logger.log('Not enough material')
        return false

    for source in recipe.requiredMaterial
      [materialId, amount] = source
      Game.material[materialId] -= amount * times

    for output in recipe.outputMaterial
      [materialId, amount] = output
      Game.material[materialId] += amount * times

    Game.logger.log('Craft complete')
    Game.view.refreshMaterialList()
    return true

module.exports = Processor
