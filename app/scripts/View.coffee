$ = require('jquery')

class View
  @refreshMaterialList: ->
    $('#materialOverworld').html('')
    for e in Game.materialOverworldViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworld').append("<input type=\"checkbox\">#{material.materialName}: #{num}<br />")

        # Check state
        $('#materialOverworld input:last').attr('checked', Game.materialOverworldIgnoreList.indexOf(e) != -1)
        $('#materialOverworld input:last').change(->
          if $(@).is(':checked')
            Game.materialOverworldIgnoreList.push(e)
          else
            for e2, i in Game.materialOverworldIgnoreList
              if e2 == e then Game.materialOverworldIgnoreList.splice(i, 1)
        )
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
        $('#materialRaw button:last').click( =>
          p = material.processing
          for source in p.requiredMaterial
            [id, amount] = source
            if Game.material[id] < amount
              Game.logger.log('Not enough material')
              return
          for source in p.requiredMaterial
            [id, amount] = source
            Game.material[id] -= amount
          Game.material[e] += 10
          @refreshMaterialList()
        )
      )(e)

  @refreshOreVeinList: ->
    $('#oreVein').html('')
    for e, i in Game.oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{Game.materialList.material[e.materialId].materialName}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click( =>
          Game.miningTarget = i
          Game.mode = Game.MODE_MINING
        )
      )(e, i)

  @refreshRecipeList: ->
    $('#recipe').html('')
    for e in Game.recipeList.normal
      ((e) =>
        $('#recipe').append("<button>#{e.output.name}</button>")
        $('#recipe button:last').click(=>
          e.craft()
        )
      )(e)

  @refreshItemList: ->
    $('#item').html('')
    for e in Game.item
      $('#item').append("#{e.name}<br />")



module.exports = View
