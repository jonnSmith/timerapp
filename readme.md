# Laravel Angular Build

### Instruments

CSS: [Stylus](http://stylus-lang.com/)
HTML: [Jade](http://jade-lang.com/)
JS: [CoffeeScript](http://coffeescript.org/)

### Installation

install [Ruby](http://rubyinstaller.org/)

    gem source -a http://rubygems.org/
    gem install sass

install [Node.js](https://nodejs.org/en/download/package-manager/)
go to the app root

    npm install -g grunt-cli
    npm install -g bower
    npm install -g karma-cli
    npm install karma jasmine-core phantomjs --save-dev

    npm install
    bower install
    grunt build
    
### Configuration file package.json:


    {
      "name": "timer",
      "version": "0.0.0",
      "dependencies": {},
      "app":  "app",
      "language": "en",
      "dist": "../../Winginx/home/timer.local/timer/public",
      "views": "../../Winginx/home/timer.local/timer/resources/views",
      "devDependencies": {
        "grunt": "~0.4.1",
        "gruntfile-gtx": "^0.3.0",
        "require-directory": "^2.1.1",
        "grunt-autoprefixer": "~0.4.0",
        "grunt-bower-install": "~1.0.0",
        "grunt-concurrent": "~0.5.0",
        "grunt-contrib-clean": "~0.5.0",
        "grunt-contrib-coffee": "~0.7.0",
        "grunt-contrib-jade": "~0.9.1",
        "grunt-contrib-stylus": "~0.12.0",
        "grunt-contrib-concat": "~0.3.0",
        "grunt-contrib-connect": "~0.5.0",
        "grunt-contrib-copy": "~0.4.1",
        "grunt-contrib-cssmin": "~0.7.0",
        "grunt-contrib-htmlmin": "~0.1.3",
        "grunt-contrib-imagemin": "~0.3.0",
        "grunt-contrib-jshint": "~0.7.1",
        "grunt-contrib-uglify": "~0.2.0",
        "grunt-contrib-watch": "~0.5.2",
        "grunt-google-cdn": "~0.2.0",
        "grunt-recess": "^1.0.1",
        "grunt-contrib-sass": "~1",
        "grunt-pleeease": "~1.3.2",
        "grunt-purifycss": "~0.1.0",
        "grunt-newer": "~0.6.1",
        "grunt-ngmin": "~0.0.2",
        "grunt-rev": "~0.1.0",
        "grunt-svgmin": "~0.2.0",
        "grunt-usemin": "~2.0.0",
        "grunt-karma": "~0.12",
        "jshint-stylish": "~0.1.3",
        "load-grunt-tasks": "~0.4.0",
        "time-grunt": "~0.2.1"
      },
      "engines": {
        "node": ">=0.10.0"
      },
      "scripts": {
        "test": "karma start test\\karma.conf.js"
      }
    }


## Generators

Available generators:

* [angular-jade-stylus](#app) (aka [angular-jade-stylus:app](#app))
* [angular-jade-stylus:controller](#controller)
* [angular-jade-stylus:directive](#directive)
* [angular-jade-stylus:filter](#filter)
* [angular-jade-stylus:route](#route)
* [angular-jade-stylus:service](#service)
* [angular-jade-stylus:provider](#service)
* [angular-jade-stylus:factory](#service)
* [angular-jade-stylus:value](#service)
* [angular-jade-stylus:constant](#service)
* [angular-jade-stylus:decorator](#decorator)
* [angular-jade-stylus:view](#view)

**Note: Generators are to be run from the root directory of your app.**

### Route
Generates a controller and view, and configures a route in `app/scripts/app.js` connecting them.

Example:
```bash
yo angular-jade-stylus:route myroute
```

Produces `app/scripts/controllers/myroute.js`:
```javascript
angular.module('myMod').controller('MyrouteCtrl', function ($scope) {
  // ...
});
```

Produces `app/views/myroute.html`:
```html
<p>This is the myroute view</p>
```

### Controller
Generates a controller in `app/scripts/controllers`.

Example:
```bash
yo angular-jade-stylus:controller user
```

Produces `app/scripts/controllers/user.js`:
```javascript
angular.module('myMod').controller('UserCtrl', function ($scope) {
  // ...
});
```
### Directive
Generates a directive in `app/scripts/directives`.

Example:
```bash
yo angular-jade-stylus:directive myDirective
```

Produces `app/scripts/directives/myDirective.js`:
```javascript
angular.module('myMod').directive('myDirective', function () {
  return {
    template: '<div></div>',
    restrict: 'E',
    link: function postLink(scope, element, attrs) {
      element.text('this is the myDirective directive');
    }
  };
});
```

### Filter
Generates a filter in `app/scripts/filters`.

Example:
```bash
yo angular-jade-stylus:filter myFilter
```

Produces `app/scripts/filters/myFilter.js`:
```javascript
angular.module('myMod').filter('myFilter', function () {
  return function (input) {
    return 'myFilter filter:' + input;
  };
});
```

### View
Generates an HTML view file in `app/views`.

Example:
```bash
yo angular-jade-stylus:view user
```

Produces `app/views/user.html`:
```html
<p>This is the user view</p>
```

### Service
Generates an AngularJS service.

Example:
```bash
yo angular-jade-stylus:service myService
```

Produces `app/scripts/services/myService.js`:
```javascript
angular.module('myMod').service('myService', function () {
  // ...
});
```

You can also do `yo angular-jade-stylus:factory`, `yo angular-jade-stylus:provider`, `yo angular-jade-stylus:value`, and `yo angular-jade-stylus:constant` for other types of services.

### Decorator
Generates an AngularJS service decorator.

Example:
```bash
yo angular-jade-stylus:decorator serviceName
```

Produces `app/scripts/decorators/serviceNameDecorator.js`:
```javascript
angular.module('myMod').config(function ($provide) {
    $provide.decorator('serviceName', function ($delegate) {
      // ...
      return $delegate;
    });
  });
```
