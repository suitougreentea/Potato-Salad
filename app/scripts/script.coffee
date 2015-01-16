$ = require('jquery')

$( ->
  console.log('Loading')
  window.Game = require('./Game.coffee')
  Game.init()
  console.log('Start')
  actionIntervalId = setInterval(Game.action, 1000)
)
