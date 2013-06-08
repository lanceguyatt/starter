module.exports = (grunt) ->

  'use strict'

  # Project configuration
  grunt.initConfig

    # Read package JSON
    pkg: grunt.file.readJSON 'package.json'

    asciify:
      banner:
        text: '<%= pkg.name %>'
        options:
          font: 'graffiti'
          log: true

    # Create banner meta
    meta:
      banner: '/* <%= pkg.name %> v<%= pkg.version %> Copyright (c) <%= grunt.template.today("yyyy") %> by <%= pkg.author.name %> (<%= pkg.author.url %>) */'

    # Directory paths
    paths:
      base: './'

      dist: '<%= paths.base %>dist'
      src: '<%= paths.base %>src'
      tests: '<%= paths.base %>tests'
      tmp: '<%= paths.base %>tmp'

      routes: '<%= paths.src %>/routes'
      views: '<%= paths.src %>/views'
      vendor: '<%= paths.src %>/vendor'

      javascripts: '<%= paths.dist %>/javascripts'
      coffee: '<%= paths.src %>/javascripts/coffee'
      js: '<%= paths.javascripts %>/js'

      stylesheets: '<%= paths.dist %>/stylesheets'
      scss: '<%= paths.src %>/stylesheets/scss'
      css: '<%= paths.stylesheets %>/css'

      jade: '<%= paths.views %>/*.jade'

      fonts: '<%= paths.dist %>/fonts'
      images: '<%= paths.dist %>/images'

    # Concatenate files
    concat:
      options:
        stripBanners: true
        #banner: '<%= meta.banner %>'
        #separator: ';'

      vendor:
        files: '<%= paths.js %>/vendor.js': [
          '<%= paths.js %>/vendor.js',
          '<%= paths.vendor %>/jquery/jquery.js',
          '<%= paths.vendor %>/hashgrid/hashgrid.js'
        ]

    # Minify files with UglifyJS.
    uglify:
      options:
        #banner: '<%= meta.banner %>'
        beautify: false
        compress: true
        mangle: false
        except: ['jQuery']

      files:
        expand: true
        flatten: true
        cwd: '<%= paths.js %>'
        src: ['**/*.js', '!*.min.js']
        dest: '<%= paths.js %>'
        ext: '.min.js'

    # Clean files and folders
    clean:
      tmp: '<%= paths.tmp %>'
      javascripts: '<%= paths.javascripts %>'
      stylesheets: '<%= paths.stylesheets %>'

    # Compile Jade templates
    jade:
      options:
        basePath: null
        client: false
        compileDebug: false
        extension: null
        runtime: false
        locals: grunt.file.readJSON './src/routes/index.json'

      dev:
        options:
          pretty: true
        src: '<%= paths.jade %>'
        dest: '<%= paths.dist %>'

      dist:
        options:
          pretty: false
        src: '<%= paths.jade %>'
        dest: '<%= paths.dist %>'

    # Compile CoffeeScript files into JavaScript
    coffee:
      options:
        bare: true
        banner: '<%= meta.banner %>'

      all:
        files: [
          expand: true
          flatten: true
          cwd: '<%= paths.coffee %>'
          src: ['**/*.coffee']
          dest: '<%= paths.js %>'
          ext: '.js'
        ]

    # Compile Sass to CSS using Compass
    compass:
      options:
        basePath: '<%= paths.base %>'
        cssDir: '<%= paths.css %>'
        sassDir: '<%= paths.scss %>'
        javascriptsDir: '<%= paths.js %>'
        imagesDir: '<%= paths.images %>'
        fontsDir: '<%= paths.fonts %>'
        relativeAssets: true
        require: [
         'modular-scale'
         'susy'
        ]

      dev:
        options:
          debugInfo: true
          environment: 'development'
          noLineComments: false
          outputStyle: 'expanded'

      dist:
        options:
          debugInfo: false
          environment: 'production'
          force: true
          noLineComments: true
          outputStyle: 'compressed'

    # Run predefined tasks whenever watched files change
    watch:
      options:
        nospawn: true

      jade:
        files: '<%= paths.views %>{,**/}*.jade'
        tasks: ['jade:dev', 'notify:jade']
        options:
          livereload: true

      coffee:
        files: '<%= paths.coffee %>/{,**/}*.coffee'
        tasks: ['coffee', 'notify:coffee']

      compass:
        files: '<%= paths.scss %>/{,**/}*.{scss,sass}'
        tasks: ['compass:dev', 'notify:compass']
        options:
          livereload: true

    # Build out a lean, mean Modernizr machine
    modernizr:
      devFile: '<%= paths.vendor %>/modernizr/modernizr.js'
      outputFile: '<%= paths.js %>/modernizr.min.js'
      extra:
        shiv: true
        printshiv: false
        load: true
        mq: false
        cssclasses: true
        extensibility:
          addtest: false
          prefix: false
          teststyles: false
          testprops: false
          testallprops: false
          hasevents: false
          prefixes: false
          domprefixes: false
        uglify: true
        parseFiles: false
        matchCommunityTests: false
        customTests: []

    # Validate files with JSHint
    jshint:
      options:
        jshintrc: '<%= paths.base %>.jshintrc'
      dev: [
        '<%= paths.js %>/application.js'
      ]

    # Validate html files
    htmllint:
      dev: [
        '<%= paths.dist %>/**/*.html'
      ]

    # Lint CSS files with csslint
    csslint:
      options:
        csslintrc: '<%= paths.base %>.csslintrc'
        absoluteFilePathsForFormatters: true
        import: 2

      dev:
        src: [
          '<%= paths.css %>/**/*.css'
        ]

    # Adds a simple banner to files
    usebanner:
      options:
        position: 'top'
        banner: '<%= meta.banner %>'
      files:
        src: [
          '<%= paths.css %>/**/*.css'
          '<%= paths.js %>/**/*.js'
        ]

    # Start a connect web server
    connect:
      default:
        options:
          hostname: '*'
          port: 3001
          base: '<%= paths.dist %>'

    # Task complete messages
    notify:
      clean:
        options:
          message: 'Folders and files cleaned'
      coffee:
        options:
          message: 'Coffee compiled'
      compass:
        options:
          message: 'Compass compiled'
      concat:
        options:
          message: 'Concatenation complete'
      uglify:
        options:
          message: 'Uglification complete'
      jade:
        options:
          message: 'Jade compiled'
      modernizr:
        options:
          message: 'Modernizr compiled'
      usebanner:
        options:
          message: 'Banners added'
      connect:
        options:
          message: 'Server started'
      dev:
        options:
          message: 'Development running'
      dist:
        options:
          message: 'Distribution complete'

  # Dependencies
  grunt.loadNpmTasks 'grunt-asciify'
  grunt.loadNpmTasks 'grunt-banner'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-csslint'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-html'
  grunt.loadNpmTasks 'grunt-jade'
  grunt.loadNpmTasks 'grunt-modernizr'
  grunt.loadNpmTasks 'grunt-notify'

  # Run in development mode
  grunt.registerTask 'default', 'Development mode', ->
    grunt.task.run 'connect'
    grunt.task.run 'notify:connect'
    grunt.task.run 'watch'
    grunt.task.run 'notify:dev'

  # Install bower
  grunt.registerTask 'bower-install', 'Installs Bower dependencies.', ->
    bower = require('bower')
    done = @async()
    bower.commands.install().on('data', (data) ->
      grunt.log.write data
    ).on 'end', done

  # Run tests
  grunt.registerTask 'test', 'Testing mode', ->
    grunt.task.run 'jade:dev'
    grunt.task.run 'htmllint:dev'
    grunt.task.run 'compass:dev'
    grunt.task.run 'csslint:dev'
    grunt.task.run 'jshint:dist'

  # Compile for distribution
  grunt.registerTask 'dist', 'Distribution build', ->
    grunt.task.run 'clean'
    grunt.task.run 'notify:clean'
    grunt.task.run 'compass:dist'
    grunt.task.run 'notify:compass'
    grunt.task.run 'coffee'
    grunt.task.run 'notify:coffee'
    grunt.task.run 'concat'
    grunt.task.run 'notify:concat'
    grunt.task.run 'uglify'
    grunt.task.run 'notify:uglify'
    grunt.task.run 'modernizr'
    grunt.task.run 'notify:modernizr'
    grunt.task.run 'jade:dist'
    grunt.task.run 'notify:jade'
    grunt.task.run 'usebanner'
    grunt.task.run 'notify:usebanner'
    grunt.task.run 'notify:dist'
