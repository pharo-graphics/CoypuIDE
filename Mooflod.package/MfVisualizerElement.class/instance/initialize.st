initialization
initialize

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 500 @ 800.
	self border: (BlBorder paint: Color lightGray width: 2).
self initSections.
	nbTracks := 0