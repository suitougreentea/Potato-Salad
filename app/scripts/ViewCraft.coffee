$ = require('jquery')

class ViewCraft
  @refreshAll: () ->
    $('#painMain').html("<div id='toolBox'></div>")
    @refreshToolBox()

  @refreshToolBox: ->
    $('#painMain>#toolBox').html("<div class='header'>Toolbox</div><div class='state'></div><div class='recipeItem'></div><div class='recipeMaterial'></div>")
    @refreshToolBoxState()
    @refreshToolBoxRecipeList()

  @refreshToolBoxState: ->
    if Game.craft.state.type == Game.craft.TYPE_NONE
      $('#toolBox>.state').html('')
    else
      $('#toolBox>.state').html("<div class='iconBox'></div><div class='meter'><div class='meterbg'><span class='meterFill'></span></div></div><div class='text'><div class='name'></div><div class='progress'></div></div>")
      $('#toolBox>.state>.iconBox').html(Game.view.getIcon([['sIngot', '']]))
      $('#toolBox>.state>.meter>.meterbg>.meterFill').css(width: "#{(Game.craft.state.time - Game.craft.state.timeRemain) / Game.craft.state.time * 100}%")
      switch Game.craft.state.type
        when Game.craft.TYPE_ITEM
          $('#toolBox>.state>.text>.name').text(Game.craft.state.recipe.outputItem[0].name)
        when Game.craft.TYPE_MATERIAL
          $('#toolBox>.state>.text>.name').text(Game.materialList.material[Game.craft.state.recipe.outputMaterial[0][0]].fullName)
      $('#toolBox>.state>.text>.progress').text("#{Game.craft.state.timeRemain} / #{Game.craft.state.time}")

  @refreshToolBoxRecipeList: () ->
    itemRecipe = Game.craft.itemRecipe
    materialRecipe = Game.craft.materialRecipe

    if itemRecipe.length > 0
      for e, i in itemRecipe
        ((e, i) =>
          item = e.outputItem[0]
          $('#toolBox>.recipeItem').append("<div class='buttonItem'>#{Game.view.getIcon([['sIngot', '']])}</div>")
          Game.view.registerTooltip($('#toolBox>.recipeItem>.buttonItem:last'), item.name)
          $('#toolBox>.recipeItem>.buttonItem:last').click(-> Game.craft.startCraftingItem(i))
        )(e, i)

    if materialRecipe.length > 0
      for e, i in materialRecipe
        ((e, i) =>
          [id, amount] = e.outputMaterial[0]
          $('#toolBox>.recipeMaterial').append("<div class='buttonItem'>#{Game.view.getIcon([['sIngot', '']])}</div>")
          Game.view.registerTooltip($('#toolBox>.recipeMaterial>.buttonItem:last'), Game.materialList.material[id].fullName)
          $('#toolBox>.recipeMaterial>.buttonItem:last').click(-> Game.craft.startCraftingMaterial(i, 1))
        )(e, i)

module.exports = ViewCraft
