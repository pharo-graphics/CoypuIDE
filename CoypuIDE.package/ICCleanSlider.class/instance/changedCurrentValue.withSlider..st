changing state
changedCurrentValue: aValue withSlider: aBool

	| v color |
	v := self valueToCoord: aValue.
	self isHorizontal
		ifTrue: [
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: v @ sl constraints position y ] ].
			self sliderBar size:
				v - self sliderPixelMargin @ self sliderBar size y ]
		ifFalse: [
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: sl constraints position x @ v ] ].
			self sliderBar size:
				barThickness
				@ (self widgetSize y - (self valueToCoord: currentValue)
					 - self sliderPixelMargin).
			self sliderBar position:
				self widgetSize x / 2 - (barThickness / 2)
				@ (self valueToCoord: currentValue) ].
	color := self colorForValue: aValue.
	self sliderHandle background: color.
	self sliderBar background: color