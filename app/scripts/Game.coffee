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
    @materialList.id.coal
    @materialList.id.iron
    @materialList.id.copper
    @materialList.id.tin
    @materialList.id.bauxite
    @materialList.id.nickel
    @materialList.id.gold
    @materialList.id.platinum
    @materialList.id.diamond
 ]

  @materialRawViewList = [
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
      $('#materialOre').append("#{material.name}: #{num}<br />")

    $('#materialRaw').html('')
    for e in @materialRawViewList
      material = @materialList.material[e]
      num = @material[e]
      $('#materialRaw').append("#{material.name}: #{num}<br />")

    $('#oreVein').html('')
    for e, i in @oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{@materialList.material[e.materialId].name}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click( =>
          @miningTarget = i
          @mode = @MODE_MINING
        )
      )(e, i)

module.exports = Game
