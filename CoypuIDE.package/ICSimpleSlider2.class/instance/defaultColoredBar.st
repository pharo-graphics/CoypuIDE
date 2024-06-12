as yet unclassified
defaultColoredBar

	| size |
	size := self
		        ifHorizontal: [ 1 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  background: self coloredBarDefaultColor;
			size: size;
		  yourself