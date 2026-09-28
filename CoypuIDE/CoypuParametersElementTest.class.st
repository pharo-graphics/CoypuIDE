Class {
	#name : 'CoypuParametersElementTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'accessing' }
CoypuParametersElementTest >> element [
	^ CoypuParametersElement on: #( 'kickTrigger' 'acidFreq' 'Reverb' 'kickFreq' 'LFOSquarePosAmount' )
]

{ #category : 'tests' }
CoypuParametersElementTest >> testColorByParamType [
	| element |
	element := self element.
	self assert: (element colorFor: 'kickTrigger') equals: Color red darker.
	self assert: (element colorFor: 'acidFreq') equals: Color blue.
	self assert: (element colorFor: 'Reverb') equals: Color darkGray
]

{ #category : 'tests' }
CoypuParametersElementTest >> testFilterKeepsMatches [
	| element |
	element := self element.
	element filter: 'KICK'.
	self assert: element displayedNames asArray equals: #( 'kickFreq' 'kickTrigger' )
]

{ #category : 'tests' }
CoypuParametersElementTest >> testLabelsAreNotThemed [
	self assert: (self element labelFor: 'kickTrigger') class equals: BlTextElement
]

{ #category : 'tests' }
CoypuParametersElementTest >> testParametersElementListsAllParameters [
	| dsp |
	dsp := SineOsc new asDsp.
	dsp init.
	self assert: dsp parametersElement displayedNames size equals: dsp allParameters size
]

{ #category : 'tests' }
CoypuParametersElementTest >> testShowsAllWhenFilterIsEmpty [
	self assert: self element displayedNames size equals: 5
]

{ #category : 'tests' }
CoypuParametersElementTest >> testSortedCaseInsensitive [
	self
		assert: self element displayedNames asArray
		equals: #( 'acidFreq' 'kickFreq' 'kickTrigger' 'LFOSquarePosAmount' 'Reverb' )
]
