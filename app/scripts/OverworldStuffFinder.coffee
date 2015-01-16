class OverworldStuffFinder
  @init: ->
    list = Game.materialList
    @data = [
      [list.id.stone, 0.2]
      [list.id.woodStick, 0.2]
    ]

  @try: ->
    target = []
    for e in @data
      [id, chance] = e
      if Math.random() < chance
        target.push(e)

    if target.length > 0
      result = target[Math.floor(Math.random() * target.length)]
      [id, change] = result
      if Game.materialOverworldIgnoreList.indexOf(id) == -1
        Game.logger.log("Picked up #{Game.materialList.material[id].fullName}!")
        Game.material[id] += 1

module.exports = OverworldStuffFinder
