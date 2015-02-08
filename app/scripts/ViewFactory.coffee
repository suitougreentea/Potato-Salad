$ = require('jquery')
Processor = require('./Processor.coffee')

class ViewFactory
  @refreshAll: () ->
    $('#painMain').html("<div id='processorList'></div>")
    for e, i in Game.processorList.processor
      $('#processorList').append("<div class='processor'><div class='header'></div><div class='settings'></div><div class='state'></div><div class='queue'></div><div class='recipeItem'></div><div class='recipeMaterial'></div></div>")
      @refreshProcessor(i)

  @refreshProcessor: (id) ->
    processor = Game.processorList.processor[id]
    jq = $("#processorList>.processor:nth-child(#{id + 1})")
    if processor.num() == 0
      jq.hide()
    else
      jq.show()
      @refreshProcessorHeader(id)
      @refreshProcessorSettings(id)
      @refreshProcessorState(id)
      @refreshProcessorQueue(id)
      @refreshProcessorRecipeList(id)

  @refreshProcessorHeader: (id) ->
    processor = Game.processorList.processor[id]
    jq = $("#processorList>.processor:nth-child(#{id + 1})")
    jq.find('.header').text("#{processor.name} (#{processor.num()})")

  @refreshProcessorSettings: (id) ->
    jq = $("#processorList>.processor:nth-child(#{id + 1})")
    jq.find('.settings').text('SETTINGS')

  @refreshProcessorState: (id) ->
    processor = Game.processorList.processor[id]
    jq = $("#processorList>.processor:nth-child(#{id + 1})")
    jq.find('.state').html('')
    for e, i in processor.state
      ((e, i) =>
        if e.type == Processor.TYPE_NONE
          jq.find('.state').append('<div>No work</div>')
        else
          jq.find('.state').append("<div><div class='iconBox'></div><div class='meter'><div class='meterbg'><span class='meterFill'></span></div></div><div class='progress'></div></div>")
          switch e.type
            when Processor.TYPE_ITEM
              Game.view.registerTooltip(jq.find('.state>div:last>.iconBox'), e.recipe.outputItem[0].name)
            when Processor.TYPE_MATERIAL
              Game.view.registerTooltip(jq.find('.state>div:last>.iconBox'), Game.materialList.material[e.recipe.outputMaterial[0][0]].fullName)
          jq.find('.state>div:last>.iconBox').html(Game.view.getIcon([['sIngot', '']]))
          jq.find('.state>div:last>.meter>.meterbg>.meterFill').css(width: "#{(e.time - e.timeRemain) / e.time * 100}%")
          jq.find('.state>div:last>.progress').text("#{e.timeRemain} / #{e.time}")
      )(e, i)

  @refreshProcessorQueue: (id) ->
    processor = Game.processorList.processor[id]
    jq = $("#processorList>.processor:nth-child(#{id + 1})")
    jq.find('.queue').html('')
    for e, i in processor.queue
      ((e, i) =>
        jq.find('.queue').append("<div class='iconBox'></div>")
        jq.find('.queue>.iconBox:last').html(Game.view.getIcon([['sIngot', '']]))
        switch e.type
          when Processor.TYPE_ITEM
            Game.view.registerTooltip(jq.find('.queue>.iconBox:last'), e.recipe.outputItem[0].name)
          when Processor.TYPE_MATERIAL
            Game.view.registerTooltip(jq.find('.queue>.iconBox:last'), Game.materialList.material[e.recipe.outputMaterial[0][0]].fullName)
      )(e, i)

  @refreshProcessorRecipeList: (id) ->
    processor = Game.processorList.processor[id]
    jq = $("#processorList>.processor:nth-child(#{id + 1})")
    itemRecipe = processor.itemRecipe
    materialRecipe = processor.materialRecipe

    if itemRecipe.length > 0
      for e, i in itemRecipe
        ((e, i) =>
          item = e.outputItem[0]
          jq.find('.recipeItem').append("<div class='buttonItem'>#{Game.view.getIcon([['sIngot', '']])}</div>")
          Game.view.registerTooltip(jq.find('.recipeItem>.buttonItem:last'), item.name)
          jq.find('.recipeItem>.buttonItem:last').click(-> processor.addQueueItemRecipe(i))
        )(e, i)

    if materialRecipe.length > 0
      for e, i in materialRecipe
        ((e, i) =>
          [id, amount] = e.outputMaterial[0]
          jq.find('.recipeMaterial').append("<div class='buttonItem'>#{Game.view.getIcon([['sIngot', '']])}</div>")
          Game.view.registerTooltip(jq.find('.recipeMaterial>.buttonItem:last'), Game.materialList.material[id].fullName)
          jq.find('.recipeMaterial>.buttonItem:last').click(-> processor.addQueueMaterialRecipe(i, 1))
        )(e, i)

module.exports = ViewFactory
