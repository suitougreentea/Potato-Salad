Material = require('./Material.coffee')

class MaterialRaw extends Material
  constructor: (materialName) -> super(materialName, materialName)

module.exports = MaterialRaw
