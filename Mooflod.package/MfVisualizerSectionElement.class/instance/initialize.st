initialization
initialize

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 500 @ 200.
	self border: (BlBorder paint: Color white width: 2).
	self layout: BlFrameLayout new