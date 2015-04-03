require! {
	gulp
	'gulp-livescript': ls
	'gulp-lint-ls': lint-ls
	'gulp-mocha': mocha
}

gulp.task \test <[ lint build ]> ->
	gulp.src './test/lib/**/*.js'
		.pipe mocha reporter: \list

gulp.task \lint ->
	gulp.src './**/*.ls'
		.pipe lint-ls {+allow-void}

gulp.task \build <[ build-package-json build-src build-test ]>

gulp.task \build-package-json ->
	gulp.src './package.json.ls'
		.pipe ls!
		.pipe gulp.dest './'

gulp.task \build-src ->
	gulp.src './src/**/*.ls'
		.pipe ls!
		.pipe gulp.dest './lib'

gulp.task \build-test ->
	gulp.src './test/src/**/*.ls'
		.pipe ls!
		.pipe gulp.dest './test/lib'
