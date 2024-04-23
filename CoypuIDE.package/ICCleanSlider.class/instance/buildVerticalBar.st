private - building
buildVerticalBar

	| bar |
	bar := BlElement new.
	bar size: barThickness
		@ (self widgetSize y - (self valueToCoord: currentValue)
			 - self sliderPixelMargin).
	bar id: #sliderBar.
	bar position: self widgetSize x / 2 - (barThickness / 2)
		@ (self valueToCoord: currentValue).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar.

	