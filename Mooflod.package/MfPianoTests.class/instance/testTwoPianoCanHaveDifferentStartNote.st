tests
testTwoPianoCanHaveDifferentStartNote

	| p1 p2 |
	p1 := MfPianoElement new
		      nOctaves: 3;
		      startNote: 'E'.
	self assert: p1 startNote equals: 'E'.
	p2 := MfPianoElement new.
	self assert: p2 startNote equals: 'C'.