initialization - private
initBottomLeft
|bll|

	bll := ToElement new.
	bll geometry: (BlLineGeometry new from: 52 @ 195 to: 103 @ 148).
	bll outskirts: BlOutskirts centered.
	bll border: (BlBorder paint: Color darkGray width: 3).
	^ bll