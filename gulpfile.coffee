g = require('gulp')
$ = require('gulp-load-plugins')()

g.task('build', ->
  return g.src('app/**/*.jade').pipe($.jade(pretty: true)).pipe(g.dest('deploy/'))
)

g.task('deploy', ->
  return g.src('deploy/**/*').pipe($.ghPages())
)
