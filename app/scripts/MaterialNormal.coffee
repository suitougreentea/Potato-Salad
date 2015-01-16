Material = require('./Material.coffee')

class MaterialNormal extends Material
  constructor: (materialName, processing) -> super(materialName, materialName, processing)

module.exports = MaterialNormal
