Processor = require('./Processor.coffee')
$ = require('jquery')

class View
  @refreshStatus: ->
    $('#time').text("Time: #{Game.time}")
    $('#mode').text("Now you are #{Game.mode}")
    $('#money').text("320,000,000,000,000,000.00 Mn")
    
  @getIcon: (config) ->
    if config
      result = "<svg class='materialIcon' viewBox='0 0 8.46667 8.46667'>"
      for e in config
        [icon, filter] = e
        result = result + "<use xlink:href='##{icon}' style='filter: url(##{filter})'></use>"
      result = result + "</svg>"
    else result = "<span class='materialIcon'>NO ICON</span>"
    return result
  
  @newTooltip: (content) ->

  @moveTooltip: () ->

  @hideTooltip: () ->
    
  @refreshMaterialList: ->
    $('#materialStock').html('')
    for list in Game.materialViewList.data
      $('#materialStock').append("<div class='materialHeader'>#{list.name}</div>")
      for e in list.list
        ((e) =>
          material = Game.materialList.material[e]
          num = Game.material[e]
          $('#materialStock').append("<div class='material'>#{@getIcon(material.icon)}<div class='materialName'>#{material.fullName}</div><div class='materialAmount'>#{Game.formatNumber(num)}</div></div>")
        )(e)
    return
    $('#materialOverworldPick').html('')
    for e in Game.materialOverworldPickViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworldPick').append("<input type=\"checkbox\">#{material.materialName}: #{num}<br />")

        # Check state
        $('#materialOverworldPick input:last').attr('checked', Game.materialOverworldIgnoreList.indexOf(e) != -1)
        $('#materialOverworldPick input:last').change(-> Game.changeIgnoreCheckbox($(@).is(':checked'), e))
      )(e)

  @refreshOreVeinList: ->
    $('#oreVein').html('')
    for e, i in Game.oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{Game.materialList.material[e.materialId].materialName}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click(-> Game.tryToStartMining(i))
      )(e, i)

  @refreshRecipeList: ->
    $('#recipe').html('')
    for processor in Game.processorList.processor
      if processor.num() == 0 then continue
      $('#recipe').append("<div class='processor'><div class='processorName'></div><div class='processorRecipe'></div><div class='processorStateList'></div><div class='processorQueueList'></div></div>")

      $('.processorName:last').text("#{processor.name} (#{processor.num()})")

      if processor.itemRecipe.length > 0
        $('.processorRecipe').append("<div class='processorRecipeItem'></div>")
        for e, i in processor.itemRecipe
          ((processor, e, i) =>
            $('.processorRecipeItem:last').append("<div class='buttonItem'>#{e.outputItem[0].name}</div>")
            $('.processorRecipeItem:last .buttonItem:last').click(-> processor.addQueueItemRecipe(i))
          )(processor, e, i)
          
      if processor.materialRecipe.length > 0
        $('.processorRecipe').append("<div class='processorRecipeMaterial'></div>")
        for e, i in processor.materialRecipe
          ((processor, e, i) =>
            [id, amount] = e.outputMaterial[0]
            $('.processorRecipeMaterial:last').append("<div class='buttonItem'>#{Game.materialList.material[id].fullName}</div>")
            $('.processorRecipeMaterial:last .buttonItem:last').click(-> processor.addQueueMaterialRecipe(i, 1))
          )(processor, e, i)

      for e, i in processor.state
        ((processor, e, i) =>
          $('.processorStateList:last').append("<div class='processorState'><div class='processorStateIcon'></div><div class='processorStateRight'><div class='processorStateText'></div><div class='processorStateMeter'></div></div></div>")
          $('.processorStateMeter:last').text("#{i}: #{e.timeRemain} / #{e.time}")
          switch e.type
            when Processor.TYPE_ITEM
              $('.processorStateText:last').text("#{e.recipe.outputItem[0].name}")
            when Processor.TYPE_MATERIAL
              id = e.recipe.outputMaterial[0][0]
              $('.processorStateText:last').text("#{Game.materialList.material[id].fullName}")
        )(processor, e, i)

      for e, i in processor.queue
        ((processor, e, i) =>
          switch e.type
            when Processor.TYPE_ITEM
              $('.processorQueueList:last').append("<div class='buttonItem'>#{e.recipe.outputItem[0].name}</div>")
            when Processor.TYPE_MATERIAL
              id = e.recipe.outputMaterial[0][0]
              $('.processorQueueList:last').append("<div class='buttonItem'>#{Game.materialList.material[id].fullName}</div>")
        )(processor, e, i)

  @refreshItemList: ->
    $('#itemHave').html('')
    $('#itemHave').append("<button>Pick</button>")
    $('#itemHave button:last').click(-> Game.tryToPick())
    if Game.have.shovel
      $('#itemHave').append("Shovel:<button>#{Game.have.shovel.name}</button>")
      $('#itemHave button:last').click(-> Game.tryToDig())
    if Game.have.axe
      $('#itemHave').append("Axe:<button>#{Game.have.axe.name}</button>")
      $('#itemHave button:last').click(-> Game.tryToCut())
    if Game.have.pickaxe
      $('#itemHave').append("Pickaxe:<button>#{Game.have.pickaxe.name}</button>")
      $('#itemHave button:last').click(-> Game.tryToGoUnderground())

    $('#itemStock').html('')
    for e, i in Game.item
      ((e, i) ->
        $('#itemStock').append("<div class='buttonItem'>#{e.name}</div>")
        $('#itemStock .buttonItem:last').click(-> Game.useItem(i))
      )(e, i)

module.exports = View
