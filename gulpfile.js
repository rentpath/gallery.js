'use strict';

var gulp = require('gulp');
var coffee = require('gulp-coffee')
var gutil = require('gulp-util')
var sourcemaps = require('gulp-sourcemaps')
var del = require('del');

gulp.task('clean-dist', function (cb) {
  del('dist/', cb);
});

gulp.task('dist', ['clean-dist'], function() {
  gulp.src([ 'app/coffeescript/**/*.coffee', '!app/coffeescript/demo/**' ])
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('dist/'));
});

gulp.task('coffee', function() {
  gulp.src('app/coffeescript/**/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('app/js/'));
});

gulp.task('build', function() {
  gulp.run('coffee');
  gulp.run('dist');
});

gulp.task('default', function () {
  gulp.run('build');

  gulp.watch('app/coffeescript/**/*.coffee', function (event) {
    gulp.run('coffee');
    gulp.run('dist');
  });
});
