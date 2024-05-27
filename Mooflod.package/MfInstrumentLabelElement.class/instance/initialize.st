initialization
initialize

	super initialize.
	self text: ('Instrument :' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color black) }).
	self text fontSize: 18.
	self transformDo: [ :t | t translateBy: 20 @ 25 ]