ProcessorHand = require('./ProcessorHand.coffee')
ProcessorToolbox = require('./ProcessorToolbox.coffee')
ProcessorFurnace = require('./ProcessorFurnace.coffee')

class ProcessorList
  @id:
    furnace1: 0
    
  @processor: []
  @init: () ->
    @processor[@id.furnace1] = new ProcessorFurnace(@id.furnace1)

module.exports = ProcessorList
