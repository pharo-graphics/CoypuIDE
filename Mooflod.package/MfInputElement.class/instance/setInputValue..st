initialization
setInputValue: aValue
	"update the value by creating a new one having the value aValue passed as parameter"

	inputValue text: aValue asString asRopedText.
	inputValue text attributes:
		{ (BlTextForegroundAttribute paint: Color white) }.
	inputValue text fontSize: 30.
	value := aValue.

	^ inputValue