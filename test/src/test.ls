require! {
	chai: {should}
	'../../lib/': lint
}

should!

describe \line-number (...) ->
	it \1 ->
		lint 'class HogeHuga' .should.eql [[1 \class-is-not-allowed]]
	it \2 ->
		lint '\nclass HogeHuga' .should.eql [[2 \class-is-not-allowed]]

describe \lint (...) ->
	it \allow-class ->
		lint 'class HogeHuga' .should.eql [[1 \class-is-not-allowed]]

	it \allow-new ->
		lint 'a = new B' .should.eql [[1 \new-is-not-allowed]]

	it \allow-return ->
		lint 'return 42' .should.eql [[1 \return-is-not-allowed]]

	it \allow-throw ->
		lint 'throw "An error"' .should.eql [[1 \throw-is-not-allowed]]

	it \allow-break ->
		lint '''
while a
  b!
  break
''' {+allow-while} .should.eql [[3 \break-is-not-allowed]]

	it \allow-continue ->
		lint '''
while a
  b!
  continue
''' {+allow-while} .should.eql [[3 \continue-is-not-allowed]]

	it \allow-while ->
		lint '''
while a
  b!
''' .should.eql [[1 \while-is-not-allowed]]

	it \allow-case ->
		lint '''
switch
case a => b!
''' {-allow-case} .should.eql [[2 \case-is-not-allowed]]

	it \allow-default ->
		lint '''
switch a
case b => c!
default => d!
''' {+allow-case} .should.eql [[3 \default-is-not-allowed]]

	it \allow-null ->
		lint 'a = null' .should.eql [[1 \null-is-not-allowed]]

	it \allow-void ->
		lint 'a = void' .should.eql [[1 \void-is-not-allowed]]

	it \allow-this ->
		lint 'a = this.b' .should.eql [[1 \this-is-not-allowed]]

	it \allow-delete ->
		lint 'delete a.b' .should.eql [[1 \delete-is-not-allowed]]

	it \allow-eval ->
		lint 'a = eval b' .should.eql [[1 \eval-is-not-allowed]]

	describe \enforce-pascal-case-class-name (...) ->
		it \pascal-case-1 ->
			lint 'class Hoge' {+allow-class} .should.be.empty
		it \pascal-case-2 ->
			lint 'class HogeHuga' {+allow-class} .should.be.empty
		it \lower-camel-case ->
			lint 'class hogeHuga' {+allow-class} .should.eql [[1 \class-name-must-be-pascal-case]]
		it \lower-chain-case ->
			lint 'class hoge-huga' {+allow-class} .should.eql [[1 \class-name-must-be-pascal-case]]
		it \upper-chain-case ->
			lint 'class HOGE-HUGA' {+allow-class} .should.eql [[1 \class-name-must-be-pascal-case]]
		it \lower-snake-case ->
			lint 'class hoge_huga' {+allow-class} .should.eql [[1 \class-name-must-be-pascal-case]]
		it \upper-snake-case ->
			lint 'class HOGE_HUGA' {+allow-class} .should.eql [[1 \class-name-must-be-pascal-case]]
