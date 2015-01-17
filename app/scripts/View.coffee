$ = require('jquery')

class View
  @refreshStatus: ->
    $('#time').text("Time: #{Game.time} Mode: #{Game.mode} Target: #{Game.miningTarget}")
    
  @refreshMaterialList: ->
    $('#materialOverworld').html('')
    for e in Game.materialOverworldViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworld').append("<input type=\"checkbox\">#{material.materialName}: #{num}<br />")

        # Check state
        $('#materialOverworld input:last').attr('checked', Game.materialOverworldIgnoreList.indexOf(e) != -1)
        $('#materialOverworld input:last').change(-> Game.changeIgnoreCheckbox($(@).is(':checked'), e))
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
        $('#materialRaw').append("<button>10</button>#{material.materialName}: #{num}<br />")
        $('#materialRaw button:last').click(-> Game.tryToProcessMaterial(e, 1))
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
    $('#item').html('')
    for e in Game.item
      $('#item').append("#{e.name}<br />")

module.exports = View
