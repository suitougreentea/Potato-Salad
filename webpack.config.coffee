path = require('path')
webpack = require('webpack')

npm = path.join(__dirname, 'node_modules')
bower = path.join(__dirname, 'bower_components')

module.exports =
  module:
    loaders: [test:/\.coffee$/, loader: 'coffee-loader']
  resolve:
    modulesDirectories: [npm, bower]
  plugins: [
    new webpack.ResolverPlugin(new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main']))
  ]
  output:
    filename: 'script.js'
