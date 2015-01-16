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
  ]
  @materialList = [
    new Material('Coal')
    new Material('Iron')
    new Material('Copper')
    new Material('Tin')
    new Material('Bauxite')
    new Material('Nickel')
    new Material('Gold')
    new Material('Platinum')
    new Material('Diamond')
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

    $('#material').html(@material.reduce( ((base, e, i) =>
      return base + "#{@materialList[i].name}: #{e}<br />"
    ), ''))
    $('#oreVein').html('')
    for e, i in @oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{@materialList[e.materialId].name}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click( =>
          @miningTarget = i
          @mode = @MODE_MINING
        )
      )(e, i)

module.exports = Game
