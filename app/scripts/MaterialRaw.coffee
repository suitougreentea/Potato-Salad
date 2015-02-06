Material = require('./Material.coffee')

class MaterialRaw extends Material
  constructor: (materialName) -> super("Raw #{materialName}", materialName, [['sIngot', 'sMaterialGold']])

module.exports = MaterialRaw
