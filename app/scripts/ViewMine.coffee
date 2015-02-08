$ = require('jquery')

class ViewMine
  @refreshAll: () ->
    $('#painMain').html("<div id='oreVein'></div>")
    @refreshOreVeinList()

  @refreshOreVeinList: () ->
    $('#oreVein').html("<div class='header'></div><button id='searchVein'>Search vein</button><div class='list'></div>")
    $('#oreVein>button').click( ->
      Game.mode = Game.MODE_MINE
      Game.view.refresh(Game.view.STATUS)
      Game.view.refresh(Game.view.OREVEIN)
    )
    for e, i in Game.oreVein
      ((e, i) =>
        $('#oreVein>.list').append("<div><div class='buttonItem'></div><div class='text'><div class='name'></div><div class='size'></div></div><div class='meter'><div class='meterbg'><span class='meterFill'></span></div></div></div>")
        $('#oreVein>.list>div:last>.buttonItem').html(Game.view.getIcon([['sIngot', '']]))
        $('#oreVein>.list>div:last>.text>.name').text(Game.materialList.material[e.materialId].materialName)
        $('#oreVein>.list>div:last>.text>.size').text('Large')
        $('#oreVein>.list>div:last>.meter>.meterbg>.meterFill').css(width: "#{e.remain / e.amount * 100}%")
        $('#oreVein>.list>div:last>.buttonItem').click( ->
          Game.mode = Game.MODE_VEIN
          Game.miningTarget = i
          Game.view.refresh(Game.view.STATUS)
          Game.view.refresh(Game.view.OREVEIN)
        )
      )(e, i)

    if Game.mode == Game.MODE_VEIN then $("#oreVein>.list>div:nth-child(#{Game.miningTarget + 1})").addClass('active')

module.exports = ViewMine
