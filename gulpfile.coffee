g = require('gulp')
$ = require('gulp-load-plugins')()

g.task('html', ->
  return g.src('app/**/*.jade').pipe($.jade(pretty: true)).pipe(g.dest('deploy/'))
)
g.task('css', ->
  return g.src('app/styles/style.sass').pipe($.sass()).pipe(g.dest('deploy/styles/'))
)
g.task('js', ->
  return g.src('app/scripts/script.coffee').pipe($.webpack(require('./webpack.config.coffee'))).pipe(g.dest('deploy/scripts/'))
)

# Only for travis ci
g.task('deploy', ->
  return g.src('deploy/**/*').pipe($.ghPages(remoteUrl: "https://#{process.env.GH_TOKEN}@github.com/suitougreentea/Potato-Salad.git"))
)
