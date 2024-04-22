protocol
updateValueAt: aPosition

	currentValue := self valueAtCoord: aPosition.
	"self announcer announce: BlSliderValueChangedEvent"
	self dispatchEvent: BlSliderValueChangedEvent new.