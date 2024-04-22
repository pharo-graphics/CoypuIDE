api - bounds
defaultSize
	"self bar size maybe"
	^ (self isHorizontal
		   ifTrue: [ self defaultBarLength @ self defaultBarThickness ]
		   ifFalse: [ self defaultBarThickness @ self defaultBarLength ])
	  + (2 * self defaultMargin)