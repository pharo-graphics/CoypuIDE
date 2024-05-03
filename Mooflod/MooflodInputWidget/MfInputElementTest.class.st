Class {
	#name : #MfInputElementTest,
	#superclass : #TestCase,
	#category : #MooflodInputWidget
}

{ #category : #tests }
MfInputElementTest >> testEverythingIsInitializedCorrectly [

| inputElem |
"create instance of input"
inputElem:= MfInputElement new default: 20.
"Must have 4 childs : Value, both buttons and the input text"
self assert: inputElem children size equals: 4. 
self assert:  inputElem value equals: 20. "As default value defined in the code"

]

{ #category : #tests }
MfInputElementTest >> testSkinisInstalledCorrectly [

| inputElem |
"create instance of input"
inputElem:= MfInputElement new default: 12.
"input skin is nil"
self assert: inputElem background paint equals: nil .
inputElem openInput: inputElem. "Assign skin to input"
"Now the input widget has background defined"
self assert: inputElem background paint color equals: Color black .



]

{ #category : #tests }
MfInputElementTest >> testValueCantBeNegative [

	| inputElem |
	inputElem := MfInputElement new default: 0.
	"we simulate a click on minus button"
	BlSpace simulateClickOn: inputElem minus.
	"the minimum value is 0, so didn't change"
	self assert: inputElem value equals: 0
]

{ #category : #tests }
MfInputElementTest >> testValueUpdatedOnClick [

	| inputElem | 
	inputElem := MfInputElement new default: 20.
	"we simulate click on minus button, default value is 20"
	BlSpace simulateClickOn: inputElem minus.
	"resulting value is 20-1"
	self assert: inputElem value equals: 19.
	"we click 6 times on plus button, so value = previous value + 6"
	1 to: 6 do: [ :i | BlSpace simulateClickOn: inputElem plus ].
	self assert: inputElem value equals: 25
]
