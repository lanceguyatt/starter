# __starter__, based on HTML5 Boilerplate

This project extends [HTML5 Boilerplate](https://github.com/h5bp/html5-boilerplate) with some more structure for SCSS files and JavaScripts.

## Dependencies

You will need to install some stuff, if you haven't already:

Majors:

* Node.js
* Ruby

Secondaries:

* Node: npm
* Ruby: SASS

After you've set this stuff up please run

  $ npm install -g grunt-cli

This installs the Grunt command line tools.
Afterwards please run

  $ npm install

in your project's directory.
This will install all the things you need for running the grunt-tasks automatically.


## Installation

### Bower

[Bower](http://bower.io/)

Bower is a package manager for the web. It offers a generic, unopinionated solution to the problem of front-end package management, while exposing the package dependency model via an API that can be consumed by a more opinionated build stack. There are no system wide dependencies, no dependencies are shared between different apps, and the dependency tree is flat.

Bower runs over Git, and is package-agnostic. A packaged component can be made up of any type of asset, and use any type of transport (e.g., AMD, CommonJS, etc.).

    bower install

  Will install dependencies listed in the project directory `bower.json`

    grunt dev

    grunt dist (production mode)

### Troubleshooting

If running the install does not work, please try running it as with admin-rights:

  $ sudo npm install -g grunt-cli

## CSS

We are currently working with [SASS](http://sass-lang.com/) (in its dialect SCSS) and do not use CSS directly. Please do not edit the CSS-files in any case but search the correct `.scss` file and edit the according SCSS. If you are not familiar with SCSS you can write pure CSS which is actually valid SCSS.

However all `.scss`-files are compiled into one file called `main.css` in the `css`-folder. There is a productive-version too.

You can find more information about the installation process of SASS and the usage of SCSS in the [SASS Tutorial](http://sass-lang.com/tutorial.html).


## JS

We use jQuery and Modernizr (custom build via Grunt).

Please use JSHint for your JavaScript before you commit. You can use the Grunt-task `jshint` for this. It is also integrated in `grunt watch`.


## Deployment

Please use [Grunt.js](https://github.com/cowboy/grunt) for building a production-state of a website. The `Gruntfile.coffee` has tasks for concatenating and minifing CSS and JavaScript.

Additional information on this project is stored in `package.json`.


## Development

This package is developed and maintained by [Lance Guyatt](http://lanceguyatt.com/).


## License

### Major components:

* Grunt: MIT license
* HTML5 Boilerplate: MIT license
* jQuery: MIT/GPL license
* Modernizr: MIT/BSD license
* Normalize.css: MIT license
* Bower
* Compass
* Susy
* Stitch CSS

### Everything that has been developed by the contributors to this project:

The MIT License (MIT)
Copyright 2013 Lance Guyatt, http://lanceguyatt.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[![Ninja](src/images/ninja.png)](https://github.com/kasperisager/Ninja)

# Ninja [![Build Status](https://travis-ci.org/kasperisager/Ninja.png)](https://travis-ci.org/kasperisager/Ninja) [![Dependency Status](https://gemnasium.com/kasperisager/Ninja.png)](https://gemnasium.com/kasperisager/Ninja)

Ninja is a super sneaky [Node.js](http://nodejs.org/), [Grunt](http://gruntjs.com/) and [Bower](http://twitter.github.com/bower/) powered scaffold for building superb Vanilla themes. Ninja allows you to easily use your choice of preprocessors and languages in your themes and enables you to write kick-ass build processes using the many [plugins available for Grunt](http://gruntjs.com/plugins).

Ninja will also stealthily do browser sniffing and feature detection using [Conditionizr](https://github.com/conditionizr/conditionizr) and [Modernizr](https://github.com/Modernizr/Modernizr) and will also reload your assets whenever they change using [LiveReload](http://livereload.com/) - like a true shinobi!


## Getting started

To get started using Ninja, either:
- [Download the latest release](https://github.com/kasperisager/Ninja/archive/master.zip)
- Clone the repository directly into your Vanilla `themes` directory:  
`$ cd /path/to/vanilla/themes/`  
`$ git clone git://github.com/kasperisager/Ninja.git`

Now that you've downloaded Ninja, it's time to get it installed. Ninja uses [npm](https://npmjs.org/) for managing [development dependencies](package.json) and Bower for managing [component dependencies](component.json):

```sh
$ npm install
$ bower install
```

### Prerequisites

The above installation instructions assume that you've already installed Node.js on your computer. If this is not the case, please download and install the latest version from the official [Node.js download page](http://nodejs.org/download/).

For Grunt.js to work, you'll need to install [Grunt CLI](https://github.com/gruntjs/grunt-cli). This can be done using npm - notice that Grunt CLI must be installed globally:

```sh
$ npm install -g grunt-cli
```

For component management, you'll need to install Bower. Just like Grunt CLI, Bower must be installed globally:

```sh
$ npm install -g bower
```

Lastly, if you want to use compilers and frameworks that aren't written in Node.js and therefore not available through npm, you'll need to install these. This is the case for the Compass Framework, which is used in the Ninja example theme:  
```sh
$ gem update --system
$ gem install compass
```


## Compiling assets

Once you've completed all of the above steps, you should be all set to start developing Vanilla themes using Ninja. Ninja comes with a couple of built-in Grunt tasks that you can use for compiling the source:

#### build - `grunt`
Runs the default Grunt task which will compile all assets including the Ninja scripts (`.coffee` by default) and stylesheets (`.sass` by default) as well as assets installed via Bower ([Bootstrap](https://github.com/twitter/bootstrap), Modernizr and Conditionizr by default).

#### watch - `grunt ninja`
Starts an instance of [Reloadr](https://npmjs.org/package/grunt-reloadr) (a basic LiveReload CLI) that watches the compiled assets for changes and pushes these to your Vanilla installation automatically and runs the `watch` tasks that watches your source assets and compiles these whenever they change.


## Issue tracking

If you come across any bugs or if you have a feature request, please [file an issue](https://github.com/kasperisager/Ninja/issues) using the Github Issue tracker. Ninja won't be supported through http://vanillaforums.org so please stick to using Github for inquires about bugs and feature requests. Thanks!


## Special thanks

#### Ninja Logo
Huge thanks to [Chris Spooner](http://twitter.com/chrisspooner) of [Spoon Graphics](http://www.spoongraphics.co.uk/) for his [tutorial](http://blog.spoongraphics.co.uk/tutorials/illustrator-tutorial-create-a-gang-of-vector-ninjas) on how to create vector Ninjas in Adobe Illustrator. I absolutely suck at stuff like that so it was awesome having someone show how it's done!

---
Copyright © 2013 [Kasper K. Isager](https://github.com/kasperisager). Licensed under the terms of the [MIT License](LICENSE.md)
