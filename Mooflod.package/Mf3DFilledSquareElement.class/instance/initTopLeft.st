initialization - private
initTopLeft

	| tll |
	tll := ToElement new.
	tll geometry: (BlLineGeometry new from: 102 @ 1 to: 151 @ -48).
	tll outskirts: BlOutskirts centered.
	tll border: (BlBorder paint: Color darkGray width: 3).
	^ tll