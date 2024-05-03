tests
testValueUpdatedOnClick

	| inputElem | 
	inputElem := MfInputElement new default: 20.
	"we simulate click on minus button, default value is 20"
	BlSpace simulateClickOn: inputElem minus.
	"resulting value is 20-1"
	self assert: inputElem value equals: 19.
	"we click 6 times on plus button, so value = previous value + 6"
	1 to: 6 do: [ :i | BlSpace simulateClickOn: inputElem plus ].
	self assert: inputElem value equals: 25