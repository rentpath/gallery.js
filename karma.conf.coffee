module.exports = (config) ->
  config.set
    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ''

    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine', 'requirejs']

    # list of files / patterns to load in the browser
    files: [
      # dependencies
      {pattern: 'app/bower_components/jquery/dist/jquery.js', watched: false, served: true, included: true}
      {pattern: 'app/bower_components/jasmine-jquery/lib/jasmine-jquery.js', watched: false, served: true, included: true}
      {pattern: 'app/bower_components/jasmine-flight/lib/jasmine-flight.js', watched: false, served: true, included: true}
      {pattern: 'app/bower_components/underscore/underscore.js', watched: false, served: true, included: true}

      # fixtures
      {pattern: 'test/spec/fixtures/**', watched: true, served: true, included: false}

      # loaded with require
      {pattern: 'app/bower_components/flight/**/*.js', included: false}
      {pattern: 'app/bower_components/swiper/dist/idangerous.swiper.js', included: false}

      {pattern: 'app/coffeescript/**/*.coffee', included: false}
      {pattern: 'test/spec/**/*_spec.coffee', included: false}

      'test/test-main.coffee'
    ]

    exclude: [
      'app/coffeescript/demo/**'
    ]

    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      '**/*.coffee': ['coffee']
      '*/.html': []

    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress']

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome']

    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false
