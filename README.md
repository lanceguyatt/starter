# Starter

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/lanceguyatt/starter/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
[![NPM](https://nodei.co/npm/starter.png?downloads=true&stars=true)](https://nodei.co/npm/starter/)

> A Sass/Compass/Jade/Coffeescript powered, Grunt and Bower based HTML5 starter kit

Install it running

```bash
npm install starter
```

Development mode - watch for changes and compile sass, autoprefix

    ~ grunt

Distribution mode (uglify, concat, build a custom modernizr, compress css, comb css, autoprefix, htmlmin)

    ~ grunt dist

Directory structure

    project_folder
        |_ dist
            |_ css
                style.css
                style-lt-ie9.css
            |_ fonts
            |_ images
            |_ js
            .htaccess
            apple-touch-icon-57x57-precomposed.png
            apple-touch-icon-72x72-precomposed.png
            apple-touch-icon-114x114-precomposed.png
            apple-touch-icon-144x144-precomposed.png
            apple-touch-icon-precomposed.png
            apple-touch-icon.png
            crossdomain.xml
            favicon.ico
            grid.html
            humans.txt
            index.html
            logo.png
            robots.txt
            styleguide.html
        |_ node_modules
        |_ src
            |_ bower // bower plugins
            |_ coffee
                |_ app.coffee
                |_ plugins.coffee
            |_ routes
                globals.json  // jade locals
            |_ scss
                |_ _all.scss
                |_ _base
                |_ _elements
                |_ _helpers
                |_ _media
                |_ _modules
                |_ _page
                |_ _settings.scss
                |_ style-lt-ie9.scss
                |_ style.scss
            |_ views
                |_ _helpers
                |_ _includes
                |_ _layouts
                grid.jade
                index.jade
                styleguide.jade
        .bowerrc
        .csscomb.json
        .csslintrc
        .editorconfig
        .git
        .gitattributes
        .gitignore
        .jshintrc
        .sass-cache
        .travis.yml
        bower.json
        dist
        Gemfile
        Gemfile.lock
        Gruntfile.coffee
        LICENSE
        node_modules
        package.json
        README.md
        src


