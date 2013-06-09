require 'moment'

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

      routes: '<%= paths.src %>/routes'
      vendor: '<%= paths.src %>/vendor'
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

    vendor: [
      '<%= paths.js %>/vendor.js'
      '<%= paths.vendor %>/jquery/jquery.js'
      '<%= paths.vendor %>/hashgrid/hashgrid.js'
    ]

    # Clean files and folders
    clean:
      javascripts: '<%= paths.javascripts %>'
      stylesheets: '<%= paths.stylesheets %>'

    # Concatenate files
    concat:
      options:
        stripBanners: true

      vendor:
        files: [
          dest: '<%= paths.js %>/vendor.js'
          src: '<%= vendor %>'
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
        basePath: null
        client: false
        compileDebug: false
        extension: null
        runtime: false
        #locals: grunt.file.readJSON './src/routes/index.json'
        locals:

          site:
            name: 'Lance Guyatt, Interaction Developer'
            title: 'Lance Guyatt, Interaction Developer'
            description: 'I am an award winning Interaction Developer with 8 years professional experience in developing web applications.'
            url:
              long: 'http://lanceguyatt.com'
              short: 'http://goo.gl/YroFM'
            copyrightYear: '2013'
            image:
              url: 'lanceguyatt.png'
              type: 'png'
              width: 200
              height: 200
            type: 'website'
            lang: 'en-GB'
            date:
              published:
                long: '2013-04-13'
                short: '2013'
              created:
                long: '2000-01-01'
                short: '2000'
            facebook:
              id: '148190791903784'
              admins: '781041907'

          paths:
            css: 'stylesheets/css'
            js: 'javascripts/js'
            images: 'images'

          person:
            name:
              first: 'Lance'
              last: 'Guyatt'
            role: 'Interaction Developer'
            worksfor: 'WilsonFletcher'
            description: 'Test'
            image:
              url: 'lanceguyatt.png'
              width: 200
              height: 200
            email: 'lance@lanceguyatt.com'
            telephone:
              long: '+447723198662'
              short: '07723198662'

          address:
            locality: 'London'
            country: 'United Kingdom'

          clients: [
            id: 'wilsonfletcher'
            name: 'WilsonFletcher'
            description: 'Strategic digital design'
            url: 'http://wilsonfletcher.com'
            date:
              created:
                long: '2012-07-13'
                short: '13/07/2012'
            image:
              url: 'logo-wilsonfletcher.png'
              width: 200
              height: 49
          ]

          primary: [
            id: '#ramdisk'
            class: 'ramdisk'
            name: 'Ram Disk'
            title: 'Ram Disk 5% full, 25M free, 5,627K in use'
          ,
            id: '#work'
            class: 'work'
            name: 'Work'
            title: 'Work 7% full, 35M free, 2,927K in use'
          ,
            id: '#about'
            class: 'about'
            name: 'About'
            title: '87% full, 5M free, 1,321K in use'
          ]

          links: [
            name: 'Email'
            url: 'lance@lanceguyatt.com'
            title: 'Email me'
            class: 'email'
          ,
            name: 'LinkedIn'
            url: 'http://uk.linkedin.com/in/lanceguyatt'
            title: 'Linkedin'
            class: 'linkedin'
          ,
            name: 'Google+'
            url: 'https://plus.google.com/102432796825488724849'
            title: 'Google+'
            class: 'google'
          ,
            name: 'Twitter'
            url: 'https://twitter.com/#!/lanceguyatt'
            title: 'Twitter'
            class: 'twitter'
          ,
            name: 'Github'
            url: 'https://github.com/lanceguyatt'
            title: 'Github'
            class: 'github'
          ]

          #name: 'Test'
          name: '<%= jade.options.locals.person.name.first %> <%= jade.options.locals.person.name.last %>'

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
        files: [
          '<%= paths.views %>/**/_*.jade'
          '<%= paths.views %>/**/*.jade'
        ]
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
