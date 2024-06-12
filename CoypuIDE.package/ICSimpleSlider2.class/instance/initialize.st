initialization
initialize

	super initialize.
	isHorizontal := true.
	segmented := false.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self initializeValues.
	self initializeParts.
	self initializeEvents