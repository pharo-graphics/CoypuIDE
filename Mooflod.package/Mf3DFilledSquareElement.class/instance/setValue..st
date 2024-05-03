initialization
setValue: aValue

	(aValue between: 0 and: 100) ifTrue: [ self value: aValue ].
	self updateSquare