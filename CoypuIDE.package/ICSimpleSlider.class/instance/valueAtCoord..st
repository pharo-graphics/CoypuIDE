api - transformations
valueAtCoord: aPoint

	^ self isHorizontal
		  ifTrue: [ self valueAtX: aPoint  ]
		  ifFalse: [ self valueAtY: aPoint  ]