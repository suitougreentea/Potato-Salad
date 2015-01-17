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
    @materialList.id.rawAluminium
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

  @view: require('./View.coffee')

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

    @view.refreshRecipeList()
    @view.refreshMaterialList()
    @view.refreshOreVeinList()
    @view.refreshItemList()

  @action: =>
    @time++
    $('#time').text("Time: #{@time} Mode: #{@mode} Target: #{@miningTarget}")
    
    switch @mode
      when @MODE_SEARCHING_OVERWORLD
        @overworldStuffFinder.try()
        @view.refreshMaterialList()
      when @MODE_SEARCHING_UNDERGROUND
        @oreVeinFinder.try()
        @view.refreshOreVeinList()
      when @MODE_MINING
        e = @oreVein[@miningTarget]
        mineAmount = 1
        e.remain -= mineAmount
        @material[e.materialId] += mineAmount
        @view.refreshMaterialList()
        @view.refreshOreVeinList()
        @view.refreshItemList()


module.exports = Game
