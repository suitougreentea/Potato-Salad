$ = require('jquery')

class ViewFactory
  @refreshAll: () ->
    $('#painMain').html('Factory')

module.exports = ViewFactory
