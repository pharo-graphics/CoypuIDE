initialization
initializeNotes

	| wN wx bN bx wArray bxArray |
	"initializing notes for the two octaves"
	wArray := #( 'C' 'D' 'E' 'F' 'G' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'A' 'B' ).
	wx := 0.
	bx := 0.
	"adding the white notes"
	1 to: 14 do: [ :i |
		wN := MfPianoWhiteNoteElement new.
		wN background: whiteKeyColor.
		wN note: (wArray at: i).
		self addChild: wN.
		wN transformDo: [ :e |
			e translateBy: wx @ 0.
			wx := wx + 36 ] ].
	"changing the disposition of black notes depending on start note"
	1 to: 7 do: [ :e |
		startNote = (wArray at: e) ifTrue: [ bxArray := noteArray at: e ] ].
"now add the black notes to the widget"
	1 to: bxArray size do: [ :i |
		bN := MfPianoBlackNoteElement new.
		bN background: blackKeyColor.
		self addChild: bN.
		bN transformDo: [ :e |
			bx := bx + (bxArray at: i).
			e translateBy: bx @ 0 ] ].
	notes := 14 + bxArray size.
	^ bxArray