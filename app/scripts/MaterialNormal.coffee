Material = require('./Material.coffee')

class MaterialNormal extends Material
  constructor: (materialName) -> super(materialName, materialName)

module.exports = MaterialNormal
