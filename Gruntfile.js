// Generated on 2016-05-17 using generator-angular-jade-stylus 0.8.8
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

    var gtx = require('gruntfile-gtx').wrap(grunt);
    gtx.loadAuto();
    var gruntConfig = require('./grunt');
    gruntConfig.package = require('./package.json');
    gtx.config(gruntConfig);

    gtx.alias('build', [
        'clean:dist',
        'bowerInstall',
        'jade:dist',
        'coffee:dist',
        'stylus:dist',
        'useminPrepare',
        'concurrent:dist',
        'autoprefixer',
        'concat',
        'ngmin',
        'copy:fonts',
        'copy:dist',
        'cdnify',
        'cssmin',
        'uglify',
        'rev',
        'usemin',
        'htmlmin',
        'sass',
        'pleeease',
        'copy:views',
        'clean:views'
    ]);

    gtx.finalise();

};
