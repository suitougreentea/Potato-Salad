g = require('gulp')
$ = require('gulp-load-plugins')()

g.task('build', ->
  return g.src('app/**/*.slim').pipe($.slim(pretty: true)).pipe(g.dest('deploy/'))
)

g.task('deploy', ->
  return g.src('deploy/**/*').pipe($.ghPages())
)
