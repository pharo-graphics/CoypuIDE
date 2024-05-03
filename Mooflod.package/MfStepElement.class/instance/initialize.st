initialization
initialize

	super initialize.
	instrument := false.
	self size: self stepExtent.
	self background: self backgroundPaint.
	self constraintsDo: [ :e | e frame vertical alignCenter ].