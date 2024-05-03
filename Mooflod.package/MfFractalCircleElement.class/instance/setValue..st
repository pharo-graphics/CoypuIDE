as yet unclassified
setValue: aValue

	(aValue between: 0 and: 100) ifTrue: [ self value: aValue ]
	ifFalse: [ self value: 100 ].
	nbOfChilds := value / 4.
	self updateCircles