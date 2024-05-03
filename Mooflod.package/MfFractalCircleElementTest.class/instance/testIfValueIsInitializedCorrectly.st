tests
testIfValueIsInitializedCorrectly

	| circle |
	circle := MfFractalCircleElement new.
	circle setValue: 12.
	self assert: circle value equals: 12