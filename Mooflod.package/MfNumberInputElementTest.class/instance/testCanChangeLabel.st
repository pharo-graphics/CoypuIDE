tests
testCanChangeLabel

	| inputElem |
	inputElem := MfNumberInputElement new.
	self assert: inputElem label text asString equals: 'Input'.
	inputElem label: 'Volume'.
	self assert: inputElem label text asString equals: 'Volume'