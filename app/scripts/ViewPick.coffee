$ = require('jquery')

class ViewPick
  @refreshAll: () ->
    $('#painMain').html("<div id='pickNotifyList'></div>")
    @refreshNotifyList()

  @refreshNotifyList: () ->
    $('#pickNotifyList').html("<div class='header'>Notify settings</div><div class='list'></div>")
    for e, i in Game.overworldStuffFinder.data
      ((e, i) ->
        $('#pickNotifyList>.list').append("<div><input type='checkbox' />#{Game.materialList.material[e[0]].fullName}</div>")
        $('#pickNotifyList>.list>div:last>input').attr('checked', Game.pickNotifyList[i])
        $('#pickNotifyList>.list>div:last>input').click( ->
          Game.pickNotifyList[i] = $(@).prop('checked')
          return true
        )
      )(e, i)

module.exports = ViewPick
