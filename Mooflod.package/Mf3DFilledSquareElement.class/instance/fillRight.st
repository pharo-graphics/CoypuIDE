as yet unclassified
fillRight

	| fr |
	fr := MfFillingLineElement new.
	fr size: 50 @ 80.
	fr background: Color pink.
	fr transformDo: [ :d | d rotateBy: 50 ].
	self addChild: fr