initialization - private
initBottomRight

	| brl |
	brl := ToElement new.
	brl geometry: (BlLineGeometry new from: 349 @ 198 to: 399 @ 148).
	brl outskirts: BlOutskirts centered.
	brl border: (BlBorder paint: Color darkGray width: 3).
	^ brl