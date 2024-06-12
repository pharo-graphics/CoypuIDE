tests
testNotesInitializedCorrectly

	| p |
	p := MfPianoElement new startNote: 'C'.
	self assert: p whitenotes size + p blacknotes size  equals: 24