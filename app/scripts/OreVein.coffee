class OreVein
  constructor: (@materialId, @size) ->
    @amount = @size * 1000
    @remain = @amount

module.exports = OreVein
