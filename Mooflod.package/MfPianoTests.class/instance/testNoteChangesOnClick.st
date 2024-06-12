tests
testNoteChangesOnClick

	| p |
	p := MfPianoElement new
		     nOctaves: 2;
		     startNote: 'E'.
	self assert: p whitenotes first background paint color equals: p whiteKeyColor.
	p whitenotes do: [ :n |
		BlSpace simulateMouseDownOn: n.
		self assert: n background paint color equals: Color lightGray ]