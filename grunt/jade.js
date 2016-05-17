module.exports = {
    options: {
        pretty: true,
        basedir: './',
        data: function (dest, src) {
            return require('../app/languages/'+this.language+'/data.json');
        }
    },
    server: {
        files: [{
            language: '<%= package.language %>',
            expand: true,
            cwd: '<%= package.app %>',
            dest: '.tmp',
            src: ['*.jade', 'views/{,*/}*.jade', 'tpl/{,*/}*.jade'],
            ext: '.html'
        }]
    },
    dist: {
        files: [{
            language: '<%= package.language %>',
            expand: true,
            cwd: '<%= package.app %>',
            dest: '<%= package.dist %>',
            src: ['*.jade', 'views/{,*/}*.jade', 'tpl/{,*/}*.jade'],
            ext: '.html'
        }]
    }
}