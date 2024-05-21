initialization
initialize

	super initialize.
		self geometry: BlRectangleGeometry new.
	self size: 500 @ 200.
	self border: (BlBorder paint: Color black width: 2)