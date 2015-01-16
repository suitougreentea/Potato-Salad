Material = require('./Material.coffee')
MaterialOre = require('./MaterialOre.coffee')
MaterialRaw = require('./MaterialRaw.coffee')

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
    rawCoal: 9
    rawIron: 10
    rawCopper: 11
    rawTin: 12
    rawBauxite: 13
    rawNickel: 14
    rawGold: 15
    rawPlatinum: 16
    rawDiamond: 17
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
    new MaterialRaw('Coal')
    new MaterialRaw('Iron')
    new MaterialRaw('Copper')
    new MaterialRaw('Tin')
    new MaterialRaw('Bauxite')
    new MaterialRaw('Nickel')
    new MaterialRaw('Gold')
    new MaterialRaw('Platinum')
    new MaterialRaw('Diamond')
  ]

module.exports = MaterialList
