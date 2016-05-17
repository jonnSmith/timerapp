module.exports = {
    test: {
        options: {
            compress: false
        },
        files: {
            '.tmp/styles/main.css': ['<%= package.app %>/styles/main.styl']
        }
    },
    server: {
        options: {
            compress: false
        },
        files: {
            '.tmp/styles/main.css': ['<%= package.app %>/styles/main.styl']
        }
    },
    dist: {
        options: {
            compress: true
        },
        files: {
            '.tmp/styles/main.css': ['<%= package.app %>/styles/main.styl']
        }
    }
}