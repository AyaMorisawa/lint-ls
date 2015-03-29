require! {
	gulp
	'gulp-livescript': ls
}

gulp.task \test ->

gulp.task \build <[ build-package-json build-src ]>

gulp.task \build-package-json ->
	gulp.src './package.json.ls'
		.pipe ls!
		.pipe gulp.dest './'

gulp.task \build-src ->
	gulp.src './src/**/*.ls'
		.pipe ls!
		.pipe gulp.dest './lib'
