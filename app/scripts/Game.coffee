$ = require('jquery')
require('perfect-scrollbar')

Material = require('./Material.coffee')
OreVein = require('./OreVein.coffee')

class Game
  @logger: require('./Logger.coffee')
  @save: require('./Save.coffee')

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

  @materialViewList = require('./MaterialViewList.coffee')

  @materialOverworldIgnoreList = []

  @oreVein = [
    new OreVein(0, 10)
  ]

  @processorList = require('./ProcessorList.coffee')

  @overworldStuffFinder = require('./OverworldStuffFinder.coffee')
  @oreVeinFinder = require('./OreVeinFinder.coffee')
  
  @MODE_SEARCHING_OVERWORLD = 1
  @MODE_SEARCHING_UNDERGROUND = 2
  @MODE_MINING = 3
  @mode: 0
  @modeString: ['working in your factory', 'searching overground', 'searching underground', 'mining ore vein']

  @miningTarget: 0

  @time: 0

  @view: require('./View.coffee')

  @init: ->
    @materialList.init()
    @materialViewList.init()
    for e, i in @materialList.material
      @material[i] = 0
    @itemList.init()
    @processorList.init()
    @overworldStuffFinder.init()
    @oreVeinFinder.init()

    @material[@materialList.id.oreCoal] = 1000
    @material[@materialList.id.woodStick] = 1000
    @material[@materialList.id.stone] = 1000
    
    @onResizeWindow()

    $(window).resize => @onResizeWindow()

    for i in [0..6]
      ((i) =>
        that = @
        $(".menuItem:nth-child(#{i + 1})").click( ->
          $('.menuItem').removeClass('menuItemActive')
          $(@).addClass('menuItemActive')
          that.view.toggleTab(i)
        )
      )(i)
    $('.menuItem:first').addClass('menuItemActive')
    @view.toggleTab(0)

    @save.load()
    @view.refreshStatus()
    @view.refreshRecipeList()
    @view.refreshMaterialList()
    @view.refreshOreVeinList()
    @view.refreshItemList()

  @action: =>
    @time++
    @view.refreshStatus()
    for e in @processorList.processor
      e.update()
    
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
    if item.use()
      @item.splice(index, 1)
      @view.refreshItemList()

  @formatNumber: (num) ->
    return num.toFixed(2)

  @onResizeWindow: () ->
    width = $(window).width()
    height = $(window).height()
    console.log "Window resized: (#{width}, #{height})"
    leftWidth = 270
    logHeight = 120
    headerHeight = 128
    itemHeight = 48 * 3
    $('#painLeft').css(top: 0, left: 0).width(leftWidth).height(height)
    $('#itemStock').height(itemHeight)
    $('#materialStock').height(height - itemHeight - 32 * 2)
    $('#painHeader').css(top: 0, left: leftWidth).width(width - leftWidth).height(headerHeight)
    $('#painMain').css(top: headerHeight, left: leftWidth).width(width - leftWidth).height(height - logHeight - headerHeight)
    $('#painLog').css(top: height - logHeight, left: leftWidth).width(width - leftWidth).height(logHeight)

module.exports = Game
