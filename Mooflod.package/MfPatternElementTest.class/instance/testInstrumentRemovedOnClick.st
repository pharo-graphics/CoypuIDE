tests
testInstrumentRemovedOnClick

	| patternElem |
	"Create the pattern element"
	patternElem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	patternElem childrenDo: [ :e |
		BlSpace simulateClickOn: e "proved by previous test, all drums attributes equals true" ].
	"Clicking a second time on all bars"
	patternElem childrenDo: [ :e |
		BlSpace simulateClickOn: e.
		self assert: e instrument equals: false "Now all bars have no drums, same as creation state" ]