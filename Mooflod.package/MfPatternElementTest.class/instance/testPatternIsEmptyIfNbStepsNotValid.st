tests
testPatternIsEmptyIfNbStepsNotValid

	| patternE1 patternE2 |
	"Create two pattern elements with differents min/max bars allowed"
	patternE1 := MfPatternElement new
		             min: 4;
		             max: 12;
		             nbsteps: 13.
	self assert: patternE1 nbOfSteps equals: 0. "Bars not added to element, over the max"
	patternE2 := MfPatternElement new
		             min: 8;
		             max: 16;
		             nbsteps: 4.
	self assert: patternE2 nbOfSteps equals: 0 "Bars not added to element, under the min"