OreVein = require('./OreVein.coffee')

class OreVeinFinder
  @init: ->
    list = Game.materialList
    @data = [
      [list.id.coal,     0.005,   10, 2]
      [list.id.iron,     0.002,   10, 2]
      [list.id.copper,   0.003,   10, 2]
      [list.id.tin,      0.002,   10, 2]
      [list.id.bauxite,  0.004,   10, 2]
      [list.id.nickel,   0.001,   10, 2]
      [list.id.gold,     0.0001,  10, 2]
      [list.id.platinum, 0.00005, 10, 2]
      [list.id.diamond,  0.00005, 10, 2]
    ]

  @try: ->
    for e in @data
      [id, chance, size, size_modifier] = e
      if Math.random() < chance
        Game.logger.log("Found #{Game.materialList[id].name} vein!")
        Game.oreVein.push(new OreVein(id, Math.round(size + Math.random() * (size_modifier * 2) - size_modifier)))
        break


module.exports = OreVeinFinder
