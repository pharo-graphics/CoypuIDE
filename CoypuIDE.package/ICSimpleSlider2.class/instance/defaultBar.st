api - bounds
defaultBar

	| size |
	size := self 
		        ifHorizontal: [ self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self barDefaultColor;
		  size: size;
		  yourself