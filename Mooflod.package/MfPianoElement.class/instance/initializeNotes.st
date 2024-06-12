initialization
initializeNotes

	| wN wx bN bx whiteNoteDescriptions blackNoteXArray array |
	"initializing notes for the two octaves"
	array := #( 'C' 'D' 'E' 'F' 'G' 'A' 'B' ).
	whitenotes := OrderedCollection new.
	blacknotes := OrderedCollection new.
	"for now the note description is not used and only for the white notes"
	whiteNoteDescriptions := OrderedCollection new.
	nOctaves timesRepeat: [
		array do: [ :e | whiteNoteDescriptions add: e ] ].
	wx := 0.
	bx := 0.
	"adding the white notes"
	1 to: nOctaves * 7 do: [ :i |
		wN := MfPianoWhiteNoteElement newWithColor: whiteKeyColor.
		wN note: (whiteNoteDescriptions at: i).
		self addChild: wN.
		wN transformDo: [ :e |
			e translateBy: wx @ 0.
			wx := wx + 36 ].
		whitenotes add: wN ].
	self initializeWhiteHandlers.

	"changing the disposition of black notes depending on start note"
	1 to: 7 do: [ :e |
		startNote = (whiteNoteDescriptions at: e) ifTrue: [
			blackNoteXArray := xPositionOfBlackNotes at: e ] ].
	"now add the black notes to the widget"
	1 to: blackNoteXArray size do: [ :i |
		bN := MfPianoBlackNoteElement newWithColor: blackKeyColor.
		blacknotes add: bN.
		self addChild: bN.
		bN transformDo: [ :e |
			bx := bx + (blackNoteXArray at: i).
			e translateBy: bx @ 0 ] ].
	self initializeBlackHandlers.

	^ blackNoteXArray