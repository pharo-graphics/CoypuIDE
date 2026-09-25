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
DSPDisplayParametersTest >> testDisplayParametersOpensSpace [
	| dsp space |
	dsp := SineOsc new asDsp.
	dsp init.
	space := dsp displayParameters.
	[
	self assert: space title equals: 'DSP Parameters'.
	self assert: (space root children anySatisfy: [ :each | each isKindOf: ToListElement ]) ]
		ensure: [ space close ]
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testParametersElementListsAllParameters [
	| dsp |
	dsp := SineOsc new asDsp.
	dsp init.
	self assert: dsp parametersElement dataAccessor size equals: dsp allParameters size
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testParametersSpaceContainsList [
	| dsp space |
	dsp := SineOsc new asDsp.
	dsp init.
	space := dsp parametersSpace.
	self assert: space title equals: 'DSP Parameters'.
	self assert: (space root children anySatisfy: [ :each | each isKindOf: ToListElement ])
]
