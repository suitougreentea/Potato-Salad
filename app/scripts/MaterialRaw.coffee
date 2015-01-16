Material = require('./Material.coffee')

class MaterialRaw extends Material
  constructor: (materialName) -> super("Raw #{materialName}", materialName)

module.exports = MaterialRaw
