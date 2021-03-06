Material = require('./Material.coffee')
MaterialOre = require('./MaterialOre.coffee')
MaterialRaw = require('./MaterialRaw.coffee')
MaterialNormal = require('./MaterialNormal.coffee')

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
    rawAluminium: 13
    rawNickel: 14
    rawGold: 15
    rawPlatinum: 16
    rawDiamond: 17
    woodStick: 18
    stone: 19
    dirt: 20
    wood: 21

  @material: []

  @init: ->
    @register @id.oreCoal,      new MaterialOre('Coal')
    @register @id.oreIron,      new MaterialOre('Iron')
    @register @id.oreCopper,    new MaterialOre('Copper')
    @register @id.oreTin,       new MaterialOre('Tin')
    @register @id.oreBauxite,   new MaterialOre('Bauxite')
    @register @id.oreNickel,    new MaterialOre('Nickel')
    @register @id.oreGold,      new MaterialOre('Gold')
    @register @id.orePlatinum,  new MaterialOre('Platinum')
    @register @id.oreDiamond,   new MaterialOre('Diamond')
    @register @id.rawCoal,      new MaterialRaw('Coal')
    @register @id.rawIron,      new MaterialRaw('Iron')
    @register @id.rawCopper,    new MaterialRaw('Copper')
    @register @id.rawTin,       new MaterialRaw('Tin')
    @register @id.rawAluminium, new MaterialRaw('Aluminium')
    @register @id.rawNickel,    new MaterialRaw('Nickel')
    @register @id.rawGold,      new MaterialRaw('Gold')
    @register @id.rawPlatinum,  new MaterialRaw('Platinum')
    @register @id.rawDiamond,   new MaterialRaw('Diamond')
    @register @id.woodStick,    new MaterialNormal('Wood stick')
    @register @id.stone,        new MaterialNormal('Stone')
    @register @id.dirt,         new MaterialNormal('Dirt')
    @register @id.wood,         new MaterialNormal('Wood')

  @register: (id, material) -> @material[id] = material

module.exports = MaterialList
