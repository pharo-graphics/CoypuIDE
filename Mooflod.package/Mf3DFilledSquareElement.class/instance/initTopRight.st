initialization - private
initTopRight

	| tlr |
	tlr := ToElement new.
	tlr geometry: (BlLineGeometry new from: -1 @ 2 to: 49 @ -48).
	tlr outskirts: BlOutskirts centered.
	tlr border: (BlBorder paint: Color darkGray width: 3).
	^ tlr