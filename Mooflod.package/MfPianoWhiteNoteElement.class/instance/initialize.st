initialization
initialize

	super initialize.
	self size: 36 @ 130.
	self geometry: BlRectangleGeometry new.
	self border: (BlBorder paint: Color black width: 1).
