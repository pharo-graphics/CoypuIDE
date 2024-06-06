tests
testLevelTwoWorksCorrectly

	| v name firstSect |
	v := MfVisualizerElement new level: 2.
	name := 'Snare'.
	v addInstrument: name.
	v initAnimation: 128.
	firstSect := v children at: 1.
	self assert: firstSect children size equals: 4