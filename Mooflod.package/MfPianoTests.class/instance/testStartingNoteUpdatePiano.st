tests
testStartingNoteUpdatePiano

	| p |
	p := MfPianoElement new startNote: 'F'.
	"start note is F so there's the position of each black note for the start note F"
	self
		assert: p initializeNotes
		equals: #( 24 39 39 68 36 70 39 39 68 36 )