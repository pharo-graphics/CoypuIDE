initialization
initializeInputValue
	"setting the default value to 20 and setting its attributes"

	inputValue := MfInputValueElement new.
	inputValue text: default asString asRopedText.
	inputValue text attributes:
		{ (BlTextForegroundAttribute paint: Color white) }.
	inputValue text fontSize: 30.
	self addChild: inputValue.
	value := default.