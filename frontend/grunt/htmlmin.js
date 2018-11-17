module.exports = {
    dist: {
        options: {
            collapseWhitespace: true,
            collapseBooleanAttributes: true,
            removeCommentsFromCDATA: true,
            removeOptionalTags: false
        },
        files: [{
            expand: true,
            cwd: '<%= package.dist %>',
            src: ['*.html', 'views/{,*/}*.html', 'tpl/{,*/}*.html'],
            dest: '<%= package.dist %>'
        }]
    }
}