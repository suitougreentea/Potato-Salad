class MaterialViewList
  @init: ->
    _ = Game.materialList.id
    @data = [
      {
        name: 'Overworld'
        list: [
          _.stone
          _.woodStick
          _.dirt
          _.wood
        ]
      }
      {
        name: 'Ore'
        list: [
          _.oreCoal
          _.oreIron
          _.oreCopper
          _.oreTin
          _.oreBauxite
          _.oreNickel
          _.oreGold
          _.orePlatinum
          _.oreDiamond
        ]
      }
      {
        name: 'Raw Mineral'
        list: [
          _.rawCoal
          _.rawIron
          _.rawCopper
          _.rawTin
          _.rawAluminium
          _.rawNickel
          _.rawGold
          _.rawPlatinum
          _.rawDiamond
        ]
      }
    ]

module.exports = MaterialViewList
