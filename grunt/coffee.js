module.exports = {
    options: {
        sourceMap: true,
        sourceRoot: ''
    },
    server: {
        files: [{
            expand: true,
            cwd: '<%= package.app %>/scripts',
            src: '{,*/}*.coffee',
            dest: '.tmp/scripts',
            ext: '.js'
        }]
    },
    dist: {
        sourceMap: false,
        files: [{
            expand: true,
            cwd: '<%= package.app %>/scripts',
            src: '{,*/}*.coffee',
            dest: '.tmp/scripts',
            ext: '.js'
        }]
    },
    test: {
        files: [{
            expand: true,
            cwd: 'test/spec',
            src: '{,*/}*.coffee',
            dest: '.tmp/spec',
            ext: '.js'
        }]
    }
}