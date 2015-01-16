Material = require('./Material.coffee')

class MaterialOre extends Material
  constructor: (materialName) -> super("#{materialName} Ore", materialName)

module.exports = MaterialOre
