as yet unclassified
positionDefaultBar: aBar

	self isHorizontal
		ifTrue: [ aBar position: self defaultMarginLength @ self defaultMarginThickness ]
		ifFalse: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength  ]