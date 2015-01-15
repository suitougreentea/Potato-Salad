g = require('gulp')
$ = require('gulp-load-plugins')()

g.task('build', ->
  return g.src('app/**/*.jade').pipe($.jade(pretty: true)).pipe(g.dest('deploy/'))
)

# Only for travis ci
g.task('deploy', ->
  return g.src('deploy/**/*').pipe($.ghPages(remoteUrl: "https://#{process.env.GH_TOKEN}@github.com/suitougreentea/Potato-Salad.git"))
)
