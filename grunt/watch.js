module.exports = {
    bower: {
        files: ['bower.json'],
        tasks: ['bowerInstall']
    },
    coffee: {
        files: ['<%= package.app %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}'],
        tasks: ['newer:coffee:dist']
    },
    coffeeTest: {
        files: ['test/spec/{,*/}*.{coffee,litcoffee,coffee.md}'],
        tasks: ['newer:coffee:test', 'karma']
    },
    stylus: {
        files: ['<%= package.app %>/styles/{,*/}*.styl'],
        tasks: ['stylus:server', 'autoprefixer']
    },
    jade: {
        files: ['<%= package.app %>/views/{,*/}*.jade','<%= package.app %>/tpl/{,*/}*.jade', '<%= package.app %>/*.jade'],
        tasks: ['bowerInstall', 'jade:server']
    },
    gruntfile: {
        files: ['Gruntfile.js']
    },
    livereload: {
        options: {
            livereload: '<%= connect.options.livereload %>'
        },
        files: [
            '.tmp/{,*/}*.html',
            '.tmp/styles/{,*/}*.css',
            '.tmp/scripts/{,*/}*.js',
            '<%= package.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
        ]
    }
}