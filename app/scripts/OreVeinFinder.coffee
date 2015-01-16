OreVein = require('./OreVein.coffee')

class OreVeinFinder
  @init: ->
    list = Game.materialList
    @data = [
      [list.id.oreCoal,     0.005,   10, 2]
      [list.id.oreIron,     0.002,   10, 2]
      [list.id.oreCopper,   0.003,   10, 2]
      [list.id.oreTin,      0.002,   10, 2]
      [list.id.oreBauxite,  0.004,   10, 2]
      [list.id.oreNickel,   0.001,   10, 2]
      [list.id.oreGold,     0.0001,  10, 2]
      [list.id.orePlatinum, 0.00005, 10, 2]
      [list.id.oreDiamond,  0.00005, 10, 2]
    ]

  @try: ->
    for e in @data
      [id, chance, size, size_modifier] = e
      if Math.random() < chance
        Game.logger.log("Found #{Game.materialList.material[id].materialName} vein!")
        Game.oreVein.push(new OreVein(id, Math.round(size + Math.random() * (size_modifier * 2) - size_modifier)))
        break


module.exports = OreVeinFinder
