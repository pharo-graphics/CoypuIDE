"
Tests for ICPerformanceDisplay.
"
Class {
	#name : 'ICPerformanceDisplayTest',
	#superclass : 'TestCase',
	#instVars : [
		'performance',
		'display'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'running' }
ICPerformanceDisplayTest >> setUp [
	"a plain Dictionary stands in for the Performance singleton"

	super setUp.
	performance := Dictionary new.
	performance at: #snare put: 16 upbeats.
	performance at: #kick put: 16 downbeats.
	performance at: #notASequencer put: 42.
	display := ICPerformanceDisplay on: performance
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testAddsALaneForANewKey [
	"#hats sorts before #kick, so it becomes the first lane"

	performance at: #hats put: 16 rumba.
	display checkForChanges.
	self assert: display lanes children size equals: 3.
	self assert: display lanes children first sequencer identicalTo: (performance at: #hats)
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testDropsTheLaneOfARemovedKey [

	performance removeKey: #kick.
	display checkForChanges.
	self assert: display lanes children size equals: 1
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testKeepsUnchangedLanes [

	| snareLane |
	snareLane := display lanes children last.
	performance at: #hats put: 16 rumba.
	display checkForChanges.
	self assert: display lanes children last identicalTo: snareLane
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testLanesTakeTheDiceTherapyHues [

	self assert: (display lanes children collect: [ :each | each triggeredColor ]) asArray equals: (display laneColors first: 2)
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testOneLanePerSequencerSortedByKey [

	self assert: (display lanes children collect: [ :each | each sequencer ]) asArray equals: {
			(performance at: #kick).
			(performance at: #snare) }
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testRebuildShowsNewSequencers [

	performance at: #hats put: 16 rumba.
	display rebuild.
	self assert: display lanes children size equals: 3
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testReplacesTheLaneOfAReplacedSequencer [

	| kickLane |
	kickLane := display lanes children first.
	performance at: #kick put: 16 rumba.
	display checkForChanges.
	self deny: display lanes children first identicalTo: kickLane.
	self assert: display lanes children first sequencer identicalTo: (performance at: #kick)
]

{ #category : 'tests' }
ICPerformanceDisplayTest >> testScrollsVertically [

	self assert: (display children anySatisfy: [ :each | each isKindOf: BlVerticalScrollbarElement ]).
	self deny: (display children anySatisfy: [ :each | each isKindOf: BlHorizontalScrollbarElement ])
]
