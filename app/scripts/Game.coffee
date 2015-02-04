$ = require('jquery')
require('perfect-scrollbar')

Material = require('./Material.coffee')
OreVein = require('./OreVein.coffee')

class Game
  @logger: require('./Logger.coffee')

  @material = []
  @materialList = require('./MaterialList.coffee')
  @item = []
  @itemList = require('./ItemList.coffee')

  @have = {
    shovel: null
    axe: null
    pickaxe: null
  }
  @USING_NONE = 0
  @USING_SHOVEL = 1
  @USING_AXE = 2
  @USING_PICKAXE = 3
  @using = 0

  @materialOverworldPickViewList = [
    @materialList.id.stone
    @materialList.id.woodStick
  ]
  @materialOverworldDigViewList = [
    @materialList.id.dirt
  ]
  @materialOverworldCutViewList = [
    @materialList.id.wood
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

    @material[@materialList.id.oreCoal] = 1000
    @material[@materialList.id.woodStick] = 1000
    @material[@materialList.id.stone] = 1000
    
    @onResizeWindow()

    $(window).resize => @onResizeWindow()

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
        switch @using
          when @USING_NONE
            @overworldStuffFinder.tryToPick()
          when @USING_SHOVEL
            @overworldStuffFinder.tryToDig()
          when @USING_AXE
            @overworldStuffFinder.tryToCut()
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
      if @material[id] < amount * times
        @logger.log('Not enough material')
        return
      for source in processing.requiredMaterial
        [id, amount] = source
        @material[id] -= amount * times
        @material[materialId] += 10 * times
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
    if !@have.pickaxe
      @logger.log('No pickaxe')
      return
    @using = @USING_PICKAXE
    @miningTarget = target
    @mode = Game.MODE_MINING
    @view.refreshStatus()

  @tryToGoUnderground: ->
    if !@have.pickaxe
      @logger.log('No pickaxe')
      return
    @using = @USING_PICKAXE
    @mode = Game.MODE_SEARCHING_UNDERGROUND
    @view.refreshStatus()

  @tryToPick: ->
    @using = @USING_NONE
    @mode = Game.MODE_SEARCHING_OVERWORLD
    @view.refreshStatus()

  @tryToDig: ->
    if !@have.shovel
      @logger.log('No shovel')
      return
    @using = @USING_SHOVEL
    @mode = Game.MODE_SEARCHING_OVERWORLD
    @view.refreshStatus()

  @tryToCut: ->
    if !@have.axe
      @logger.log('No axe')
      return
    @using = @USING_AXE
    @mode = Game.MODE_SEARCHING_OVERWORLD
    @view.refreshStatus()

  @changeIgnoreCheckbox: (checked, materialId) ->
    if checked
      if Game.materialOverworldIgnoreList.indexOf(materialId) == -1
        Game.materialOverworldIgnoreList.push(materialId)
    else
      for e, i in Game.materialOverworldIgnoreList
        if e == materialId then Game.materialOverworldIgnoreList.splice(i, 1)

  @useItem: (index) ->
    item = @item[index]
    switch item.type
      when @itemList.TYPE_SHOVEL
        @have.shovel = item
      when @itemList.TYPE_AXE
        @have.axe = item
      when @itemList.TYPE_PICKAXE
        @have.pickaxe = item
    @item.splice(index, 1)
    @view.refreshItemList()

  @onResizeWindow: () ->
    width = $(window).width()
    height = $(window).height()
    console.log "Window resized: (#{width}, #{height})"
    leftWidth = 270
    logHeight = 120
    $('#painLeft').css(top: 0, left: 0).width(leftWidth).height(height)
    $('#painMain').css(top: 0, left: leftWidth).width(width - leftWidth).height(height - logHeight)
    $('#painLog').css(top: height - logHeight, left: leftWidth).width(width - leftWidth).height(logHeight)

module.exports = Game
