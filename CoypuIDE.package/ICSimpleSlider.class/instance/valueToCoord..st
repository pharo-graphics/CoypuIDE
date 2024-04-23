api - transformations
valueToCoord: aNumber

	^ self isHorizontal
		  ifTrue: [ self valueToX: aNumber ]
		  ifFalse: [ self valueToY: aNumber ]