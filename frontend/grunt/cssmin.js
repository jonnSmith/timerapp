module.exports = {
    usemin: {
        options: {
            shorthandCompacting: true,
            roundingPrecision: -1,
            root: '<%= package.app %>'
        }
    },
    auto: {
        dist: {
            files: {
                '<%= package.dist %>/styles/main.css': [
                    '.tmp/styles/{,*/}*.css',
                    '<%= package.app %>/styles/{,*/}*.css'
                ]
            }
        }
    }
}