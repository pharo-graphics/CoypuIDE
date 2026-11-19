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
	self assert: element children size equals: 4.
	self assert: sent isEmpty
]
