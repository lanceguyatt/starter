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
    paths:
      base: './'

      dist: '<%= paths.base %>dist'
      src: '<%= paths.base %>src'

      bower: '<%= paths.src %>/bower'
      routes: '<%= paths.src %>/routes'
      views: '<%= paths.src %>/views'

      javascripts: '<%= paths.dist %>/javascripts'
      coffee: '<%= paths.src %>/javascripts/coffee'
      js: '<%= paths.javascripts %>/js'

      stylesheets: '<%= paths.dist %>/stylesheets'
      scss: '<%= paths.src %>/stylesheets/scss'
      css: '<%= paths.stylesheets %>/css'

      jade: '<%= paths.views %>/*.jade'

      fonts: '<%= paths.dist %>/fonts'
      images: '<%= paths.dist %>/images'

    plugins: [
      '<%= paths.js %>/plugins.js'
      '<%= paths.plugins %>/jquery/jquery.js'
      '<%= paths.plugins %>/hashgrid/hashgrid.js'
    ]

    # Clean files and folders
    clean:
      html: '<%= paths.dist %>/**/*.html'
      javascripts: '<%= paths.javascripts %>/**/*.js'
      stylesheets: '<%= paths.stylesheets %>/**/*.css'

    # Concatenate files
    concat:
      options:
        stripBanners: true

      plugins:
        files: [
          dest: '<%= paths.js %>/plugins.js'
          src: '<%= plugins %>'
        ]

    # Minify files with UglifyJS.
    uglify:
      options:
        beautify: false
        compress: true
        mangle: false
        except: ['jQuery']

      all:
        files: [
          expand: true
          flatten: true
          cwd: '<%= paths.js %>'
          src: ['**/*.js', '!*.min.js']
          dest: '<%= paths.js %>'
          ext: '.min.js'
        ]

    # Compile Jade templates
    jade:
      options:
        basePath: '<%= paths.views %>'
        client: false
        compileDebug: false
        locals: grunt.file.readJSON './src/routes/index.json'
      files:
        src: '<%= paths.views %>/**/*.jade'
        dest: '<%= paths.dist %>'

      dev:
        options:
          pretty: true
        src: '<%= paths.views %>/**/*.jade'
        dest: '<%= paths.dist %>'

      dist:
        options:
          pretty: false
        src: '<%= paths.views %>/**/*.jade'
        dest: '<%= paths.dist %>'

    # Compile CoffeeScript files into JavaScript
    coffee:
      options:
        bare: true

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
          'breakpoint'
          'modular-scale'
          'susy'
        ]

      dev:
        options:
          debugInfo: false
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
        files: '<%= paths.views %>/*{,**/}*.jade'
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

      grunt:
        files: '<%= paths.base %>Gruntfile.coffee'
        tasks: ['default']

      json:
        files: '<%= paths.routes %>/index.json'
        tasks: ['default']

    # Build out a lean, mean Modernizr machine
    modernizr:
      devFile: '<%= paths.vendor %>/modernizr/modernizr.js'
      outputFile: '<%= paths.js %>/modernizr.min.js'
      extra:
        shiv: true
        printshiv: false
        load: false
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
      dev:
        options:
          message: 'Development running'
      dist:
        options:
          message: 'Distribution complete'

  # Dependencies
  grunt.loadNpmTasks 'grunt-banner'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-jade'
  grunt.loadNpmTasks 'grunt-modernizr'
  grunt.loadNpmTasks 'grunt-notify'

  # Run in development mode
  grunt.registerTask 'default', 'Development mode', ->
    grunt.task.run 'watch'
    grunt.task.run 'notify:dev'

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
    grunt.task.run 'jade:dist'
    grunt.task.run 'notify:jade'
    grunt.task.run 'modernizr'
    grunt.task.run 'notify:modernizr'
    grunt.task.run 'usebanner'
    grunt.task.run 'notify:usebanner'
    grunt.task.run 'notify:dist'
