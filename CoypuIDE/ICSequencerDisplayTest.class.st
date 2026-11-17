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
ICSequencerDisplayTest >> testBackspaceAndNonDigits [

	display hoverStepAt: 1.
	display typeText: '6a5'.
	display pressKey: KeyboardKey backspace.
	display typeText: '2'.
	display pressKey: KeyboardKey enter.
	self assert: sequencer notes first equals: 62
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testBarsOfSixteenSteps [

	display sequencer: 32 rumba.
	self assert: display children last children size equals: 2
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testClickOnStepTogglesTrig [

	| step |
	step := display children last children first children first children second.
	BlEvent fireEvent: BlClickEvent new target: step.
	self assert: (sequencer gates at: 2) equals: 1
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testEscapeCancelsTyping [

	display hoverStepAt: 4.
	display typeText: '99'.
	display pressKey: KeyboardKey escape.
	self assert: display editingIndex isNil.
	self assert: sequencer notes asArray equals: #( 60 63 67 )
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testLeavingTheStepCommitsTheNote [

	display hoverStepAt: 4.
	display typeText: '7'.
	display typeText: '2'.
	display leaveStepAt: 4.
	self assert: sequencer notes asArray equals: #( 60 72 67 60 63 )
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
ICSequencerDisplayTest >> testToggleStepInsertsAndDeletesTrig [

	self assert: (sequencer gates at: 2) equals: 0.
	display toggleStepAt: 2.
	self assert: (sequencer gates at: 2) equals: 1.
	self assert: display newSteps size equals: sequencer gates size.
	display toggleStepAt: 2.
	self assert: (sequencer gates at: 2) equals: 0
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTriggeredStepsUseTriggeredColor [

	display triggeredColor: Color cyan.
	display newSteps with: sequencer gates asArray do: [ :step :gate |
			self assert: step background paint color equals: (gate > 0
					 ifTrue: [ Color cyan ]
					 ifFalse: [ display groundColor ]) ]
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTypedNoteShowsInItsStep [

	display hoverStepAt: 4.
	display typeText: '7'.
	self assert: (display steps at: 4) children first text asString equals: '7_'
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTypingOverARestMakesATrigAndKeepsOtherNotes [

	display hoverStepAt: 2.
	display typeText: '48'.
	display pressKey: KeyboardKey enter.
	self assert: (sequencer gates at: 2) equals: 1.
	self assert: sequencer gates size equals: 16.
	self assert: sequencer notes asArray equals: #( 60 48 63 67 60 63 )
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTypingOverATrigSetsItsNote [

	display hoverStepAt: 4.
	display typeText: '72'.
	display pressKey: KeyboardKey enter.
	self assert: display editingIndex isNil.
	self assert: sequencer gates size equals: 16.
	self assert: sequencer notes asArray equals: #( 60 72 67 60 63 )
]

{ #category : 'tests' }
ICSequencerDisplayTest >> testTypingWithoutHoverDoesNothing [

	display typeText: '72'.
	display pressKey: KeyboardKey enter.
	self assert: display editingIndex isNil.
	self assert: sequencer notes asArray equals: #( 60 63 67 )
]
