base64 = require('base-64')

class Save
  @save: ->
    data = @getData()
    Game.logger.log('Start saving')
    console.log data
    localStorage.setItem('PSDevSave', base64.encode(JSON.stringify(data)))
    Game.logger.log('Finish saving')
    return

  @load: ->
    Game.logger.log('Start loading')
    encode = localStorage.getItem('PSDevSave')
    data = JSON.parse(base64.decode(encode))
    console.log data
    @setData(data)
    Game.logger.log('Finish loading')
    return

  @getData: ->
    result = {}

    result.material = Game.material
    result.item = Game.item

    return result

  @setData: (data) ->
    if data.material then Game.material = data.material
    if data.item then Game.item = data.item

module.exports = Save
