initialization
initializeDigitElements

	| elts |
	elts := OrderedCollection new.
	self digitElements ifNotNil: [ :e | self removeChildren: e].
	1 to: nbDigits do: [ :i |
		| elt |
		elt := IC7Segment new.
		elts add: elt.
		self addChild: elt ].
	self digitElements: elts.
	self updateDisplayedValue