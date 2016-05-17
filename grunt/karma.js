module.exports = {
    unit: {
        configFile: 'test/karma.conf.coffee',
        singleRun: true,
        options: {
            basePath: '../',
            files: [
                '<%= package.app %>/bower_components/angular/angular.js',
                '<%= package.app %>/bower_components/angular-cookies/angular-cookies.js',
                '<%= package.app %>/bower_components/angular-mocks/angular-mocks.js',
                '<%= package.app %>/bower_components/angular-resource/angular-resource.js',
                '<%= package.app %>/bower_components/angular-route/angular-route.js',
                '<%= package.app %>/bower_components/angular-sanitize/angular-sanitize.js',
                '<%= package.app %>/scripts/**/*.coffee',
                'test/mock/**/*.coffee',
                'test/spec/**/*.coffee'
            ]
        }
    }
}