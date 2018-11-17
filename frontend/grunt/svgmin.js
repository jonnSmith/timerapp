module.exports = {
    dist: {
        files: [{
            expand: true,
            cwd: '<%= package.app %>/images',
            src: '{,*/}*.svg',
            dest: '<%= package.dist %>/images'
        }]
    }
}