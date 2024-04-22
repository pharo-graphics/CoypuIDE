initialization
initialize

	super initialize.
	isHorizontal := true.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self initializeValues.
	self initializeParts.
	self addEventHandlerOn: BlClickEvent do: [ :event | self moveHandleTo: event position] 