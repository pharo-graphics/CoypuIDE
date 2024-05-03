initialization
initialize

	super initialize.
	self geometry: self defaultGeometry.
	self size: self squareExtent.
	self border: (BlBorder paint: Color darkGray width: 3).
	self effect:
		(BlSimpleShadowEffect color: Color darkGray offset: 50 @ -50).
	self layout: BlFrameLayout new.
	self initFill.
	value := 0