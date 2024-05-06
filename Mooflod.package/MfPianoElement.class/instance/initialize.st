initialization
initialize
	"initialize the state of the receiver"

	super initialize.
	""
	self border: (BlBorder paint: Color black width: 2).
	self geometry: BlRectangleGeometry new.
	self size: self pianoExtent.
	whiteKeyColor := Color gray: 0.95.
	blackKeyColor := Color black.