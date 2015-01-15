g = require('gulp')
$ = require('gulp-load-plugins')()

g.task('deploy', ->
  return g.src('./deploy/**/*').pipe($.ghPages())
)
