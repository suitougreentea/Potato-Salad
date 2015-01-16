Material = require('./Material.coffee')

class OreVeinFinder
  @init: ->
    @data = [
      [Material.id.coal,     0.5,   10, 2]
      [Material.id.iron,     0.002,   10, 2]
      [Material.id.copper,   0.003,   10, 2]
      [Material.id.tin,      0.002,   10, 2]
      [Material.id.bauxite,  0.004,   10, 2]
      [Material.id.nickel,   0.001,   10, 2]
      [Material.id.gold,     0.0001,  10, 2]
      [Material.id.platinum, 0.00005, 10, 2]
      [Material.id.diamond,  0.00005, 10, 2]
    ]

  @try: ->
    for e in @data
      [material, chance, size, size_modifier] = e
      if Math.random() < chance
        Game.logger.log("Found #{Game.material[material].name} vein!")
        break


module.exports = OreVeinFinder
