module.exports = {
    options: {
        livereload: 7007
    },
    livereload: {
        options: {
            open: true,
            base: [
                '.tmp',
                '<%= package.app %>'
            ]
        }
    },
    dist: {
        options: {
            base: '<%= package.dist %>'
        }
    }
}