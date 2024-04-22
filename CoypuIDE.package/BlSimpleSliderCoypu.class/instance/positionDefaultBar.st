as yet unclassified
positionDefaultBar

	self isHorizontal
		ifTrue: [ bar position: self defaultMarginLength @ self defaultMarginThickness ]
		ifFalse: [
			bar position:
				self defaultMarginThickness @ self defaultMarginLength  ]