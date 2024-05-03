Class {
	#name : #MfTimerElementTest,
	#superclass : #TestCase,
	#category : #MooflodTimerWidget
}

{ #category : #tests }
MfTimerElementTest >> testDefaultValueIsCorrectlyInitialized [

	| timer |
	
	timer := MfTimerElement new value: 20.
	self assert: timer value equals: 20
]

{ #category : #tests }
MfTimerElementTest >> testIfTimeAnimationWorks [

	| timer |
	timer := MfTimerElement new value: 20.
]
