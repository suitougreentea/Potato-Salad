ProcessorHand = require('./ProcessorHand.coffee')
ProcessorToolbox = require('./ProcessorToolbox.coffee')
ProcessorFurnace = require('./ProcessorFurnace.coffee')

class ProcessorList
  @id:
    hand: 0
    toolBox1: 1
    furnace1: 2
    
  @processor: []
  @init: () ->
    @processor[@id.hand] = new ProcessorHand()
    @processor[@id.toolBox1] = new ProcessorToolbox()
    @processor[@id.furnace1] = new ProcessorFurnace()

module.exports = ProcessorList