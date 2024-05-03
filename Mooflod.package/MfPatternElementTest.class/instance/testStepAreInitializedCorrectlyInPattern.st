test-init
testStepAreInitializedCorrectlyInPattern

	| patternElem |
	"create a pattern to assign to the element""Create the pattern element and give him the number of bars we want in "
	patternElem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 16.
	"At creation all bars have no drum assigned"
	patternElem childrenDo: [ :e | self deny: e instrument ].
	"Test if all 16 bars are added to the pattern element"
	self assert: patternElem nbOfSteps equals: 16