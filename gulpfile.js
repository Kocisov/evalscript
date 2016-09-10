const gulp = require('gulp')
const babel = require('gulp-babel')
const jison = require('gulp-jison')

gulp.task('_js', () => {
  return gulp.src('src/**/*.js')
  .pipe(babel({
    presets: ['es2015']
  }))
  .pipe(gulp.dest('./dist/'))
})

gulp.task('_jison', () => {
  return gulp.src('./src/**/*.jison')
  .pipe(jison({
    moduleType: 'commonjs'
  }))
  .pipe(gulp.dest('./dist/'));
})

gulp.task('default', ['_js', '_jison'])

gulp.task('watch', () => {
  gulp.watch('src/**/*.*', ['_js', '_jison'])
})
