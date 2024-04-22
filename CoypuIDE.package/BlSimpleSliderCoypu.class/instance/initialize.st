initialization
initialize

	super initialize.
	isHorizontal := true.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self initializeValues.
	self initializeParts