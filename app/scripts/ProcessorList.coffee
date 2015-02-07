ProcessorHand = require('./ProcessorHand.coffee')
ProcessorToolbox = require('./ProcessorToolbox.coffee')
ProcessorFurnace = require('./ProcessorFurnace.coffee')

class ProcessorList
  @id:
    hand: 0
    furnace1: 1
    
  @processor: []
  @init: () ->
    @processor[@id.hand] = new ProcessorHand()
    @processor[@id.furnace1] = new ProcessorFurnace()

module.exports = ProcessorList
