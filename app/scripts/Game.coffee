$ = require('jquery')

Material = require('./Material.coffee')
OreVein = require('./OreVein.coffee')

class Game
  @logger: require('./Logger.coffee')

  @material = [
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

  @oreVeinFinder = require('./OreVeinFinder.coffee')

  @time:  0

  @init: ->
    @oreVeinFinder.init()

  @action: =>
    @time++
    $('#time').text("Time: #{@time}")
    @oreVeinFinder.try()

module.exports = Game
