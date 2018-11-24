# Laravel Angular Build

[![Build Status](https://travis-ci.org/laravel/framework.svg)](https://travis-ci.org/laravel/framework)
[![Total Downloads](https://poser.pugx.org/laravel/framework/d/total.svg)](https://packagist.org/packages/laravel/framework)
[![Latest Stable Version](https://poser.pugx.org/laravel/framework/v/stable.svg)](https://packagist.org/packages/laravel/framework)
[![Latest Unstable Version](https://poser.pugx.org/laravel/framework/v/unstable.svg)](https://packagist.org/packages/laravel/framework)
[![License](https://poser.pugx.org/laravel/framework/license.svg)](https://packagist.org/packages/laravel/framework)

# Install

    composer install
    
Rename .env.example to .env. Setup your database connection ad app url

    APP_URL=http://timer.local
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=timer
    DB_USERNAME=root
    DB_PASSWORD=root

Create storage folders

    storage/app/public/
    storage/framework/cache/
    storage/framework/sessions/
    storage/framework/views/

Set migrations and seeds

    php artisan migrate
    php artisan db:seed 
    
Set app key

    php artisan key:generate
   
Set JWT config

    php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\JWTAuthServiceProvider"
    php artisan jwt:generate
    
That's it! Now you can setup [frontend repository](https://bitbucket.org/iskraua/lab-fe/src) and build it into backend.