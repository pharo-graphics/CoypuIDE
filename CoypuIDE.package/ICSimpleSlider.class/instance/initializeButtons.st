initialization
initializeButtons
	"Here I manually place the buttons but we could use layouts instead of magic numbers"

	"These might be useless after all because clicking outside the slider already sets to min or max"
	| buttonSize minButton maxButton |
	buttonSize := 30.
	minButton := BlElement new
		             geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		             background: Color gray;
		             size: buttonSize asPoint.

	maxButton := BlElement new
		             geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		             background: Color gray;
		             size: buttonSize asPoint.

	minButton addEventHandlerOn: BlClickEvent do: [ self setToMin ].
	maxButton addEventHandlerOn: BlClickEvent do: [ self setToMax ].

	self
		ifHorizontal: [
			minButton position: marginLength / 2 - (buttonSize / 2)
				@ (self defaultSize y / 2 - (buttonSize / 2)).
			maxButton position:
				self defaultSize x - (buttonSize + marginLength / 2)
				@ (self defaultSize y / 2 - (buttonSize / 2)) ]
		ifVertical: [
			minButton position: self defaultSize x / 2 - (buttonSize / 2)
				@ (self defaultSize y - (buttonSize + marginLength / 2)).
			maxButton position: self defaultSize x / 2 - (buttonSize / 2)
				@ (marginLength / 2 - (buttonSize / 2)) ].


	self addChild: minButton.
	self addChild: maxButton