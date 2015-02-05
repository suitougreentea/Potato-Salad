$ = require('jquery')

class View
  @refreshStatus: ->
    $('#time').text("Time: #{Game.time} Mode: #{Game.mode} Target: #{Game.miningTarget} Using: #{Game.using}")
    
  @refreshMaterialList: ->
    $('#materialStock').html('')
    for list in Game.materialViewList.data
      $('#materialStock').append("<div class='materialHeader'>#{list.name}</div>")
      for e in list.list
        ((e) =>
          material = Game.materialList.material[e]
          num = Game.material[e]
          $('#materialStock').append("<div class='material'><svg class='materialIcon'></svg><div class='materialName'>#{material.fullName}</div><div class='materialAmount'>#{num}</div></div>")
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
      $('#recipe').append("<div>#{processor.name} (#{processor.num()})</div>")
      for e, i in processor.itemRecipe
        ((processor, e, i) =>
          $('#recipe').append("<div class='buttonItem'>#{e.outputItem[0].name}</div>")
          $('#recipe .buttonItem:last').click(-> processor.craftItemRecipe(i))
        )(processor, e, i)
      $('#recipe').append('<br />')
      for e, i in processor.materialRecipe
        ((processor, e, i) =>
          [id, amount] = e.outputMaterial[0]
          $('#recipe').append("<div class='buttonItem'>#{Game.materialList.material[id].fullName}</div>")
          $('#recipe .buttonItem:last').click(-> processor.craftMaterialRecipe(i, 1))
        )(processor, e, i)
      $('#recipe').append('<br />')

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
