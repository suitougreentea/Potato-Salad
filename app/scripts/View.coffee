$ = require('jquery')

class View
  @refreshStatus: ->
    $('#time').text("Time: #{Game.time} Mode: #{Game.mode} Target: #{Game.miningTarget} Using: #{Game.using}")
    
  @refreshMaterialList: ->
    $('#materialOverworldPick').html('')
    for e in Game.materialOverworldViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworldPick').append("<input type=\"checkbox\">#{material.materialName}: #{num}<br />")

        # Check state
        $('#materialOverworldPick input:last').attr('checked', Game.materialOverworldIgnoreList.indexOf(e) != -1)
        $('#materialOverworldPick input:last').change(-> Game.changeIgnoreCheckbox($(@).is(':checked'), e))
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
    $('#itemHave button:last').click(-> Game.using = Game.USING_NONE)
    if Game.have.shovel
      $('#itemHave').append("Shovel:<button>#{Game.have.shovel.name}</button>")
      $('#itemHave button:last').click(-> Game.using = Game.USING_SHOVEL)
    if Game.have.axe
      $('#itemHave').append("Axe:<button>#{Game.have.axe.name}</button>")
      $('#itemHave button:last').click(-> Game.using = Game.USING_AXE)
    if Game.have.pickaxe
      $('#itemHave').append("Pickaxe:<button>#{Game.have.pickaxe.name}</button>")
      $('#itemHave button:last').click(-> Game.using = Game.USING_PICKAXE)

    $('#itemStock').html('')
    for e, i in Game.item
      ((e, i) ->
        $('#itemStock').append("<button>#{e.name}</button>")
        $('#itemStock button:last').click(-> Game.useItem(i))
      )(e, i)

module.exports = View
