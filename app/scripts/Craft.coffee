RecipeMaterial = require('./RecipeMaterial.coffee')
RecipeItem = require('./RecipeItem.coffee')

class Craft
  @TYPE_NONE: 0
  @TYPE_ITEM: 1
  @TYPE_MATERIAL: 2

  @state: {type: @TYPE_NONE, recipe: null, time: null, timeRemain: null}

  @init: ->
    il = Game.itemList
    ml = Game.materialList
    @itemRecipe = [
      new RecipeItem([], [[ml.id.woodStick, 25], [ml.id.stone, 50]], 20, null, [il.item[il.id.toolBox1]], null)
      new RecipeItem([], [[ml.id.woodStick, 50], [ml.id.stone, 50]], 20, null, [il.item[il.id.furnace1]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stoneShovel]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stoneAxe]], null)
      new RecipeItem([], [[ml.id.woodStick, 1], [ml.id.stone, 2]], 5, null, [il.item[il.id.stonePickaxe]], null)
    ]
    @materialRecipe = [
      new RecipeMaterial([[ml.id.oreCoal, 1]], 10, null, [[ml.id.rawCoal, 1]])
      new RecipeMaterial([[ml.id.oreCopper, 1]], 10, null, [[ml.id.rawCopper, 1]])
    ]

  @update: ->
    if @state.type != @TYPE_NONE
      @state.timeRemain -= 1
      Game.view.refresh(Game.view.TOOLBOX_STATE)
      if @state.timeRemain == 0
        switch @state.type
          when @TYPE_ITEM
            for output in @state.recipe.outputItem
              Game.item.push(output)
            if @state.recipe.outputMaterial then for output in @state.recipe.outputMaterial
              [materialId, amount] = output
              Game.material[materialId] += amount
          when @TYPE_MATERIAL
            for output in @state.recipe.outputMaterial
              [materialId, amount] = output
              Game.material[materialId] += amount
        @state = {type: @TYPE_NONE, recipe: null, time: null, timeRemain: null}
        Game.logger.log('Craft complete')
        Game.view.refresh(Game.view.ITEM)
        Game.view.refresh(Game.view.MATERIAL)
        Game.view.refresh(Game.view.TOOLBOX_STATE)
        return true

  @cancelCrafting: () ->
    @state = {type: @TYPE_NONE, recipe: null, time: null, timeRemain: null}

  @startCraftingItem: (index) ->
    if @state.type == @TYPE_NONE
      recipe = @itemRecipe[index]
      for e in recipe.requiredMaterial
        [materialId, amount] = e
        if Game.material[materialId] < amount
          Game.logger.log('Not enough material')
          return false

      for e in recipe.requiredMaterial
        [materialId, amount] = e
        Game.material[materialId] -= amount

      @state = {type: @TYPE_ITEM, recipe: recipe, time: recipe.time, timeRemain: recipe.time}
      Game.view.refresh(Game.view.ITEM)
      Game.view.refresh(Game.view.MATERIAL)
      Game.view.refresh(Game.view.TOOLBOX_STATE)
      return true
    else
      Game.logger.log('You are crafting another stuff')
      return false

  @startCraftingMaterial: (index, times) ->
    if @state.type == @TYPE_NONE
      recipe = @materialRecipe[index]
      for source in recipe.requiredMaterial
        [materialId, amount] = source
        if Game.material[materialId] < amount * times
          Game.logger.log('Not enough material')
          return false

      for source in recipe.requiredMaterial
        [materialId, amount] = source
        Game.material[materialId] -= amount * times

      @state = {type: @TYPE_MATERIAL, recipe: recipe, time: recipe.time, timeRemain: recipe.time}
      Game.view.refresh(Game.view.ITEM)
      Game.view.refresh(Game.view.MATERIAL)
      Game.view.refresh(Game.view.TOOLBOX_STATE)
      return true
    else
      Game.logger.log('You are crafting another stuff')
      return false

module.exports = Craft
