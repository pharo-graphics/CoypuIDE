tests
testSkinisInstalledCorrectly

	| patElem |
	"create instance of input"
	patElem := MfPatternElement new
		           min: 4;
		           max: 16;
		           nbsteps: 8.
	"input skin is nil"
	self assert: patElem background paint equals: nil.
	patElem openPattern: patElem. "Assign skin to input"
	"Now the input widget has background defined"
	self assert: patElem background paint color equals: Color red