module.exports = {
    dist: {
        files: [{
            expand: true,
            cwd: '<%= package.app %>/images',
            src: '{,*/}*.{png,jpg,jpeg,gif}',
            dest: '<%= package.dist %>/images'
        }]
    }
}