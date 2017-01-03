var gulp = require('gulp'),
	help = require('gulp-task-listing'),
    run = require('gulp-run');

// Generate a nice output of the available tasks within this gulpfile.
gulp.task('help', help);

// The default gulp task, let's run help.
gulp.task('default', function () {
	gulp.start('help');
});

// Update the docs.
gulp.task('docs-build', function () {
    return run('docker exec linz_rtd_1 make html')
            .exec();
});

// Watch for changes and rebuild the docs as required.
gulp.task('docs-build-watch', function () {
    gulp.watch('/linz/docs/**/*.rst', ['docs-build']);
});
