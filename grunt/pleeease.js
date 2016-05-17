module.exports = {
    dist: {
        options: {
            "minifier": {preserveHacks: true, removeAllComments: true},
            "mqpacker": true,
            "less": false
        },
        files: {
            '<%= package.dist %>/styles/' : '<%= package.dist %>/styles/*.css'
        }
    }
}