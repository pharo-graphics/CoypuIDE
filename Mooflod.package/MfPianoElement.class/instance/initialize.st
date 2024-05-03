initialization
initialize
	"initialize the state of the receiver"

	super initialize.
	""

	whiteKeyColor := Color gray: 0.95.
	blackKeyColor := Color black.
	nOctaves := 2.
	self buildKeyboard