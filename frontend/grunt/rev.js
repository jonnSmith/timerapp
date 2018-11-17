module.exports = {
    dist: {
        files: {
            src: [
                '<%= package.dist %>/scripts/{,*/}*.js',
                '<%= package.dist %>/styles/{,*/}*.css',
                '<%= package.dist %>/styles/fonts/*'
            ]
        }
    }
}