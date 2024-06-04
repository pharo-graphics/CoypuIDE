initialization
initialize

	super initialize.
	self background: Color veryDarkGray.
	self size: 60 @ 100.
	self clipChildren: false.
	self padding: (BlInsets all: 5).
	self layout: BlProportionalLayout new.
	self initializeSegments