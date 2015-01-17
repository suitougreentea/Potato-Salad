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

    @material[@materialList.id.oreCoal] = 100

    $('#modeChange1').click(=> @mode = 1)
    $('#modeChange2').click(=> @mode = 2)
    $('#modeChange3').click(=> @mode = 3)

    @view.refreshStatus()
    @view.refreshRecipeList()
    @view.refreshMaterialList()
    @view.refreshOreVeinList()
    @view.refreshItemList()

  @action: =>
    @time++
    @view.refreshStatus()
    
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

  @tryToProcessMaterial: (materialId, times) =>
    material = @materialList.material[materialId]
    processing = material.processing
    for source in processing.requiredMaterial
      [id, amount] = source
      if @material[id] < amount
        @logger.log('Not enough material')
        return
      for source in processing.requiredMaterial
        [id, amount] = source
        @material[id] -= amount
        @material[materialId] += 10
        @view.refreshMaterialList()

  @tryToCraft: (recipe) ->
    for e in recipe.requiredMaterial
      [materialId, amount] = e
      if @material[materialId] < amount
        @logger.log('Not enough material')
        return

    for e in recipe.requiredMaterial
      [materialId, amount] = e
      @material[materialId] -= amount

    @item.push(recipe.output)
    @logger.log('Craft complete')
    @view.refreshMaterialList()
    @view.refreshItemList()

  @tryToStartMining: (target) ->
    if false # do not have pickaxe
      @logger.log('No pickaxe')
      return
    @miningTarget = target
    @mode = Game.MODE_MINING
    @view.refreshStatus()

  @changeIgnoreCheckbox: (checked, materialId) ->
    if checked
      if Game.materialOverworldIgnoreList.indexOf(materialId) == -1
        Game.materialOverworldIgnoreList.push(materialId)
    else
      for e, i in Game.materialOverworldIgnoreList
        if e == materialId then Game.materialOverworldIgnoreList.splice(i, 1)

module.exports = Game
