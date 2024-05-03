initialization
initialize

	super initialize.
	self size: self circleExtent.
	self geometry: self defaultGeometry.
	self border: (BlBorder paint: Color black width: 3).
	self layout: BlFrameLayout new.
	value := 0