as yet unclassified
positionDefaultHandle

	self isHorizontal
		ifTrue: [ handle position: self defaultMargin @ (widgetSize y / 2) ]
		ifFalse: [ handle position: widgetSize x / 2 @ (self defaultMargin + barLength) ]