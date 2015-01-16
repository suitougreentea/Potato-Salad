$ = require('jquery')

Material = require('./Material.coffee')
OreVein = require('./OreVein.coffee')

class Game
  @logger: require('./Logger.coffee')

  @material = [
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
    0
  ]
  @materialList = require('./MaterialList.coffee')

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

  @oreVeinFinder = require('./OreVeinFinder.coffee')
  
  @MODE_SEARCHING_OVERWORLD = 1
  @MODE_SEARCHING_UNDERGROUND = 2
  @MODE_MINING = 3
  @mode: 0

  @miningTarget: 0

  @time: 0

  @init: ->
    @oreVeinFinder.init()

    $('#modeChange1').click(=> @mode = 1)
    $('#modeChange2').click(=> @mode = 2)
    $('#modeChange3').click(=> @mode = 3)

  @action: =>
    @time++
    $('#time').text("Time: #{@time} Mode: #{@mode} Target: #{@miningTarget}")
    
    switch @mode
      when @MODE_SEARCHING_UNDERGROUND
        @oreVeinFinder.try()
      when @MODE_MINING
        e = @oreVein[@miningTarget]
        mineAmount = 1
        e.remain -= mineAmount
        @material[e.materialId] += mineAmount

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

    $('#oreVein').html('')
    for e, i in @oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{@materialList.material[e.materialId].materialName}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click( =>
          @miningTarget = i
          @mode = @MODE_MINING
        )
      )(e, i)

module.exports = Game
