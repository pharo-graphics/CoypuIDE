"
Tests for ICSequencerDisplay.
"
Class {
	#name : 'ICSequencerDisplayTest',
	#superclass : 'TestCase',
	#instVars : [
		'sequencer',
		'display'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'running' }
ICSequencerDisplayTest >> setUp [

	super setUp.
	sequencer := 16 rumba.
	sequencer notes: #( 60 63 67 ).
	sequencer seqKey: #casio.
	display := ICSequencerDisplay on: sequencer
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testBarsOfSixteenSteps [

	display sequencer: 32 rumba.
	self assert: display children last children size equals: 2
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testNoNotesShowsEmptyTrigs [

	sequencer notes: #(  ).
	display sequencer: sequencer.
	self assert: (display newSteps allSatisfy: [ :step | step children isEmpty ])
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testNotesAdvanceOnTrigsOnly [

	| labels |
	labels := (display newSteps reject: [ :step | step children isEmpty ]) collect: [ :step | step children first text asString ].
	self assert: labels asArray equals: #( '60' '63' '67' '60' '63' )
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testOneStepPerGate [

	self assert: display newSteps size equals: sequencer gates size
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testRestsHaveNoNote [

	display newSteps with: sequencer gates asArray do: [ :step :gate | gate = 0 ifTrue: [ self assert: step children isEmpty ] ]
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTitleShowsKeyWithoutHash [

	self assert: display title equals: 'CASIO'
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTriggeredStepsUseTriggeredColor [

	display triggeredColor: Color cyan.
	display newSteps with: sequencer gates asArray do: [ :step :gate |
			self assert: step background paint color equals: (gate > 0
					 ifTrue: [ Color cyan ]
					 ifFalse: [ display groundColor ]) ]
]
