tests
testIfInstrumentAssignedOnClick

	| patternElem |
	" Create the pattern element"
	patternElem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	"Simulate a click on all bars in the pattern"
	patternElem childrenDo: [ :e |
		BlSpace simulateClickOn: e.
		self assert: e instrument equals: true "Now all bars have a drum assigned" ]