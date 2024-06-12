Class {
	#name : 'MfVisualizerTests',
	#superclass : 'TestCase',
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'tests' }
MfVisualizerTests >> testLevelOneWorksCorrectly [

	| v name firstSect |
	v := MfVisualizerElement new level: 1.
	name := 'Snare'.
	v addInstrument: name.
	v initAnimation: 128.
	firstSect := v children at: 1.
	self assert: firstSect children size equals: 3
]

{ #category : 'tests' }
MfVisualizerTests >> testLevelTwoWorksCorrectly [

	| v name firstSect |
	v := MfVisualizerElement new level: 2.
	name := 'Snare'.
	v addInstrument: name.
	v initAnimation: 128.
	firstSect := v children at: 1.
	self assert: firstSect children size equals: 4
]

{ #category : 'tests' }
MfVisualizerTests >> testVisualizerSectionsInitializedCorrectly [


	| v  |
	v := MfVisualizerElement new level: 2.
	self assert: v children size equals: 4.
	
]
