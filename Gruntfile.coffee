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

      javascripts: '<%= directory.dist %>/javascripts'
      coffee: '<%= directory.src %>/javascripts/coffee'
      js: '<%= directory.javascripts %>/js'

      stylesheets: '<%= directory.dist %>/stylesheets'
      scss: '<%= directory.src %>/stylesheets/scss'
      css: '<%= directory.stylesheets %>/css'

      fonts: '<%= directory.dist %>/fonts'
      images: '<%= directory.dist %>/images'

    files:
      css: '<%= directory.stylesheets %>/**/*.css'
      html: '<%= directory.dist %>/**/*.html'
      jade: '<%= directory.views %>/**/*.jade'
      js: '<%= directory.javascripts %>/**/*.js'

    plugins: [
      '<%= directory.js %>/plugins.js'
      '<%= directory.bower %>/jquery/jquery.js'
      '<%= directory.bower %>/hashgrid/hashgrid.js'
    ]

    # Clean files and folders
    clean:
      html: '<%= files.html %>'
      javascripts: '<%= files.js %>'
      stylesheets: '<%= files.css %>'

    # Concatenate files
    concat:
      options:
        stripBanners: true

      plugins:
        files: [
          dest: '<%= directory.js %>/plugins.js'
          src: '<%= plugins %>'
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
        locals:
          site:
            name: '<%= pkg.name %>'
            title: '<%= pkg.title %>'
            description: '<%= pkg.description %>'
            keywords: '<%= pkg.keywords %>'
            email: '<%= pkg.author.email %>'
            url: '<%= pkg.homepage %>'
            image: '<%= pkg.homepage %>/logo.png'
            lang: 'en'
            locale: 'en_GB'
            dir: 'ltr'
            type: 'website'
            copyrightYear: '<%= grunt.template.today("yyyy") %>'

          author:
            name: '<%= pkg.author.name %>'
            email: '<%= pkg.author.email %>'
            url: '<%= pkg.author.url %>'
            twitter: '@lanceguyatt'

          paths:
            images: 'images'
            css: "stylesheets/css"
            js: "javascripts/js"

      dist:
        src: [
          '<%= directory.views %>/*.jade'
          '<%= directory.views %>/**/*.jade'
          '!<%= directory.views %>/_*.jade'
          '!<%= directory.views %>/**/_*.jade'
        ]
        dest: '<%= directory.dist %>'

    # Compile CoffeeScript files into JavaScript
    coffee:
      options:
        bare: true

      all:
        files: [
          expand: true
          flatten: true
          cwd: '<%= directory.coffee %>'
          src: ['**/*.coffee']
          dest: '<%= directory.js %>'
          ext: '.js'
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
        relativeAssets: true
        require: [
          'susy'
        ]

      dev:
        options:
          debugInfo: false
          environment: 'development'
          noLineComments: true
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
        files: '<%= directory.views %>/*{,**/}*.jade'
        tasks: ['jade', 'notify:jade']
        options:
          livereload: true

      coffee:
        files: '<%= directory.coffee %>/{,**/}*.coffee'
        tasks: ['coffee', 'notify:coffee']

      compass:
        files: '<%= directory.scss %>/{,**/}*.{scss,sass}'
        tasks: ['compass:dev', 'notify:compass']
        options:
          livereload: true

      grunt:
        files: '<%= directory.base %>Gruntfile.coffee'
        tasks: ['default']

      #json:
      #  files: [
      #    '<%= directory.src %>/package.json'
      #    '<%= directory.routes %>/index.json'
      #  ]
      #  tasks: ['default']

    # Build out a lean, mean Modernizr machine
    modernizr:
      devFile: '<%= directory.bower %>/modernizr/modernizr.js'
      outputFile: '<%= directory.js %>/modernizr.min.js'
      files: [
        '<%= files.css %>'
        '<%= files.js %>'
      ]
      uglify: true

    # Validate files with JSHint
    #jshint:
    #  options:
    #    jshintrc: '<%= directory.base %>.jshintrc'
    #  dev: [
    #    '<%= directory.js %>/app.js'
    #  ]

    # Validate html files
    #htmllint:
    #  dev: [
    #    '<%= files.html %>'
    #  ]

    # Lint CSS files with csslint
    #csslint:
    #  options:
    #    csslintrc: '<%= directory.base %>.csslintrc'
    #    absoluteFilePathsForFormatters: true
    #    import: 2
    #
    #  dev:
    #    src: [
    #      '<%= file.css %>'
    #    ]

    csscomb:
      options:
        sortOrder: '.csscomb.json'
      dist:
        files:
          'dist/stylesheets/css/style.max.css': ['dist/stylesheets/css/style.css']

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
  grunt.loadNpmTasks 'grunt-csscomb'
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
    grunt.task.run 'csscomb'
    grunt.task.run 'notify:dist'
