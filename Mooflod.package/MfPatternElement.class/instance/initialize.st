initialization
initialize

	super initialize.
	self size: self patternExtent.
	self geometry: BlRectangleGeometry new.
	self layout: BlFrameLayout new.