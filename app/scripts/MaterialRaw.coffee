Material = require('./Material.coffee')

class MaterialRaw extends Material
  constructor: (materialName, processing) -> super("Raw #{materialName}", materialName, processing)

module.exports = MaterialRaw
