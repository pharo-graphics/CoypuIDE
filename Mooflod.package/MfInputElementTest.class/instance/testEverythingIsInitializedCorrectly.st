tests
testEverythingIsInitializedCorrectly

| inputElem |
"create instance of input"
inputElem:= MfInputElement new default: 20.
"Must have 4 childs : Value, both buttons and the input text"
self assert: inputElem children size equals: 4. 
self assert:  inputElem value equals: 20. "As default value defined in the code"
