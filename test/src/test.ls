require! {
	chai: {should}
	'../../lib/': lint-ls
}

should!

describe \allow-class (...) ->
	it \no ->
		lint-ls 'class HogeHuga' .should.have.deep.property '[0][1]' .equal \class-is-not-allowed

describe \allow-return (...) ->
	it \no ->
		lint-ls 'return 42' .should.have.deep.property '[0][1]' .equal \return-is-not-allowed

describe \allow-throw (...) ->
	it \no ->
		lint-ls 'throw "An error"' .should.have.deep.property '[0][1]' .equal \throw-is-not-allowed

describe \allow-break (...) ->
	it \no ->
		lint-ls '''
while a
  b!
  break
''' {+allow-while} .should.have.deep.property '[0][1]' .equal \break-is-not-allowed

describe \allow-continue (...) ->
	it \no ->
		lint-ls '''
while a
  b!
  continue
''' {+allow-while} .should.have.deep.property '[0][1]' .equal \continue-is-not-allowed

describe \allow-while (...) ->
	it \no ->
		lint-ls '''
while a
  b!
''' .should.have.deep.property '[0][1]' .equal \while-is-not-allowed


describe \allow-case (...) ->
	it \no ->
		lint-ls '''
switch
case a => b!
''' .should.have.deep.property '[0][1]' .equal \case-is-not-allowed


describe \allow-default (...) ->
	it \no ->
		lint-ls '''
switch a
case b => c!
default => d!
''' {+allow-case} .should.have.deep.property '[0][1]' .equal \default-is-not-allowed


describe \allow-null (...) ->
	it \no ->
		lint-ls 'a = null' .should.have.deep.property '[0][1]' .equal \null-is-not-allowed


describe \allow-void (...) ->
	it \no ->
		lint-ls 'a = void' .should.have.deep.property '[0][1]' .equal \void-is-not-allowed


describe \allow-this (...) ->
	it \no ->
		lint-ls 'a = this.b' .should.have.deep.property '[0][1]' .equal \this-is-not-allowed


describe \allow-delete (...) ->
	it \no ->
		lint-ls 'delete a.b' .should.have.deep.property '[0][1]' .equal \delete-is-not-allowed


describe \allow-eval (...) ->
	it \no ->
		lint-ls 'a = eval b' .should.have.deep.property '[0][1]' .equal \eval-is-not-allowed

describe \enforce-pascal-case-class-name (...) ->
	it \pascal-case-1 ->
		lint 'class Hoge' {+allow-class} .should.be.empty
	it \pascal-case-2
		lint 'class HogeHuga' {+allow-class} .should.be.empty
	it \lower-camel-case
		lint 'class hogeHuga' {+allow-class} .should.have.deep.property '[0][1]' .equal \class-name-must-be-pascal-case
	it \lower-chain-case
		lint 'class hoge-huga' {+allow-class} .should.have.deep.property '[0][1]' .equal \class-name-must-be-pascal-case
	it \upper-chain-case
		lint 'class HOGE-HUGA' {+allow-class} .should.have.deep.property '[0][1]' .equal \class-name-must-be-pascal-case
	it \lower-snake-case
		lint 'class hoge_huga' {+allow-class} .should.have.deep.property '[0][1]' .equal \class-name-must-be-pascal-case
	it \upper-snake-case
		lint 'class HOGE_HUGA' {+allow-class} .should.have.deep.property '[0][1]' .equal \class-name-must-be-pascal-case
