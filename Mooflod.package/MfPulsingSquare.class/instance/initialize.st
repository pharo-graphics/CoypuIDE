initialization
initialize

	super initialize.
	self geometry: BlSquareGeometry new.
	self background: Color white.
	self size: 50 @ 50.
	self border: (BlBorder paint: Color black).
	self initAnimation 