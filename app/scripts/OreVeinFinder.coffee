OreVein = require('./OreVein.coffee')

class OreVeinFinder
  @init: ->
    _ = Game.materialList.id
    @data = [
      [_.oreCoal,     0.005,   10, 2]
      [_.oreIron,     0.002,   10, 2]
      [_.oreCopper,   0.003,   10, 2]
      [_.oreTin,      0.002,   10, 2]
      [_.oreBauxite,  0.004,   10, 2]
      [_.oreNickel,   0.001,   10, 2]
      [_.oreGold,     0.0001,  10, 2]
      [_.orePlatinum, 0.00005, 10, 2]
      [_.oreDiamond,  0.00005, 10, 2]
    ]

  @try: ->
    target = []
    for e in @data
      [id, chance, size, size_modifier] = e
      if Math.random() < chance
        target.push(e)

    if target.length > 0
      result = target[Math.floor(Math.random() * target.length)]
      [id, change] = result
      Game.logger.log("Found #{Game.materialList.material[id].materialName} vein!")
      Game.oreVein.push(new OreVein(id, Math.round(size + Math.random() * (size_modifier * 2) - size_modifier)))
      Game.view.refresh(Game.view.OREVEIN)

module.exports = OreVeinFinder
