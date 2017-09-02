const gulp = require('gulp')
const sass = require('gulp-sass')

gulp.task('sass', () =>
    gulp.src('./index.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('.')))

gulp.task('sass:watch', () =>
  gulp.watch('./**/*.scss', ['sass']))

