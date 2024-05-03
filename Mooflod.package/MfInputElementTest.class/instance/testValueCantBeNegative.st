tests
testValueCantBeNegative

	| inputElem |
	inputElem := MfInputElement new default: 0.
	"we simulate a click on minus button"
	BlSpace simulateClickOn: inputElem minus.
	"the minimum value is 0, so didn't change"
	self assert: inputElem value equals: 0