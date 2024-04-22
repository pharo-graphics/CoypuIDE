api - bounds
defaultBar

	| size |
	size := self isHorizontal
		        ifTrue: [ self defaultBarLength @ self defaultBarThickness ]
		        ifFalse: [ self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  background: self barDefaultColor;
		  size: size;
		  yourself