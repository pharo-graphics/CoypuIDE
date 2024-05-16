initialization
initialize

	super initialize.
	self background: Color veryDarkGray.
	self size: 60 @ 100.
	self clipChildren: false.
	self initializeSegments