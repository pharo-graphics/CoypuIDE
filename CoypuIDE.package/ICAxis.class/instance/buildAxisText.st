as yet unclassified
buildAxisText

	| w h xText yText |
	w := self widgetSize x.
	h := self widgetSize y.

	self removeChildWithId: 'xLabel'.
	self removeChildWithId: 'yLabel'.

	xText := BlTextElement new
		         text: self xLabel asRopedText;
		         position: 0 @ (h + 5).
	yText := BlTextElement new
		         text: self yLabel asRopedText;
		         position: -50 @ (h - 10).

	self addChild: xText as: 'xLabel'.
	self addChild: yText as: 'yLabel'