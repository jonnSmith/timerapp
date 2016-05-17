module.exports = {
    dist: {
        files: [{
            dot: true,
            src: [
                '.tmp',
                '!<%= package.dist %>/.git*',
                '!<%= package.dist %>/languages*',
                '!<%= package.dist %>/.idea*'
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