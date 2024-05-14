tests
testNoteChangesOnClick

	| p |
	p := MfPianoElement new
		     nOctaves: 2;
		     startNote: 'E'.
	p whitenotes do: [ :n |
		BlSpace simulateMouseDownOn: n.
		self assert: n background paint color equals: Color lightGray ]