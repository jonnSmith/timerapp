module.exports = {
    fonts: {
        files: [
            {
                src: "**",
                dest: "<%= package.app %>/fonts",
                cwd: '<%= package.app %>/bower_components/bootstrap/fonts',
                expand: true
            },
            {
                src: "**",
                dest: "<%= package.app %>/fonts",
                cwd: '<%= package.app %>/bower_components/font-awesome/fonts',
                expand: true
            }
        ]
    },
    dist: {
        files: [{
            expand: true,
            dot: true,
            cwd: '<%= package.app %>',
            dest: '<%= package.dist %>',
            src: [
                '*.{ico,png,txt}',
                '.htaccess',
                '*.html',
                '*.config',
                'languages/{,*/}*.json',
                'views/{,*/}*.html',
                'tpl/{,*/}*.html',
                'images/{,*/}*.{webp}',
                'fonts/*'
            ]
        }, {
            expand: true,
            cwd: '.tmp/images',
            dest: '<%= package.dist %>/images',
            src: ['generated/*']
        }]
    },
    styles: {
        expand: true,
        cwd: '<%= package.app %>/styles',
        dest: '.tmp/styles/',
        src: '{,*/}*.css'
    },
    views: {
        expand: true,
        cwd: '<%= package.dist %>',
        dest: '<%= package.views %>/',
        src: 'index.html',
        rename: function(dest, src) {
            return dest + src.replace(/\.html$/, ".blade.php");
        }
    }
}