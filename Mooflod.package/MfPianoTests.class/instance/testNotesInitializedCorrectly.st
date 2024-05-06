tests
testNotesInitializedCorrectly

	| p |
	p := MfPianoElement new startNote: 'C'.
	self assert: p notes equals: 24