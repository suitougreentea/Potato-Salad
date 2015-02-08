class OverworldStuffFinder
  @init: ->
    list = Game.materialList
    @data = [
      [list.id.stone, 0.2]
      [list.id.woodStick, 0.2]
    ]

  @tryToPick: ->
    target = []
    for e, i in @data
      [id, chance] = e
      if Math.random() < chance
        target.push(i)

    if target.length > 0
      index = target[Math.floor(Math.random() * target.length)]
      [id, change] = @data[index]
      Game.material[id] += 1
      if Game.pickNotifyList[index]
        Game.logger.log("Picked up #{Game.materialList.material[id].fullName}!")
      Game.view.refresh(Game.view.MATERIAL)

  @tryToDig: ->
    Game.material[Game.materialList.id.dirt] += 1
    Game.view.refresh(Game.view.MATERIAL)

  @tryToCut: ->
    if Math.random() < 0.1
      Game.logger.log("Cut down a wood!")
      Game.material[Game.materialList.id.wood] += 20
      Game.view.refresh(Game.view.MATERIAL)

module.exports = OverworldStuffFinder
