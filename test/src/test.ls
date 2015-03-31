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

describe \allow-class (...) ->
	it \no ->
		lint 'class HogeHuga' .should.eql [[1 \class-is-not-allowed]]

describe \allow-return (...) ->
	it \no ->
		lint 'return 42' .should.eql [[1 \return-is-not-allowed]]

describe \allow-throw (...) ->
	it \no ->
		lint 'throw "An error"' .should.eql [[1 \throw-is-not-allowed]]

describe \allow-break (...) ->
	it \no ->
		lint '''
while a
  b!
  break
''' {+allow-while} .should.eql [[3 \break-is-not-allowed]]

describe \allow-continue (...) ->
	it \no ->
		lint '''
while a
  b!
  continue
''' {+allow-while} .should.eql [[3 \continue-is-not-allowed]]

describe \allow-while (...) ->
	it \no ->
		lint '''
while a
  b!
''' .should.eql [[1 \while-is-not-allowed]]


describe \allow-case (...) ->
	it \no ->
		lint '''
switch
case a => b!
''' {-allow-case} .should.eql [[2 \case-is-not-allowed]]


describe \allow-default (...) ->
	it \no ->
		lint '''
switch a
case b => c!
default => d!
''' {+allow-case} .should.eql [[3 \default-is-not-allowed]]


describe \allow-null (...) ->
	it \no ->
		lint 'a = null' .should.eql [[1 \null-is-not-allowed]]


describe \allow-void (...) ->
	it \no ->
		lint 'a = void' .should.eql [[1 \void-is-not-allowed]]


describe \allow-this (...) ->
	it \no ->
		lint 'a = this.b' .should.eql [[1 \this-is-not-allowed]]


describe \allow-delete (...) ->
	it \no ->
		lint 'delete a.b' .should.eql [[1 \delete-is-not-allowed]]

describe \allow-eval (...) ->
	it \no ->
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
