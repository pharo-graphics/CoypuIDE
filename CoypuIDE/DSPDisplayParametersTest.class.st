Class {
	#name : 'DSPDisplayParametersTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
DSPDisplayParametersTest >> testDisplayParametersFailsWhenNotInitialized [
	self should: [ SineOsc new asDsp displayParameters ] raise: Error
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testDisplayParametersListsAllParameters [
	| dsp window |
	dsp := SineOsc new asDsp.
	dsp init.
	window := dsp displayParameters.
	[ self assert: window presenter items asArray equals: dsp allParameters asArray ]
		ensure: [ window close ]
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testParametersElementListsAllParameters [
	| dsp |
	dsp := SineOsc new asDsp.
	dsp init.
	self assert: dsp parametersElement dataAccessor size equals: dsp allParameters size
]
