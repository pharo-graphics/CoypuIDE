as yet unclassified
initSections

	| y |
	y := 0.
	1 to: 4 do: [ :s |
		| sect |
		sect := MfVisualizerSectionElement new.
		sect transformDo: [ :t |
			t translateBy: 0@y ].
		y:= y+200.
		self addChild: sect ]