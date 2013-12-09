module.exports = (grunt) ->

  'use strict'

  # Project configuration
  grunt.initConfig

    # Read package JSON
    pkg: grunt.file.readJSON 'package.json'

    # Create banner meta
    meta:
      banner: '/* <%= pkg.name %> v<%= pkg.version %> Copyright (c) <%= grunt.template.today("yyyy") %> by <%= pkg.author.name %> (<%= pkg.author.url %>) */'

    # Directory paths
    directory:
      base: './'
      dist: '<%= directory.base %>dist'
      src: '<%= directory.base %>src'
      bower: '<%= directory.src %>/bower'
      routes: '<%= directory.src %>/routes'
      views: '<%= directory.src %>/views'
      coffee: '<%= directory.src %>/javascripts/coffee'
      js: '<%= directory.dist %>/javascripts/js'
      scss: '<%= directory.src %>/stylesheets/scss'
      css: '<%= directory.dist %>/stylesheets/css'
      fonts: '<%= directory.dist %>/fonts'
      images: '<%= directory.dist %>/images'
      plugins: '<%= directory.js %>/plugins'

    # File paths
    files:
      coffee: '<%= directory.coffee %>/{,*/}*.coffee'
      js: '<%= directory.js %>/{,*/}*.js'
      scss: '<%= directory.scss %>/{,*/}*.scss'
      css: '<%= directory.css %>/{,*/}*.css'
      jade: '<%= directory.views %>/{,*/}*.jade'
      html: '<%= directory.dist %>{,*/}*.html'
      plugins: [
        '<%= directory.js %>/plugins.js'
        '<%= directory.bower %>/jquery/jquery.js'
        '<%= directory.bower %>/hashgrid/hashgrid.js'
      ]

    # Clean files and folders
    clean:
      html: '<%= files.html %>'
      js: '<%= directory.js %>'
      css: '<%= directory.css %>'

    # Compile CoffeeScript files into JavaScript
    coffee:
      options:
        bare: true
      dist:
        files: [
          expand: true
          flatten: true
          cwd: '<%= directory.coffee %>'
          src: '*.coffee'
          dest: '<%= directory.js %>'
          ext: '.js'
        ]

    # Concatenate files
    concat:
      plugins:
        files: [
          src: '<%= files.plugins %>'
          dest: '<%= directory.plugins %>/plugins.js'
        ]

    # Validate files with JSHint
    jshint:
      options:
        jshintrc: '<%= directory.base %>.jshintrc'
      dist: [
        '<%= directory.js %>/**/*.js'
      ]

    # Minify files with UglifyJS.
    uglify:
      options:
        compress: true
        preserveComments: false
        except: ['jQuery']
      dist:
        files: [
          expand: true
          flatten: true
          cwd: '<%= directory.js %>'
          src: ['**/*.js', '!*.min.js']
          dest: '<%= directory.js %>'
          ext: '.min.js'
        ]

    # Compile Jade templates
    jade:
      options:
        basePath: '<%= directory.views %>'
        client: false
        compileDebug: false
        pretty: true
        locals: grunt.file.readJSON './src/routes/globals.json'
      dist:
        src: [
          '<%= directory.views %>/*.jade'
          '!<%= directory.views %>/_*.jade'
        ]
        dest: '<%= directory.dist %>'

    # Validate html files
    htmllint:
      dist: [
        '<%= files.html %>'
      ]

    htmlmin:
      options:
        removeComments: true
        removeCommentsFromCDATA: true
        removeCDATASectionsFromCDATA: true
        collapseWhitespace: true
        collapseBooleanAttributes: true
        removeAttributeQuotes: true
        removeRedundantAttributes: true
        useShortDoctype: true
        removeOptionalTags: true
        removeEmptyAttributes: true
      dist:
        files: [
          expand: true
          flatten: true
          cwd: '<%= directory.dist %>'
          src: '{,*/}*.html'
          dest: '<%= directory.dist %>'
          ext: '.html'
        ]

    # Compile Sass to CSS using Compass
    compass:
      options:
        basePath: '<%= directory.base %>'
        cssDir: '<%= directory.css %>'
        sassDir: '<%= directory.scss %>'
        javascriptsDir: '<%= directory.js %>'
        imagesDir: '<%= directory.images %>'
        fontsDir: '<%= directory.fonts %>'
        quiet: true
        trace: true
        force: true
        relativeAssets: true
        require: [
          'susy'
        ]
        raw: 'Sass::Script::Number.precision = 8'
      dist:
        debugInfo: false
        environment: 'development'
        noLineComments: true
        outputStyle: 'expanded'

    autoprefixer:
      modern:
        options:
          browsers: ['> 1%', 'last 2 versions', 'ff 17', 'ie 10', 'ie 11']
        files:
          '<%= directory.css %>/style.css': ['<%= directory.css %>/style.css']

      legacy:
        options:
          browsers: ['ie 8']
        files:
          '<%= directory.css %>/style-lt-ie9.css': ['<%= directory.css %>/style-lt-ie9.css']

    # Lint CSS files with csslint
    csslint:
      options:
        csslintrc: '<%= directory.base %>.csslintrc'
        absoluteFilePathsForFormatters: true
        import: 2
      all:
        src: [
          '<%= file.css %>'
        ]

    csscomb:
      options:
        sortOrder: '.csscomb.json'
      dist:
        files: [
          expand: true
          flatten: true
          cwd: '<%= directory.css %>'
          src: '{,*/}*.css'
          dest: '<%= directory.css %>'
          ext: '.css'
        ]

    csso:
      options:
        report: 'gzip'
      dist:
        files: [
          expand: true
          flatten: true
          cwd: '<%= directory.css %>'
          src: '{,*/}*.css'
          dest: '<%= directory.css %>'
          ext: '.min.css'
        ]

    # Adds a simple banner to files
    usebanner:
      options:
        position: 'top'
        banner: '<%= meta.banner %>'
      files:
        src: [
          '<%= files.css %>'
          '<%= files.js %>'
        ]

    browser_sync:
      files:
        src: [
          '<%= files.css %>'
          '<%= files.html %>'
          '<%= files.js %>'
        ]
      options:
        server:
          baseDir: '<%= directory.dist %>'
        ghostMode:
          scroll: true
          links: true
          forms: true
        watchTask: true
        debugInfo: true

    # Build out a lean, mean Modernizr machine
    modernizr:
      devFile: '<%= directory.bower %>/modernizr/modernizr.js'
      outputFile: '<%= directory.plugins %>/modernizr.min.js'
      files: [
        '<%= files.css %>'
        '<%= files.html %>'
        '<%= files.js %>'
      ]
      uglify: true

    # Task complete messages
    notify:
      clean:
        options:
          message: 'Folders and files cleaned'
      compass:
        options:
          message: 'Compass compiled'
      autoprefixer:
        options:
          message: 'CSS prefixed'
      csscomb:
        options:
          message: 'CSS reordered'
      csso:
        options:
          message: 'CSS minified'
      coffee:
        options:
          message: 'Coffeescript compiled'
      concat:
        options:
          message: 'Javascript concatenated'
      uglify:
        options:
          message: 'Javascript minified'
      jade:
        options:
          message: 'Jade compiled'
      htmlmin:
        options:
          message: 'HTML minified'
      usebanner:
        options:
          message: 'Banners added to JS and CSS'
      modernizr:
        options:
          message: 'Modernizr compiled'
      browser_sync:
        options:
          message: 'Brower sync running'
      dev:
        options:
          message: 'Development running'
      dist:
        options:
          message: 'Distribution complete'

    # Run predefined tasks whenever watched files change
    watch:
      #options:
      #  interrupt: true
      coffee:
        files: '<%= files.coffee %>'
        tasks: ['coffee', 'notify:coffee']

      compass:
        files: '<%= files.scss %>'
        tasks: ['compass', 'notify:compass', 'autoprefixer']

      jade:
        files: '<%= files.jade %>'
        tasks: ['jade', 'notify:jade']

      grunt:
        files: '<%= directory.base %>Gruntfile.coffee'
        tasks: ['default']

  # http://chrisawren.com/posts/Advanced-Grunt-tooling
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  # Run in development mode
  grunt.registerTask 'default', 'Development mode', ->
    grunt.task.run 'notify_hooks'
    grunt.task.run 'browser_sync'
    grunt.task.run 'notify:browser_sync'
    grunt.task.run 'watch'
    grunt.task.run 'notify:dev'

  # Compile for distribution
  grunt.registerTask 'dist', 'Distribution build', ->
    grunt.task.run 'notify_hooks'
    grunt.task.run 'clean'
    grunt.task.run 'notify:clean'
    grunt.task.run 'compass'
    grunt.task.run 'notify:compass'
    grunt.task.run 'autoprefixer'
    grunt.task.run 'notify:autoprefixer'
    grunt.task.run 'csscomb'
    grunt.task.run 'notify:csscomb'
    grunt.task.run 'csso'
    grunt.task.run 'notify:csso'
    grunt.task.run 'coffee'
    grunt.task.run 'notify:coffee'
    grunt.task.run 'concat'
    grunt.task.run 'notify:concat'
    grunt.task.run 'uglify'
    grunt.task.run 'notify:uglify'
    grunt.task.run 'jade'
    grunt.task.run 'notify:jade'
    grunt.task.run 'htmlmin'
    grunt.task.run 'notify:htmlmin'
    grunt.task.run 'usebanner'
    grunt.task.run 'notify:usebanner'
    grunt.task.run 'modernizr'
    grunt.task.run 'notify:modernizr'
    grunt.task.run 'notify:dist'
    grunt.task.run 'default'
