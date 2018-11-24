<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

Route::get('/', function () {
    return view('index');
});


Route::post('/api/authenticate', 'AuthenticateController@authenticate');
Route::any('/api/user/create', 'UserController@create');

Route::group(['prefix' => 'api', 'middleware' => 'jwt.auth'], function()
{
    Route::resource('users', 'UserController', ['except' => ['store','edit']]);

    Route::get('users/{users}/times', 'UserController@times');
    Route::any('users/{users}/times/start', 'TimeController@start');
    Route::any('users/{users}/times/end', 'TimeController@end');
    Route::any('users/{users}/times/strike', 'TimeController@strike');

    Route::resource('usergroups', 'UserGroupController', ['except' => ['store','edit', 'create']]);
    Route::any('usergroups/create', 'UserGroupController@create');
    Route::any('usergroups/{id}/adduser/{user_id}', 'UserGroupController@adduser');
    Route::any('usergroups/{id}/removeuser/{user_id}', 'UserGroupController@removeuser');
    Route::any('usergroups/{id}/setmoderator/{user_id}', 'UserGroupController@setmoderator');

    Route::resource('authenticate', 'AuthenticateController', ['only' => ['index']]);
    Route::any('authenticate/user', 'AuthenticateController@getAuthenticatedUser');

    Route::any('authenticate/refresh', 'AuthenticateController@refreshToken');

    Route::group(['prefix' => 'time'], function()
    {
        Route::any('start', 'TimeController@start');
        Route::any('end', 'TimeController@end');
        Route::any('strike', 'TimeController@strike');
    });
});