initialization
initialize

	super initialize.
	self geometry: self defaultGeometry.
	self size: self inputExtent.
	self layout: self defaultLayout.
	self initializePlus.
	self initializeMinus.
	self initializeInputText