initialization
initializeTimerValue

	decreasingAngleStep := 360 / value.
	currentAngle := 360.
	self replaceTimerTextValue: value.
	self initializeAnnulus