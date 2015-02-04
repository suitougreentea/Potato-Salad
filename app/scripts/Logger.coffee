$ = require('jquery')

class Logger
  @log: (str) ->
    console.log("[#{Game.time}] #{str}")
    $('#painLog').append("[#{Game.time}] #{str}<br />")
    $('#painLog').scrollTop($('#painLog')[0].scrollHeight)

module.exports = Logger
