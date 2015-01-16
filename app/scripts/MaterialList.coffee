Material = require('./Material.coffee')
MaterialOre = require('./MaterialOre.coffee')
MaterialRaw = require('./MaterialRaw.coffee')
MaterialNormal = require('./MaterialNormal.coffee')
Processing = require('./Processing.coffee')

class MineProcessing
  @init: ->
    @coal      = new Processing([[Game.materialList.id.oreCoal,     15]])
    @iron      = new Processing([[Game.materialList.id.oreIron,     15]])
    @copper    = new Processing([[Game.materialList.id.oreCopper,   15]])
    @tin       = new Processing([[Game.materialList.id.oreTin,      15]])
    @aluminium = new Processing([[Game.materialList.id.oreBauxite,  15]])
    @nickel    = new Processing([[Game.materialList.id.oreNickel,   15]])
    @gold      = new Processing([[Game.materialList.id.oreGold,     15]])
    @platinum  = new Processing([[Game.materialList.id.orePlatinum, 15]])
    @diamond   = new Processing([[Game.materialList.id.oreDiamond,  15]])

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

  @material: []

  @init: ->
    MineProcessing.init()
    @register @id.oreCoal,     new MaterialOre('Coal')
    @register @id.oreIron,     new MaterialOre('Iron')
    @register @id.oreCopper,   new MaterialOre('Copper')
    @register @id.oreTin,      new MaterialOre('Tin')
    @register @id.oreBauxite,  new MaterialOre('Bauxite')
    @register @id.oreNickel,   new MaterialOre('Nickel')
    @register @id.oreGold,     new MaterialOre('Gold')
    @register @id.orePlatinum, new MaterialOre('Platinum')
    @register @id.oreDiamond,  new MaterialOre('Diamond')
    @register @id.rawCoal,     new MaterialRaw('Coal', MineProcessing.coal)
    @register @id.rawIron,     new MaterialRaw('Iron', MineProcessing.iron)
    @register @id.rawCopper,   new MaterialRaw('Copper', MineProcessing.copper)
    @register @id.rawTin,      new MaterialRaw('Tin', MineProcessing.tin)
    @register @id.rawAluminium,new MaterialRaw('Aluminium', MineProcessing.aluminium)
    @register @id.rawNickel,   new MaterialRaw('Nickel', MineProcessing.nickel)
    @register @id.rawGold,     new MaterialRaw('Gold', MineProcessing.gold)
    @register @id.rawPlatinum, new MaterialRaw('Platinum', MineProcessing.platinum)
    @register @id.rawDiamond,  new MaterialRaw('Diamond', MineProcessing.diamond)
    @register @id.woodStick,   new MaterialNormal('Wood stick')
    @register @id.stone,       new MaterialNormal('Stone')

  @register: (id, material) -> @material[id] = material

module.exports = MaterialList
