g = require('gulp')
$ = require('gulp-load-plugins')()
runSequence = require('run-sequence')
del = require('del')

g.task('clean', (cb) ->
  del('deploy', cb)
)
g.task('html', ->
  return g.src('app/**/*.jade').pipe($.jade(pretty: true)).pipe(g.dest('deploy/')).pipe($.livereload())
)
g.task('css', ->
  return g.src('app/styles/style.sass').pipe($.sass(indentedSyntax: true, onError: (err) -> console.log(err))).pipe(g.dest('deploy/styles/')).pipe($.livereload())
)
g.task('js', ->
  return g.src('app/scripts/script.coffee').pipe($.webpack(require('./webpack.config.coffee'))).pipe(g.dest('deploy/scripts/')).pipe($.livereload())
)
g.task('svg', ->
  return g.src('app/assets/**/*.svg').pipe(g.dest('deploy/assets/'))
)
g.task('all', ['clean'], (cb) ->
  return runSequence(['html', 'css', 'js', 'svg'], cb)
)

g.task('watch', ->
  $.livereload.listen()
  g.watch('app/**/*.jade', ['html'])
  g.watch('app/**/*.sass', ['css'])
  g.watch('app/**/*.coffee', ['js'])
  g.watch('app/assets/**/*.svg', ['svg'])
)

# Only for travis ci
g.task('deploy', ->
  return g.src('deploy/**/*').pipe($.ghPages(remoteUrl: "https://#{process.env.GH_TOKEN}@github.com/suitougreentea/Potato-Salad.git"))
)
