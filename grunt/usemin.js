module.exports = {
    html: ['<%= package.dist %>/{,*/}*.html'],
    css: ['<%= package.dist %>/styles/{,*/}*.css'],
    options: {
        assetsDirs: ['<%= package.dist %>']
    }
}