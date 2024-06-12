tests
testSkinisInstalledCorrectly

	| patElem |
	self skip. 
	"create instance of input"
	patElem := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 8.
	"input skin is nil"
	self assert: patElem background paint equals: nil.
	patElem openPattern.
	"Now the input widget has background defined"
	self assert: patElem background paint color equals: Color red