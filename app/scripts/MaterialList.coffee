Material = require('./Material.coffee')
MaterialOre = require('./MaterialOre.coffee')

class MaterialList
  @id:
    oreCoal: 0
    oreIron: 1
    oreCopper: 2
    oreTin: 3
    oreBauxite: 4
    oreNickel: 5
    oreGold: 6
    orePlatinum: 7
    oreDiamond: 8
  #  @init: ->
  #  new Game.class.Material('Iron')
  @material: [
    new MaterialOre('Coal')
    new MaterialOre('Iron')
    new MaterialOre('Copper')
    new MaterialOre('Tin')
    new MaterialOre('Bauxite')
    new MaterialOre('Nickel')
    new MaterialOre('Gold')
    new MaterialOre('Platinum')
    new MaterialOre('Diamond')
  ]

module.exports = MaterialList
