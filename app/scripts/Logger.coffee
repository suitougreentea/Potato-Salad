class Logger
  @log: (str) ->
    console.log("[#{Game.time}] #{str}")

module.exports = Logger
