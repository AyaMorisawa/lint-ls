name: 'lint-ls'
version: '0.1.0'

description: 'Linter for LiveScript'

author:
	name: 'Aya Morisawa'
	url: 'https://github.com/AyaMorisawa'

homepage: 'https://github.com/AyaMorisawa/lint-ls'
bugs: 'https://github.com/AyaMorisawa/lint-ls/issues'
license: 'MIT'

main: './lib/'
bin:
	'lint-ls': './bin/lint-ls'

scripts:
	test: 'gulp test'
	build: 'gulp build'

repository:
	type: 'git'
	url: 'git://github.com/AyaMorisawa/lint-ls.git'

dependencies:
	LiveScript: '1.3.1'
	'prelude-ls': '1.1.1'

dev-dependencies:
	gulp: '3.8.11'
	'gulp-livescript': '2.3.0'
