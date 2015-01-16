$ = require('jquery')

Material = require('./Material.coffee')
OreVein = require('./OreVein.coffee')

class Game
  @logger: require('./Logger.coffee')

  @material = []
  @materialList = require('./MaterialList.coffee')
  @item = []
  @itemList = require('./ItemList.coffee')

  @materialOverworldViewList = [
    @materialList.id.stone
    @materialList.id.woodStick
  ]

  @materialOverworldIgnoreList = []

  @materialOreViewList = [
    @materialList.id.oreCoal
    @materialList.id.oreIron
    @materialList.id.oreCopper
    @materialList.id.oreTin
    @materialList.id.oreBauxite
    @materialList.id.oreNickel
    @materialList.id.oreGold
    @materialList.id.orePlatinum
    @materialList.id.oreDiamond
  ]

  @materialRawViewList = [
    @materialList.id.rawCoal
    @materialList.id.rawIron
    @materialList.id.rawCopper
    @materialList.id.rawTin
    @materialList.id.rawBauxite
    @materialList.id.rawNickel
    @materialList.id.rawGold
    @materialList.id.rawPlatinum
    @materialList.id.rawDiamond
  ]

  @oreVein = [
    new OreVein(0, 10)
  ]

  @recipeList = require('./RecipeList.coffee')

  @overworldStuffFinder = require('./OverworldStuffFinder.coffee')
  @oreVeinFinder = require('./OreVeinFinder.coffee')
  
  @MODE_SEARCHING_OVERWORLD = 1
  @MODE_SEARCHING_UNDERGROUND = 2
  @MODE_MINING = 3
  @mode: 0

  @miningTarget: 0

  @time: 0

  @init: ->
    @materialList.init()
    for e, i in @materialList.material
      @material[i] = 0
    @itemList.init()
    @recipeList.init()

    @overworldStuffFinder.init()
    @oreVeinFinder.init()

    $('#modeChange1').click(=> @mode = 1)
    $('#modeChange2').click(=> @mode = 2)
    $('#modeChange3').click(=> @mode = 3)

    @refreshRecipeList()
    @refreshMaterialList()
    @refreshOreVeinList()
    @refreshItemList()

  @action: =>
    @time++
    $('#time').text("Time: #{@time} Mode: #{@mode} Target: #{@miningTarget}")
    
    switch @mode
      when @MODE_SEARCHING_OVERWORLD
        @overworldStuffFinder.try()
        @refreshMaterialList()
      when @MODE_SEARCHING_UNDERGROUND
        @oreVeinFinder.try()
        @refreshOreVeinList()
      when @MODE_MINING
        e = @oreVein[@miningTarget]
        mineAmount = 1
        e.remain -= mineAmount
        @material[e.materialId] += mineAmount
        @refreshMaterialList()
        @refreshOreVeinList()
        @refreshItemList()

  @refreshMaterialList: ->
    $('#materialOverworld').html('')
    for e in @materialOverworldViewList
      ((e) =>
        material = @materialList.material[e]
        num = @material[e]
        $('#materialOverworld').append("<input type=\"checkbox\">#{material.materialName}: #{num}<br />")

        # Check state
        $('#materialOverworld input:last').attr('checked', @materialOverworldIgnoreList.indexOf(e) != -1)
        that = @
        $('#materialOverworld input:last').change(->
          if $(@).is(':checked')
            that.materialOverworldIgnoreList.push(e)
          else
            for e2, i in that.materialOverworldIgnoreList
              if e2 == e then that.materialOverworldIgnoreList.splice(i, 1)
        )
      )(e)

    $('#materialOre').html('')
    for e in @materialOreViewList
      material = @materialList.material[e]
      num = @material[e]
      $('#materialOre').append("#{material.materialName}: #{num}<br />")

    $('#materialRaw').html('')
    for e in @materialRawViewList
      material = @materialList.material[e]
      num = @material[e]
      $('#materialRaw').append("#{material.materialName}: #{num}<br />")

  @refreshOreVeinList: ->
    $('#oreVein').html('')
    for e, i in @oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{@materialList.material[e.materialId].materialName}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click( =>
          @miningTarget = i
          @mode = @MODE_MINING
        )
      )(e, i)

  @refreshRecipeList: ->
    $('#recipe').html('')
    for e in @recipeList.normal
      ((e) =>
        $('#recipe').append("<button>#{e.output.name}</button>")
        $('#recipe button:last').click(=>
          e.craft()
        )
      )(e)

  @refreshItemList: ->
    $('#item').html('')
    for e in @item
      $('#item').append("#{e.name}<br />")

module.exports = Game
