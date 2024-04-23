as yet unclassified
defaultColoredBar

	| size |
	size := self
		        ifHorizontal: [ 0 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 0 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  background: self coloredBarDefaultColor;
		  size: size;
		  yourself