$ = require('jquery')

class View
  @refreshStatus: ->
    $('#time').text("Time: #{Game.time} Mode: #{Game.mode} Target: #{Game.miningTarget} Using: #{Game.using}")
    
  @refreshMaterialList: ->
    $('#materialStock').html('')
    for list in [Game.materialOverworldPickViewList, Game.materialOverworldDigViewList, Game.materialOverworldCutViewList, Game.materialOreViewList, Game.materialRawViewList]
      for e in list
        ((e) =>
          material = Game.materialList.material[e]
          num = Game.material[e]
          $('#materialStock').append("<div class='material'><svg class='materialIcon'></svg><div class='materialName'>#{material.fullName}</div><div class='materialAmount'>#{num}</div></div>")
        )(e)
      $('#materialStock').append('<hr />')
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

    $('#materialOverworldDig').html('')
    for e in Game.materialOverworldDigViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworldDig').append("#{material.materialName}: #{num}<br />")
      )(e)

    $('#materialOverworldCut').html('')
    for e in Game.materialOverworldCutViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworldCut').append("#{material.materialName}: #{num}<br />")
      )(e)

    $('#materialOre').html('')
    for e in Game.materialOreViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOre').append("#{material.materialName}: #{num}<br />")
      )(e)

    $('#materialRaw').html('')
    for e in Game.materialRawViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialRaw').append("<button>-&gt;10</button>")
        $('#materialRaw button:last').click(-> Game.tryToProcessMaterial(e, 1))
        $('#materialRaw').append("<button>-&gt;100</button>")
        $('#materialRaw button:last').click(-> Game.tryToProcessMaterial(e, 10))
        $('#materialRaw').append("#{material.materialName}: #{num}<br />")
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
    for e in Game.recipeList.normal
      ((e) =>
        $('#recipe').append("<button>#{e.output.name}</button>")
        $('#recipe button:last').click(-> Game.tryToCraft(e))
      )(e)

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
        $('#itemStock button:last').click(-> Game.useItem(i))
      )(e, i)

module.exports = View
