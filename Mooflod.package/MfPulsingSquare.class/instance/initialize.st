initialization
initialize

	super initialize.
	self geometry: BlSquareGeometry new.
	self background: Color white.
	self size: 40 @ 40.
	self border: (BlBorder paint: Color black).
	self initializeAnimation.
