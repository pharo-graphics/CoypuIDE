initialization
initialize

	super initialize.
	self background: Color veryLightGray.
	self clipChildren: false.
	self initializeDefaultSize.
	self initializeDefaultValues.
	self buildAxis.

	self
		addEventHandlerOn: BlClickEvent
		do: [ :e | self clickAt: e position - self position ]