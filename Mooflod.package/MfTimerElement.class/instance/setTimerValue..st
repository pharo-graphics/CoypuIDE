initialization
setTimerValue: aValue

	timerValue := MfInputValueElement new.
	timerValue text: aValue asString asRopedText.
	timerValue text fontSize: 100.
	timerValue text attributes:
		{ (BlTextForegroundAttribute paint: Color lightOrange ) }.
	timerValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	self addChild: timerValue