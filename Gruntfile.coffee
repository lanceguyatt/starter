module.exports = (grunt) ->

  'use strict'

  # Project configuration
  grunt.initConfig

    # Read package JSON
    pkg: grunt.file.readJSON 'package.json'

    # Create banner meta
    meta:
      banner: '/* <%= pkg.name %> v<%= pkg.version %> Copyright <%= grunt.template.today("yyyy") %> Designed and built by <%= pkg.author.name %> */'

    # Files paths
    paths:
      base: ''

      dist: '<%= paths.base %>dist'
      src: '<%= paths.base %>src'
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

    # Add banners
    usebanner:
      humans:
        options:
          position: 'bottom'
          banner: '<%= grunt.template.today("dd/mm/yyyy") %>'
        files:
          src: [
            '<%= paths.dist %>/humans.txt'
          ]

      #dist:
      #  options:
      #    position: 'top'
      #    banner: '<%= meta.banner %>'
      #  files:
      #    src: [
      #      '<%= paths.css %>/*.css'
      #      '<%= paths.js %>/*.js'
      #    ]

    # Compress images
    smushit:
      dist:
        src: '<%= paths.images %>'
        dest:'<%= paths.images %>'

    # Concat files
    #concat:
    #  options:
    #    stripBanners: true
    #    #banner: '<%= meta.banner %>'
    #    separator: ';'
    #  vendor:
    #    files: '<%= paths.js %>/vendor.js': [
    #      '<%= paths.vendor %>/jquery/jquery.js'
    #      '<%= paths.vendor %>/hashgrid/hashgrid.js'
    #    ]

    # Minify files
    uglify:
      options:
        banner: '<%= meta.banner %>'
        beautify: false
        compress: true
        mangle: true
        except: ['jQuery']

      dist:
        files: [
          '<%= paths.js %>/modernizr.min.js': '<%= paths.js %>/modernizr.js'
          '<%= paths.js %>/vendor.min.js': [
            '<%= paths.vendor %>/jquery/jquery.js'
            '<%= paths.vendor %>/hashgrid/hashgrid.js'
          ]
          '<%= paths.js %>/application.min.js': '<%= paths.js %>/application.js'
        ]

    # Clean directories
    clean:
      #images: '<%= paths.images %>'
      #tmp: '<%= paths.tmp %>'
      javascripts: '<%= paths.javascripts %>'
      stylesheets: '<%= paths.stylesheets %>'

    # Compile jade templates
    jade:
      options:
        basePath: null
        client: false
        compileDebug: false
        extension: null
        runtime: false
        locals:

          site:
            name: 'Starter'
            title: 'Starter'
            description: 'A Sass/Compass/Jade/Coffeescript powered, Grunt and Bower based HTML5 starter kit'
            keywords: 'html5,sass,jade,boilerplate'
            email: '<%= jade.options.locals.author.email %>'
            url: 'http://lanceguyatt.com'
            image: '<%= jade.options.locals.site.url %>/screenshot.png'
            lang: 'en'
            dir: 'ltr'
            type: 'website'
            copyrightYear: '2013'

          author:
            name: 'Lance Guyatt'
            email: 'lance@lanceguyatt.com'
            url: 'http://lanceguyatt.com'

          paths:
            images: 'images/'
            css: 'stylesheets/css'
            js: 'javascripts/js'

      #files:
      #  src: ['<%= paths.views %>/{,**/}*.jade']
      #  dest: '<%= paths.dist %>'

      dev:
        src: '<%= paths.jade %>'
        dest: '<%= paths.dist %>'
        options:
          pretty: true

      dist:
        src: '<%= paths.jade %>'
        dest: '<%= paths.dist %>'
        options:
          pretty: false

    # Compile coffee scripts
    coffee:
      dist:
        options:
          bare: true
          banner: '<%= meta.banner %>'
        files: [
          expand: true
          flatten: true
          cwd: '<%= paths.coffee %>'
          src: '*.coffee'
          dest: '<%= paths.js %>'
          ext: '.js'
        ]

    # Compile compass files
    compass:
      options:
        #basePath: ''
        #app: 'stand_alone'
        cssDir: '<%= paths.css %>'
        sassDir: '<%= paths.scss %>'
        javascriptsDir: '<%= paths.js %>'
        imagesDir: '<%= paths.images %>'
        fontsDir: '<%= paths.fonts %>'
        noLineComments: false
        relativeAssets: true
        bundleExec: true
        importPath: '<%= paths.vendor %>'
        require: [
         'breakpoint'
         'compass-normalize'
         'modular-scale'
         'stitch'
         'susy'
        ]

      dev:
        options:
          debugInfo: false
          environment: 'development'
          outputStyle: 'expanded'

      dist:
        options:
          debugInfo: false
          environment: 'production'
          force: true
          noLineComments: true
          outputStyle: 'compressed'

      #clean:
      #  options:
      #    clean: true

    # css min
    cssmin:
      options:
        banner: '<%= meta.banner %>'
      minify:
        expand: true
        cwd: '<%= paths.css %>'
        src: ['*.css', '!*.min.css']
        dest: '<%= paths.css %>'
        ext: '.min.css'

    # Files to watch
    watch:
      jade:
        files: '<%= paths.views %>{,**/}*.jade'
        tasks: [
          'jade:dev'
          'notify:jade'
        ]

      coffee:
        files: '<%= paths.coffee %>/{,**/}*.coffee'
        tasks: [
          'coffee'
          'notify:coffee'
        ]

      compass:
        files: '<%= paths.scss %>/{,**/}*.{scss,sass}'
        tasks: [
          'compass:dev'
          'notify:compass'
        ]

    # Compile modernizr file
    modernizr:
      devFile: '<%= paths.vendor %>/modernizr/modernizr.js'
      outputFile: '<%= paths.js %>/modernizr.js'
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
      uglify: false
      parseFiles: false

    # Task complete messages
    notify:
      dev:
        options:
          message: 'Development running'
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
      usebanner:
        options:
          message: 'Banners added'
      dist:
        options:
          message: 'Distribution complete'

  # Load modules
  grunt.loadNpmTasks 'grunt-banner'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-jade'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-modernizr'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-smushit'

  # Run in development mode
  grunt.registerTask 'default', ['Development mode'], ->
    grunt.task.run 'notify:dev'
    grunt.task.run 'watch'

  # Compile for distribution
  grunt.registerTask 'dist', ['Distribution build'], ->
    grunt.task.run 'clean'
    grunt.task.run 'notify:clean'
    grunt.task.run 'compass:dist'
    grunt.task.run 'cssmin'
    grunt.task.run 'notify:compass'
    grunt.task.run 'coffee'
    grunt.task.run 'notify:coffee'
    #grunt.task.run 'concat'
    #grunt.task.run 'notify:concat'
    grunt.task.run 'modernizr'
    grunt.task.run 'notify:modernizr'
    #grunt.task.run 'usebanner:dist'
    #grunt.task.run 'notify:usebanner'
    grunt.task.run 'jade:dist'
    grunt.task.run 'notify:jade'
    grunt.task.run 'smushit:dist'
    grunt.task.run 'notify:smushit'
    grunt.task.run 'uglify:dist'
    grunt.task.run 'notify:uglify'
    grunt.task.run 'notify:dist'
