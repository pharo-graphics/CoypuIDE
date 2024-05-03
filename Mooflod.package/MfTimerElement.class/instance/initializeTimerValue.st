initialization
initializeTimerValue

	timerValue := BlTextElement new.
	timerValue text: value asString asRopedText.
	angle := 360 / value.
	currentAngle:= 360.
	timerValue text fontSize: 100.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color lightOrange) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	self addChild: timerValue