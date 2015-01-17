Recipe = require('./Recipe.coffee')

class RecipeList
  @normal: []

  @user: []

  @init: ->
    ml = Game.materialList
    il = Game.itemList
    @normal = [
      new Recipe([[ml.id.woodStick, 1], [ml.id.stone, 2]], il.item[il.id.stoneShovel])
      new Recipe([[ml.id.woodStick, 1], [ml.id.stone, 2]], il.item[il.id.stoneAxe])
      new Recipe([[ml.id.woodStick, 1], [ml.id.stone, 2]], il.item[il.id.stonePickaxe])
    ]

module.exports = RecipeList
