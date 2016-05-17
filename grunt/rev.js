module.exports = {
    dist: {
        files: {
            src: [
                '<%= package.dist %>/scripts/{,*/}*.js',
                '<%= package.dist %>/styles/{,*/}*.css',
                '<%= package.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
                '<%= package.dist %>/styles/fonts/*'
            ]
        }
    }
}