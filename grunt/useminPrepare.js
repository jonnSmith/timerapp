module.exports = {
    html: '<%= package.dist %>/index.html',
    options: {
        root: '<%= package.app %>',
        dest: '<%= package.dist %>',
        flow: {
            html: {
                steps: {
                    js: ['concat', 'uglifyjs'],
                    css: ['cssmin']
                },
                post: {}
            }
        }
    }
}