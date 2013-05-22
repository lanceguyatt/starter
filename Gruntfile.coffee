#global module:false
module.exports = (grunt) ->

  'use strict'

  # Project configuration
  grunt.initConfig

    # Read package JSON
    pkg: grunt.file.readJSON 'package.json'

    # Create banner meta
    meta:
      banner: '/*! <%= pkg.name %> | <% pkg.description %> - v<%= pkg.version %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n'

    # Files paths
    paths:
      base: ''

      dist: '<%= paths.base %>dist'
      src: '<%= paths.base %>src'
      tmp: '<%= paths.base %>tmp'

      routes: '<%= paths.src %>/routes'
      views: '<%= paths.src %>/views'
      vendor: '<%= paths.src %>/vendor'

      coffee: '<%= paths.src %>/javascripts/coffee'
      scss: '<%= paths.src %>/stylesheets/scss'

      stylesheets: '<%= paths.dist %>/stylesheets'
      javascripts: '<%= paths.dist %>/javascripts'
      css: '<%= paths.stylesheets %>/css'
      js: '<%= paths.javascripts %>/js'

      fonts: '<%= paths.dist %>/fonts'
      images: '<%= paths.dist %>/images'

    # require js
    requirejs:
      compile:
        options:
          baseUrl: '<%= paths.js %>'
          mainConfigFile: '<%= paths.src %>/javascripts/js/config.js'
          include: ['<%= paths.vendor %>/require']
          out: '<%= paths.js %>/application.min.js'

    # jshint
    #jshint:
    #  all: [
    #    '<%= paths.js %>/**/*.js'
    #  ]
    #  options:
    #    jshintrc: '.jshintrc'

    # Compress images
    smushit:
      dist:
        src: '<%= paths.images %>'
        dest:'<%= paths.images %>'

    # Concat files
    #concat:
    #  options:
    #    stripBanners: true
    #    banner: '<%= meta.banner %>'
    #    separator: ';'

    #  bootstrap:
    #    files: '<%= paths.js %>/bootstrap.js': [
    #      '<%= paths.js %>/modernizr.js'
    #      '<%= paths.vendor %>/conditionizr/js/conditionizr.js'
    #      '<%= paths.js %>/bootstrap.js'
    #    ]
    #  plugins:
    #    files: '<%= paths.js %>/plugins.js': [
    #      '<%= paths.vendor %>/hashgrid/hashgrid.js'
    #    ]

    # Minify files
    #uglify:
    #  options:
    #    banner: '<%= meta.banner %>'
    #    #beautify: false
    #    #compress: false
    #    mangle: false
    #      #except: ['jQuery']
    #  dist:
    #    files: '<%= paths.js %>/bootstrap.min.js': '<%= paths.js %>/bootstrap.js'

    # Clean directories
    #clean:
    #  #images: '<%= paths.images %>'
    #  tmp: '<%= paths.tmp %>'
    #  javascripts: '<%= paths.javascripts %>'
    #  stylesheets: '<%= paths.stylesheets %>'

    # Compile jade templates
    jade:
      files:
        src: '<%= paths.views %>/*.jade'
        dest: '<%= paths.dist %>/'

      options:
        client: false

      dev:
        src: '<%= jade.files.src %>'
        dest: '<%= jade.files.dest %>'
        options:
          pretty: true

      dist:
        src: '<%= jade.files.src %>'
        dest: '<%= jade.files.dest %>'
        options:
          pretty: false

    # Compile coffee scripts
    coffee:
      compile:
        options:
          bare: true
          #separator: '<%= meta.banner %>'
        expand: true
        flatten: true
        cwd: '<%= paths.coffee %>'
        src: ['*.coffee']
        dest: '<%= paths.js %>'
        ext: '.js'


    # Compile compass files
    compass:
      options:
        cssDir: '<%= paths.css %>'
        sassDir: '<%= paths.scss %>'
        imagesDir: '<%= paths.images %>'
        fontsDir: '<%= paths.fonts %>'
        noLineComments: false
        relativeAssets: true
        # require: [
        #  'susy'
        #  'stitch'
        #  'modular-scale'
        #  'animation'
        # ]

      dev:
        options:
          debugInfo: true
          environment: 'development'
          outputStyle: 'expanded'

      dist:
        options:
          debugInfo: false
          environment: 'production'
          force: true
          noLineComments: false
          outputStyle: 'compressed'

    # Files to watch
    watch:
      jade:
        files: '<%= paths.views %>/**/*.jade'
        tasks: ['jade:dev', 'notify:jade']

      coffee:
        files: ['<%= paths.coffee %>/**/*.coffee']
        tasks: ['coffee', 'notify:coffee']

      compass:
        files: ['<%= paths.scss %>/**/*.scss']
        tasks: ['compass:dev', 'notify:compass']

    # Compile modernizr file
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
      parseFiles: true

    # Task complete messages
    notify:
      clean:
        options:
          message: 'Distribution cleaned'
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
      smushit:
        options:
          message: 'Images compressed'
      jade:
        options:
          message: 'Jade compiled'
      modernizr:
        options:
          message: 'Modernizr compiled'
      dev:
        options:
          message: 'Development running'
      dist:
        options:
          message: 'Distribution complete'

  # Load modules
  #grunt.task.run 'notify_hooks'
  #grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  #grunt.loadNpmTasks 'grunt-contrib-concat'
  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  #grunt.loadNpmTasks 'grunt-contrib-jshint'
  #grunt.loadNpmTasks 'grunt-devtools'
  grunt.loadNpmTasks 'grunt-jade'
  grunt.loadNpmTasks 'grunt-modernizr'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-smushit'

  # Run in development mode
  grunt.registerTask 'default', ['Development mode'], ->
    grunt.task.run 'notify:dev'
    grunt.task.run 'watch'

  # Compile for distribution
  grunt.registerTask 'dist', ['Distribution build'], ->
    #grunt.task.run 'clean'
    #grunt.task.run 'notify:clean'
    grunt.task.run 'compass:dist'
    grunt.task.run 'notify:compass'
    grunt.task.run 'coffee'
    grunt.task.run 'notify:coffee'
    #grunt.task.run 'concat'
    #grunt.task.run 'notify:concat'
    #grunt.task.run 'uglify'
    #grunt.task.run 'notify:uglify'
    grunt.task.run 'modernizr'
    grunt.task.run 'notify:modernizr'
    #grunt.task.run 'grunticon'
    grunt.task.run 'smushit:dist'
    grunt.task.run 'notify:smushit'
    grunt.task.run 'jade:dist'
    grunt.task.run 'notify:jade'
    #grunt.task.run 'manifest'
    #grunt.task.run 'notify:manifest'
    grunt.task.run 'notify:dist'