module.exports = {
    main: {
        src: ['<%= package.dist %>/**/*.html','<%= package.dist %>/scripts/*.js'],
        css: ['<%= package.dist %>/styles/main.css'],
        dest: '<%= package.dist %>/styles/main.css'
    }
}