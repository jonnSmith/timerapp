module.exports = {
    dist: {
        files: [{
            dot: true,
            src: [
                '.tmp',
                '<%= package.dist %>/views/*',
                '<%= package.dist %>/scripts/*',
                '<%= package.dist %>/styles/*',
                '<%= package.dist %>/images/*',
                '<%= package.views %>/index.blade.php'
            ]
        }]
    },
    views: {
        files: [{
            dot: true,
            src: [
                '<%= package.dist %>/index.html'
            ]
        }]
    },
    server: '.tmp',
    options: { force: true }
}