initialization
initializeNotes

	| wN wx bN bx wArray bxArray |
	wArray := #( 'C' 'D' 'E' 'F' 'G' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'A' 'B' ).
	wx := 0.
	bx := 0.
	1 to: 14 do: [ :i |
		wN := MfPianoWhiteNoteElement new.
		wN background: whiteKeyColor.
		wN note: (wArray at: i).
		self addChild: wN.
		wN transformDo: [ :e |
			e translateBy: wx @ 0.
			wx := wx + 36 ] ].

	1 to: 7 do: [ :e |
		startNote = (wArray at: e) ifTrue: [ bxArray := noteArray at: e ] ].

	1 to: bxArray size do: [ :i |
		bN := MfPianoBlackNoteElement new.
		bN background: blackKeyColor.
		self addChild: bN.
		bN transformDo: [ :e |
			bx := bx + (bxArray at: i).
			e translateBy: bx @ 0 ] ].
	notes:= 14 + bxArray size.
	^ bxArray