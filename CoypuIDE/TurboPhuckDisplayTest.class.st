"
I test TurboPhuckDisplay and ICTurboParametersInstrument on hand-made parameter dictionaries (name -> type, like PhuckVM>>globals), never the VM: the display sender: block catches every change.
"
Class {
	#name : 'TurboPhuckDisplayTest',
	#superclass : 'TestCase',
	#instVars : [
		'sent'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'running' }
TurboPhuckDisplayTest >> display [

	^ (TurboPhuckDisplay on: self parameters)
		  sender: [ :name :value | sent add: name -> value ];
		  yourself
]

{ #category : 'running' }
TurboPhuckDisplayTest >> instrument: aName in: aDisplay [

	^ aDisplay instruments detect: [ :each | each name = aName ]
]

{ #category : 'running' }
TurboPhuckDisplayTest >> parameters [
	"kick and kick99 share a beginning, breaks is a loop, the master globals have no instrument"

	| params |
	params := Dictionary new.
	#( 'kickNote' 'kickGate' 'kickGain' 'kickIndex' 'kick99Note' 'kick99Gate' 'kick99Gain' 'kick99Decay' 'breaksNote' 'breaksGate'
	   'breaksGain' 'breaksReverse' 'breaksSlice' 'masterGain' 'performanceBPM' ) do: [ :each | params at: each put: #float ].
	^ params
]

{ #category : 'running' }
TurboPhuckDisplayTest >> setUp [

	super setUp.
	sent := OrderedCollection new
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testDelayKnobsAreInTheMasterSection [
	"the ranges of TurboDelay, its time at most one second; the send of a voice is a knob of the voice"

	| params display master panel kick |
	params := self parameters.
	#( 'delayTime' 'delayFeedback' 'delayTone' 'delayReturn' 'kickDelaySend' ) do: [ :each | params at: each put: #float ].
	display := (TurboPhuckDisplay on: params)
		           sender: [ :name :value | sent add: name -> value ];
		           yourself.
	master := self instrument: 'master' in: display.
	self assert: (master uiRanges at: 'delayTime') equals: #( 0.01 1.0 0.01 ).
	self assert: (master defaultFor: 'delayTime') equals: 0.375.
	self assert: (master uiLabelFor: 'delayFeedback') equals: 'Delay Feedback'.
	self
		assert: ((master globals collect: [ :each | each key ]) copyFrom: 1 to: 6) asArray
		equals: #( 'masterGain' 'performanceBPM' 'delayTime' 'delayFeedback' 'delayTone' 'delayReturn' ).
	panel := display panelFor: master.
	panel element.
	self assert: sent isEmpty.
	(panel knobs at: 'delayTime') setValue: 0.5.
	self assert: sent asArray equals: { ('delayTime' -> 0.5) }.
	kick := self instrument: 'kick' in: display.
	self assert: (kick uiRanges at: 'DelaySend') equals: #( 0 1 0.01 ).
	self assert: (kick globals detect: [ :each | each key = 'DelaySend' ]) value equals: 0
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testIndexFollowsTheSampleFolder [

	| root kick |
	root := FileSystem memory root.
	(root / 'kick') ensureCreateDirectory.
	#( 'a.wav' 'b.wav' 'c.wav' 'd.aif' ) do: [ :each | root / 'kick' / each writeStreamDo: [ :s | s << 'x' ] ].
	kick := (self instrument: 'kick' in: self display)
		        samplesRoot: root;
		        yourself.
	self assert: (kick uiRanges at: 'Index') equals: #( 0 3 1 )
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testInstrumentsComeFromTheGates [

	self assert: (self display instruments collect: [ :each | each name ]) asArray equals: #( 'master' 'breaks' 'kick' 'kick99' )
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testKnobsSendTheWholeParameterName [

	| display panel |
	display := self display.
	panel := display panelFor: (self instrument: 'kick99' in: display).
	panel element.
	self assert: sent isEmpty.
	(panel knobs at: 'Decay') setValue: 0.5.
	self assert: sent asArray equals: { ('kick99Decay' -> 0.5) }
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testLoopGetsItsToggleAndWhole [

	| breaks |
	breaks := self instrument: 'breaks' in: self display.
	self assert: breaks uiToggles equals: #( 'Reverse' ).
	self assert: breaks uiActions first key equals: 'WHOLE'.
	self deny: breaks canSpork
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testMasterTakesTheGlobalsOfNoInstrument [

	| master |
	master := self display instruments first.
	self assert: master isMaster.
	self assert: master suffixes asSet equals: #( 'masterGain' 'performanceBPM' ) asSet.
	self assert: (master uiLabelFor: 'performanceBPM') equals: 'BPM'.
	self assert: (master defaultFor: 'performanceBPM') equals: 174
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testMasterUIHasARowPerAux [
	"TurboPhuck basicNew: TurboPhuck new resets the Performance"

	| rows delay |
	rows := TurboPhuck basicNew masterUIRows.
	self assert: rows size equals: 1 + TurboAux all size.
	self assert: (rows first collect: [ :each | each inputText ]) asArray equals: #( 'pitchShift' 'highpassFreq' ).
	delay := rows at: 1 + (TurboAux all indexOf: TurboDelay default).
	self
		assert: (delay collect: [ :each | each inputText ]) asArray
		equals: #( 'Delay Time' 'Delay Feedback' 'Delay Tone' 'Delay Return' ).
	self assert: delay first minValue equals: 0.01.
	self assert: delay first maxValue equals: 1.0.
	self assert: (delay first angleToValue closeTo: 0.375).
	self assert: (delay collect: [ :each | each maxValue ]) asArray equals: #( 1.0 0.95 12000.0 1.0 )
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testMasterUIWindowFitsItsRows [
	"the widest row (the delay, four knobs) by one knob per row"

	| tp rows size |
	tp := TurboPhuck basicNew.
	rows := tp masterUIRows.
	size := rows first first widgetSize.
	self assert: (tp extentOfRows: rows) equals: size * 4 @ (size * rows size)
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testNoParametersSaysSo [

	| element |
	element := (TurboPhuckDisplay on: Dictionary new) element.
	self assert: (element text asString includesSubstring: 'No parameters')
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testSuffixesInTheUsualOrder [

	self
		assert: ((self instrument: 'breaks' in: self display) globals collect: [ :each | each key ]) asArray
		equals: #( 'Note' 'Gate' 'Gain' 'Slice' 'Reverse' )
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testTheLongestNameWins [
	"kick99Note belongs to kick99, not to kick with a suffix 99Note"

	| display |
	display := self display.
	self assert: (self instrument: 'kick' in: display) suffixes asSet equals: #( 'Note' 'Gate' 'Gain' 'Index' ) asSet.
	self assert: (self instrument: 'kick99' in: display) suffixes asSet equals: #( 'Note' 'Gate' 'Gain' 'Decay' ) asSet
]

{ #category : 'tests' }
TurboPhuckDisplayTest >> testWholeDisplayBuildsWithoutSending [

	| element |
	element := self display element.
	self assert: (element children inject: 0 into: [ :sum :column | sum + column children size ]) equals: 4.
	self assert: sent isEmpty
]
