tests
testEverythingIsInitializedCorrectly

	| inputElem |
	inputElem := MfNumberInputElement new.
	self assert: inputElem children size equals: 4