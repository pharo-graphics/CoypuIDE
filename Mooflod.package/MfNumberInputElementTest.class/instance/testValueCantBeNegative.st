tests
testValueCantBeNegative

	| inputElem value |
	inputElem := MfNumberInputElement new.
	inputElem changeValueTo: 0.
	BlSpace simulateClickOn: inputElem minus.
	value := inputElem value.
	self assert: value equals: 0