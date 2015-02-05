ProcessorHand = require('./ProcessorHand.coffee')
ProcessorToolbox = require('./ProcessorToolbox.coffee')

class ProcessorList
  @id:
    hand: 0
    toolBox1: 1
    
  @processor: []
  @init: () ->
    @processor[@id.hand] = new ProcessorHand()
    @processor[@id.toolBox1] = new ProcessorToolbox()

module.exports = ProcessorList
