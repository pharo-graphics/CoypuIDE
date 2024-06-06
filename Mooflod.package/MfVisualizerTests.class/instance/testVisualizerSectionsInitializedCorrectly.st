tests
testVisualizerSectionsInitializedCorrectly


	| v  |
	v := MfVisualizerElement new level: 2.
	self assert: v children size equals: 4.
	