public api
setValue: aValue

	(aValue between: 0 and: 100)
		ifTrue: [ value := aValue ]
		ifFalse: [  value := 100 ].
	nbOfChilds := value / 4.
	self updateCircles