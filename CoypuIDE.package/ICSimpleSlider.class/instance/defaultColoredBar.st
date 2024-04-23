as yet unclassified
defaultColoredBar

	| size |
	size := self isHorizontal
		        ifTrue: [ 0 @ self defaultBarThickness ]
		        ifFalse: [ self defaultBarThickness @ 0 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  background: self coloredBarDefaultColor;
		  size: size;
		  yourself