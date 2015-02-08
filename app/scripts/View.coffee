Processor = require('./Processor.coffee')
$ = require('jquery')

class View
  @activePage: undefined
  @PAGE_CRAFT: 0
  @PAGE_FACTORY: 1
  @PAGE_PICK: 2
  @PAGE_DIG: 3
  @PAGE_CUT: 4
  @PAGE_MINE: 5
  @PAGE_SETTINGS: 6

  @craft: require('./ViewCraft.coffee')
  @factory: require('./ViewFactory.coffee')
  @pick: require('./ViewPick.coffee')
  @dig: require('./ViewDig.coffee')
  @cut: require('./ViewCut.coffee')
  @mine: require('./ViewMine.coffee')
  @settings: require('./ViewSettings.coffee')

  @ITEM: 0
  @MATERIAL: 1
  @TOOLBOX_STATE: 2
  @PROCESSOR_STATE: 3
  @PROCESSOR_QUEUE: 4
  @STATUS: 5
  @OREVEIN: 6

  @refresh: (id, args...) ->
    switch id
      when @ITEM then @refreshItemList()
      when @MATERIAL then @refreshMaterialList()
      when @STATUS then @refreshStatus()
      when @TOOLBOX_STATE then if @activePage == @PAGE_CRAFT then @craft.refreshToolBoxState()
      when @PROCESSOR_STATE then if @activePage == @PAGE_FACTORY then @factory.refreshProcessorState(args[0])
      when @PROCESSOR_QUEUE then if @activePage == @PAGE_FACTORY then @factory.refreshProcessorQueue(args[0])
      when @OREVEIN then if @activePage == @PAGE_MINE then @mine.refreshOreVeinList()

  @toggleTab: (page) ->
    switch page
      when @PAGE_CRAFT then @craft.refreshAll()
      when @PAGE_FACTORY then @factory.refreshAll()
      when @PAGE_PICK then @pick.refreshAll()
      when @PAGE_DIG then @dig.refreshAll()
      when @PAGE_CUT then @cut.refreshAll()
      when @PAGE_MINE then @mine.refreshAll()
      when @PAGE_SETTINGS then @settings.refreshAll()
    @activePage = page

  @refreshStatus: ->
    $('#time').text("Time: #{Game.time}")
    $('#mode').text("Now you are #{Game.modeString[Game.mode]}")
    $('#money').text("320,000,000,000,000,000.00 Mn")
    
  @refreshMaterialList: ->
    $('#materialStock').html('')
    for list in Game.materialViewList.data
      $('#materialStock').append("<div class='header'>#{list.name}</div>")
      for e in list.list
        ((e) =>
          material = Game.materialList.material[e]
          num = Game.material[e]
          $('#materialStock').append("<div class='material'>#{@getIcon(material.icon)}<div class='materialName'>#{material.fullName}</div><div class='materialAmount'>#{Game.formatNumber(num)}</div></div>")
          @registerTooltip($('.material:last'), material.fullName)
        )(e)
    return

    $('#materialOverworldPick').html('')
    for e in Game.materialOverworldPickViewList
      ((e) =>
        material = Game.materialList.material[e]
        num = Game.material[e]
        $('#materialOverworldPick').append("<input type=\"checkbox\">#{material.materialName}: #{num}<br />")

        # Check state
        $('#materialOverworldPick input:last').attr('checked', Game.materialOverworldIgnoreList.indexOf(e) != -1)
        $('#materialOverworldPick input:last').change(-> Game.changeIgnoreCheckbox($(@).is(':checked'), e))
      )(e)

  @refreshOreVeinList: ->
    $('#oreVein').html('')
    for e, i in Game.oreVein
      ((e, i) =>
        $('#oreVein').append("<div><button>Mine this vein</button> #{Game.materialList.material[e.materialId].materialName}: #{e.remain} / #{e.amount}</div>")
        $('#oreVein button:last').click(-> Game.tryToStartMining(i))
      )(e, i)

  @refreshItemList: ->
    $('#itemHave').html('')

    $('#itemStock').html('')
    for e, i in Game.item
      ((e, i) =>
        $('#itemStock').append("<div class='buttonItem'>#{@getIcon([['sIngot', 'sMaterialGold']])}</div>")
        @registerTooltip($('#itemStock .buttonItem:last'), e.name)
        $('#itemStock .buttonItem:last').click(-> Game.useItem(i))
      )(e, i)

  @getIcon: (config) ->
    if config
      result = "<svg class='icon' viewBox='0 0 8.46667 8.46667'>"
      for e in config
        [icon, filter] = e
        result = result + "<use xlink:href='##{icon}' style='filter: url(##{filter})'></use>"
      result = result + "</svg>"
    else result = "<span class='icon'>NO ICON</span>"
    return result
  
  @newTooltip: (content, e) ->
    $('#tooltip').html(content)
    $('#tooltip').show()
    $('#tooltip').css(left: e.pageX, top: e.pageY)

  @moveTooltip: (e) ->
    $('#tooltip').css(left: e.pageX, top: e.pageY)

  @hideTooltip: () ->
    $('#tooltip').hide()

  @registerTooltip: (jq, content) ->
    jq.mouseover((e) => @newTooltip(content, e)).mousemove((e) => @moveTooltip(e)).mouseout(=> @hideTooltip())
    

module.exports = View
