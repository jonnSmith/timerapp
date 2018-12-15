import gulp from 'gulp';
import sass from 'gulp-sass';
import coffee from 'gulp-coffee';
import concat from 'gulp-concat';
import uglify from 'gulp-uglify';
import concatCSS from 'gulp-concat-css';
import cssnano from 'gulp-cssnano';
import clean from 'gulp-clean';
import stylus from 'gulp-stylus';
import nib from 'nib';

import runSequence from 'run-sequence';

const APP_DIR = './angularJS';
const TMP_DIR = './tmp';
const ASSETS_DIR = './public/';

gulp.task('build', (cb) => {
    runSequence('clean-tmp', 'clean-assets', 'fonts', 'styles', 'scripts', 'workers', 'clean-tmp', cb);
});

gulp.task('clean-tmp', _ =>
    gulp.src(TMP_DIR + '*', {read: false})
        .pipe(clean())
);

gulp.task('clean-assets', _ =>
    gulp.src(ASSETS_DIR + '*', {read: false})
        .pipe(clean())
);

gulp.task('fonts', _ =>
    gulp.src(['./node_modules/font-awesome/fonts/*', APP_DIR + '/assets/fonts/*', 'node_modules/material-icons/iconfont/MaterialIcons-Regular.*'])
        .pipe(gulp.dest(ASSETS_DIR + '/fonts/'))
);

gulp.task('workers', _ =>
    gulp.src([APP_DIR + 'angularJS/workers/*'])
        .pipe(gulp.dest(ASSETS_DIR + '/'))
);

gulp.task('styles', (cb) => {
    runSequence('styles-stylus', 'styles-sass', 'styles-concat', cb);
});

gulp.task('styles-sass', _ =>
    gulp.src([APP_DIR + '/assets/bootstrap/bootstrap.scss'])
        .pipe(sass({outputStyle: 'compressed'}))
        .pipe(gulp.dest(TMP_DIR + '/vendor/'))
);

gulp.task('styles-stylus', function(){
    gulp.src(APP_DIR + '/stylus/main.styl')
        .pipe(stylus({ use: nib(), compress: true }))
        .pipe(gulp.dest(TMP_DIR + '/styles/'));
});

gulp.task('styles-concat', _ =>
    gulp.src([
        TMP_DIR + '/vendor/*.css',
        './node_modules/n3-charts/build/LineChart.css',
        './node_modules/angularjs-datepicker/dist/angular-datepicker.min.css',
        './node_modules/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css',
        TMP_DIR + '/styles/*.css'])
    .pipe(concatCSS('compiled.css'))
    .pipe(cssnano())
    .pipe(gulp.dest(ASSETS_DIR + '/styles/'))
);

gulp.task('scripts', (cb) => {
    runSequence('coffee', 'app-scripts', 'vendor-scripts', cb);
});

gulp.task('coffee', _ =>
    gulp.src(APP_DIR + '/coffee/**/*.coffee', {base: APP_DIR + '/coffee'})
        .pipe(coffee({bare: true}))
        .pipe(gulp.dest(TMP_DIR + '/scripts/'))
);

gulp.task('app-scripts', _ =>
    gulp.src([
        TMP_DIR + '/scripts/app.js',
        TMP_DIR + '/scripts/controllers/auth.js',
        TMP_DIR + '/scripts/controllers/dashboard.js',
        TMP_DIR + '/scripts/controllers/users.js',
        TMP_DIR + '/scripts/controllers/user.js',
        TMP_DIR + '/scripts/controllers/settings.js',
        TMP_DIR + '/scripts/controllers/group.js',
        TMP_DIR + '/scripts/controllers/manage.js',
        TMP_DIR + '/scripts/services/usersfactory.js',
        TMP_DIR + '/scripts/services/timefactory.js',
        TMP_DIR + '/scripts/services/timerfactory.js',
        TMP_DIR + '/scripts/services/apitimefactory.js',
        TMP_DIR + '/scripts/services/userfactory.js',
        TMP_DIR + '/scripts/services/groupfactory.js',
        TMP_DIR + '/scripts/services/iplocationfactory.js',
        TMP_DIR + '/scripts/services/colorfactory.js',
        TMP_DIR + '/scripts/services/charttimesfactory.js',
        TMP_DIR + '/scripts/directives/addressshow.js',
        TMP_DIR + '/scripts/directives/timerange.js',
        TMP_DIR + '/scripts/directives/pwgen.js',
        TMP_DIR + '/scripts/filters/locationfilter.js',
        TMP_DIR + '/scripts/filters/timesfilter.js',
        TMP_DIR + '/scripts/filters/strikedfilter.js',
        TMP_DIR + '/scripts/filters/timestampfilter.js',
        TMP_DIR + '/scripts/directives/message.js',
        TMP_DIR + '/scripts/services/message.js'])
        .pipe(concat('app.js'))
        .pipe(gulp.dest(ASSETS_DIR + '/scripts/'))
);

gulp.task('vendor-scripts', _ =>
    gulp.src([
        './node_modules/jquery/dist/jquery.js',
        './node_modules/es5-shim/es5-shim.js',
        './node_modules/angular/angular.js',
        './node_modules/json3/lib/json3.min.js',
        './node_modules/tether/dist/js/tether.js',
        './node_modules/bootstrap/dist/js/bootstrap.js',
        './node_modules/angular-ui-router/release/angular-ui-router.js',
        './node_modules/satellizer/satellizer.js',
        './node_modules/ngGeolocation/ngGeolocation.js',
        './node_modules/ngmap/build/scripts/ng-map.js',
        './node_modules/angularjs-datepicker/dist/angular-datepicker.min.js',
        './node_modules/ngstorage/ngStorage.js',
        './node_modules/pace.js/pace.js',
        './node_modules/d3/d3.js',
        './node_modules/n3-charts/build/LineChart.js',
        './node_modules/jquery/dist/jquery.js',
        './node_modules/bootstrap/dist/js/bootstrap.js',
        './node_modules/letteringjs/jquery.lettering.js',
        './node_modules/trianglify/dist/trianglify.min.js'])
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest(ASSETS_DIR + '/scripts/'))
        .pipe(uglify())
        .pipe(gulp.dest(ASSETS_DIR + '/scripts/'))
);