Class {
	#name : 'DSPDisplayParametersTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'as yet unclassified' }
DSPDisplayParametersTest >> labelsOf: anElement [
	^ anElement children flatCollect: [ :column | column children collect: [ :each | each text asString ] ]
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testDisplayParametersFailsWhenNotInitialized [
	self should: [ SineOsc new asDsp displayParameters ] raise: Error
]

{ #category : 'as yet unclassified' }
DSPDisplayParametersTest >> testParametersElementHasFourColumns [
	| dsp |
	dsp := SineOsc new asDsp.
	dsp init.
	self assert: dsp parametersElement childrenCount equals: (4 min: dsp allParameters size)
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testParametersElementIsSorted [
	| dsp labels |
	dsp := SineOsc new asDsp.
	dsp init.
	labels := (self labelsOf: dsp parametersElement) asArray.
	self assert: labels equals: (labels sorted: [ :a :b | a asLowercase < b asLowercase ])
]

{ #category : 'as yet unclassified' }
DSPDisplayParametersTest >> testParametersElementIsSortedCaseInsensitive [
	| dsp labels |
	dsp := SineOsc new asDsp.
	dsp init.
	labels := (self labelsOf: dsp parametersElement) asArray.
	self assert: labels equals: (labels sorted: [ :a :b | a asLowercase < b asLowercase ])
]

{ #category : 'as yet unclassified' }
DSPDisplayParametersTest >> testParametersElementListsAllParameters [
	| dsp |
	dsp := SineOsc new asDsp.
	dsp init.
	self assert: (self labelsOf: dsp parametersElement) size equals: dsp allParameters size
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testParametersSpaceContainsList [

	| dsp space |
	dsp := SineOsc new asDsp.
	dsp init.
	space := dsp parametersSpace.
	self assert: space title equals: 'DSP Parameters'.
	self assert: space root childrenCount equals: 1
]

{ #category : 'tests' }
DSPDisplayParametersTest >> testParametersSpaceContainsParameters [
	| dsp space |
	dsp := SineOsc new asDsp.
	dsp init.
	space := dsp parametersSpace.
	self assert: space title equals: 'DSP Parameters'.
	self assert: space root childrenCount equals: 1
]
