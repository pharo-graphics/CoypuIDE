tests
testTwoPianoCanHaveDifferentOctaves

	| p1 p2 |
	p1 := MfPianoElement new
		     nOctaves: 3;
		     startNote: 'E'.
	self assert: p1 nOctaves equals: 3.
	p2 := MfPianoElement new.
	self assert: p2 nOctaves equals: 2.
	self assert: p1 nOctaves ~= p2 nOctaves.