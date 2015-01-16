Material = require('./Material.coffee')

class MaterialList
  @id:
    coal: 0
    iron: 1
    copper: 2
    tin: 3
    bauxite: 4
    nickel: 5
    gold: 6
    platinum: 7
    diamond: 8
  #  @init: ->
  #  new Game.class.Material('Iron')
  @material: [
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

module.exports = MaterialList
