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
  gulp.src([ 'app/js/**/*.coffee', '!app/js/main.coffee' ])
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('dist/'));
});

gulp.task('coffee', function() {
  gulp.src('app/js/**/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('.tmp/app/js/'));
});

gulp.task('coffee-spec', function() {
  gulp.src('test/**/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('.tmp/test/'));
});

gulp.task('copy-bower', function(){
  gulp.src(['app/bower_components/**/* '], { "base" : "." }).pipe(gulp.dest('./.tmp/'));
});

gulp.task('copy-fixtures', function(){
  gulp.src(['test/spec/fixtures/**/* '], { "base" : "." }).pipe(gulp.dest('./.tmp/'));
});

gulp.task('build', function() {
  gulp.run('copy-bower');
  gulp.run('copy-fixtures');
  gulp.run('coffee');
  gulp.run('coffee-spec');
  gulp.run('dist');
});

gulp.task('default', function () {
  gulp.run('build');

  gulp.watch('test/spec/fixtures/**/*', function (event) {
    gulp.run('copy-fixtures');
  });

  gulp.watch('app/bower_components/*', function (event) {
    gulp.run('copy-bower');
  });

  gulp.watch('app/js/**/*.coffee', function (event) {
    gulp.run('coffee');
    gulp.run('dist');
  });

  gulp.watch('test/**/*.coffee', function (event) {
    gulp.run('coffee-spec');
  });
});
