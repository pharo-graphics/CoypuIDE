initialization
initialize

	super initialize.
	self size: self squareExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self layout: BlFrameLayout new.
	self initFill.
	value := 0