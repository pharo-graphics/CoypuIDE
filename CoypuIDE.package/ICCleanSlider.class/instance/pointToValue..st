api - transformations
pointToValue: point

	^ self isHorizontal 
		  ifTrue: [ self pointToXValue: point ]
		  ifFalse: [ self pointToYValue: point ]