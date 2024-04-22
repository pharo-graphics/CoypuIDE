protocol
updateValue

	currentValue := self valueAtCoord: handle position.
	"self announcer announce: BlSliderValueChangedEvent"
	self dispatchEvent: BlSliderValueChangedEvent new.