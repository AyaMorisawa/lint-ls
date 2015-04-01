name: 'lint-ls'
version: '0.5.0'

description: 'Linter for LiveScript'

author:
	name: 'Aya Morisawa'
	url: 'https://github.com/AyaMorisawa'

homepage: 'https://github.com/AyaMorisawa/lint-ls'
bugs: 'https://github.com/AyaMorisawa/lint-ls/issues'
license: 'MIT'

main: './lib/'

scripts:
	test: 'gulp test'
	build: 'gulp build'

repository:
	type: 'git'
	url: 'git://github.com/AyaMorisawa/lint-ls.git'

dependencies:
	LiveScript: '1.3.1'
	'prelude-ls': '1.1.1'
	'get-tuple': '0.0.1'

dev-dependencies:
	gulp: '3.8.11'
	'gulp-livescript': '2.3.0'
	'gulp-lint-ls': '0.1.0'
	'gulp-mocha': '2.0.1'
	chai: '2.2.0'
