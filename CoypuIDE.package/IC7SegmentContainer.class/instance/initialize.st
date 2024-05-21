initialization
initialize

	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	value := 0.
	self nbDigits: 5