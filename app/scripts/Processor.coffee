class Processor
  @TYPE_NONE: 0
  @TYPE_ITEM: 1
  @TYPE_MATERIAL: 2
  
  name: undefined
  itemRecipe: []
  materialRecipe: []

  num: -> @state.length
  add: -> @state.push {type: Processor.TYPE_NONE, recipe: null, time: null, timeRemain: null}
  remove: -> @state.splice(@num - 1, 1)
  
  constructor: (@viewId) ->
    @state = []
    @queue = []

  update: () ->
    for e, i in @state
      if e.type != Processor.TYPE_NONE
        e.timeRemain -= 1
        if e.timeRemain == 0
          switch e.type
            when Processor.TYPE_ITEM
              for output in e.recipe.outputItem
                Game.item.push(output)

              if e.recipe.outputMaterial then for output in e.recipe.outputMaterial
                [materialId, amount] = output
                Game.material[materialId] += amount
            when Processor.TYPE_MATERIAL
              for output in e.recipe.outputMaterial
                [materialId, amount] = output
                Game.material[materialId] += amount
          @state[i] = {type: Processor.TYPE_NONE, recipe: null, time: null, timeRemain: null}
          Game.logger.log('Craft complete')
          Game.view.refresh(Game.view.ITEM)
          Game.view.refresh(Game.view.MATERIAL)
          Game.view.refresh(Game.view.PROCESSOR_STATE, @viewId)

    for e, i in @state
      if @queue.length == 0 then break
      if e.type == Processor.TYPE_NONE
        add = @queue[0]
        @state[i].type = add.type
        @state[i].recipe = add.recipe
        @state[i].time = add.recipe.time
        @state[i].timeRemain = add.recipe.time
        if add.amount
          add.amount -= 1
          if add.amount == 0
            @queue.splice(0, 1)
        else
          @queue.splice(0, 1)
        Game.view.refresh(Game.view.PROCESSOR_QUEUE, @viewId)

    Game.view.refresh(Game.view.PROCESSOR_STATE, @viewId)

  addQueueItemRecipe: (index) ->
    recipe = @itemRecipe[index]
    for e in recipe.requiredMaterial
      [materialId, amount] = e
      if Game.material[materialId] < amount
        Game.logger.log('Not enough material')
        return false

    for e in recipe.requiredMaterial
      [materialId, amount] = e
      Game.material[materialId] -= amount

    @queue.push {type: Processor.TYPE_ITEM, recipe: recipe, amount: null}
    Game.view.refresh(Game.view.ITEM)
    Game.view.refresh(Game.view.MATERIAL)
    Game.view.refresh(Game.view.PROCESSOR_QUEUE, @viewId)
    return true

  addQueueMaterialRecipe: (index, times) ->
    recipe = @materialRecipe[index]
    for source in recipe.requiredMaterial
      [materialId, amount] = source
      if Game.material[materialId] < amount * times
        Game.logger.log('Not enough material')
        return false

    for source in recipe.requiredMaterial
      [materialId, amount] = source
      Game.material[materialId] -= amount * times

    @queue.push {type: Processor.TYPE_MATERIAL, recipe: recipe, amount: 1}
    Game.view.refresh(Game.view.ITEM)
    Game.view.refresh(Game.view.MATERIAL)
    Game.view.refresh(Game.view.PROCESSOR_QUEUE, @viewId)
    return true

module.exports = Processor
