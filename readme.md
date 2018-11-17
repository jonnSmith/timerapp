# Timer Application Laravel + AngularJS

# Frontend installation (/frontend)

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
    npm install -g jshint
    npm install karma jasmine-core phantomjs --save-dev

    npm install
    bower install
    grunt build --force

# Backend installation (/backend)

### Requirements

    PHP >= 7.1.3
    OpenSSL PHP Extension
    PDO PHP Extension
    Mbstring PHP Extension
    Tokenizer PHP Extension
    XML PHP Extension
    Ctype PHP Extension
    JSON PHP Extension

### Installation

    composer install
    php artisan serve




