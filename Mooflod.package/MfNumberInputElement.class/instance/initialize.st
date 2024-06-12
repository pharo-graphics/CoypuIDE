initialization
initialize

	super initialize.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	self padding: (BlInsets all: 30).
	self layout: BlLinearLayout horizontal.
	self border: (BlBorder paint: Color pink).
	self validateValueBlock: [ :v | v between: 1 and: 25 ].
	self label: 'Input'.
	self initializeMinusButton.
	self initializeInputValue: 20.
	self initializePlusButton