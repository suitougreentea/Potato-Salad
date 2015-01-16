class OreVein
  constructor: (@material, @size) ->
    @amount = @size * 1000
    @remain = @amount

module.exports = OreVein
