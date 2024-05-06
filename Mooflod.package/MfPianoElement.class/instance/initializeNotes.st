initialization
initializeNotes

	| wN wx bN bx wArray bxArray |
	wArray := #( C D E F G A B C D E F G A B ).
	bxArray := #( 26.5 36 67 40 39 68.5 36 68 41 40 ).
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
	1 to: 10 do: [ :i |
		bN := MfPianoBlackNoteElement new.
		bN background: blackKeyColor.
		self addChild: bN.
		bN transformDo: [ :e |
			bx := bx + (bxArray at: i).
			e translateBy: bx @ 0 ] ]