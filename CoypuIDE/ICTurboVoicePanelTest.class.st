"
I test ICTurboVoicePanel without the ChucK VM: every change the panel makes is caught by its sender block, and sample folders live in a memory file system.
"
Class {
	#name : 'ICTurboVoicePanelTest',
	#superclass : 'TestCase',
	#instVars : [
		'sent'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
ICTurboVoicePanelTest >> buttonLabelsIn: anElement [

	| labels |
	labels := OrderedCollection new.
	anElement allChildrenBreadthFirstDo: [ :each | (each isKindOf: ICSimpleButton) ifTrue: [ labels add: each inputText ] ].
	^ labels asArray
]

{ #category : 'running' }
ICTurboVoicePanelTest >> loopsFolder [
	"three loops, so the index knob has a range"

	| folder |
	folder := FileSystem memory root / 'breaks'.
	folder ensureCreateDirectory.
	#( 'a|170.wav' 'b|120.wav' 'c|90.aif' ) do: [ :each | folder / each writeStreamDo: [ :s | s << 'x' ] ].
	folder / '.hidden.wav' writeStreamDo: [ :s | s << 'x' ].
	folder / 'notes.txt' writeStreamDo: [ :s | s << 'x' ].
	^ folder
]

{ #category : 'running' }
ICTurboVoicePanelTest >> panelOn: aVoice [

	^ (ICTurboVoicePanel on: aVoice)
		  sender: [ :suffix :value | sent add: suffix -> value ];
		  yourself
]

{ #category : 'running' }
ICTurboVoicePanelTest >> setUp [

	super setUp.
	sent := OrderedCollection new
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testBuildingSendsNothing [
	"knobs are placed on their defaults before their callbacks exist"

	(self panelOn: (ZdLoopPlayer folder: self loopsFolder)) element.
	(self panelOn: TurboAcid new) element.
	self assert: sent isEmpty
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testButtonsFillTheCellsAfterTheLastKnob [
	"6 knobs leave 2 free cells in a row of 4: 5 buttons go 3 to a cell, in the same grid as the knobs"

	| panel grid |
	panel := self panelOn: (ZdLoopPlayer folder: self loopsFolder).
	grid := panel element children second.
	self assert: grid children size equals: 6 + 2.
	self assert: (panel buttonsPerCell: 5 after: 6) equals: 3.
	self assert: (panel buttonsPerCell: 4 after: 8) equals: 1.
	self assert: (panel buttonsPerCell: 9 after: 7) equals: 4
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testEveryRigVoiceGetsAPanel [

	| root |
	root := FileSystem memory root / 'TurboSamples'.
	root ensureCreateDirectory.
	(root / 'kick') ensureCreateDirectory.
	root / 'kick' / 'k1.wav' writeStreamDo: [ :s | s << 'x' ].
	root / 'kick' / 'k2.wav' writeStreamDo: [ :s | s << 'x' ].
	(TurboRig new root: root) voices do: [ :voice |
			| panel |
			panel := self panelOn: voice.
			panel element.
			self assert: panel knobs notEmpty ].
	self assert: sent isEmpty
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testIndexRangeFollowsTheAudioFiles [

	| voice |
	voice := ZdLoopPlayer folder: self loopsFolder.
	self assert: voice audioFiles asArray equals: #( 'a|170.wav' 'b|120.wav' 'c|90.aif' ).
	self assert: (voice uiRanges at: 'Index') equals: #( 0 2 1 )
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testKnobSendsAFloatToItsGlobal [

	| panel |
	panel := self panelOn: TurboAcid new.
	panel element.
	(panel knobs at: 'Note') setValue: 60.
	self assert: sent last key equals: 'Note'.
	self assert: sent last value equals: 60.0.
	self assert: sent last value isFloat
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testKnobsStartAtTheDefaults [

	| panel |
	panel := self panelOn: TurboAcid new.
	panel element.
	self assert: (panel knobs at: 'Note') currentValue equals: 48.
	self assert: ((panel knobs at: 'Cutoff') currentValue closeTo: 0.3)
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testLoopPanelControls [

	| panel element |
	panel := self panelOn: (ZdLoopPlayer folder: self loopsFolder).
	element := panel element.
	self assert: panel knobs keys asArray equals: #( 'Note' 'Gain' 'Index' 'Position' 'Slice' 'Length' ).
	self assert: (self buttonLabelsIn: element) asSet equals: #( 'SPORK' 'TRIG' 'GATE' 'REVERSE' 'WHOLE' ) asSet
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testOneFileFolderHasNoIndexKnob [

	| folder panel |
	folder := FileSystem memory root / 'one'.
	folder ensureCreateDirectory.
	folder / 'only|170.wav' writeStreamDo: [ :s | s << 'x' ].
	panel := self panelOn: (ZdLoopPlayer folder: folder).
	panel element.
	self deny: (panel knobs includesKey: 'Index')
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testToggleSendsItsSuffix [

	| panel element |
	panel := self panelOn: TurboAcid new.
	element := panel element.
	(panel buttonNamed: 'WAVEFORM' in: element) fire.
	self assert: sent asArray equals: { ('Waveform' -> 1.0) }
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testTrigIsHeldGateIsLatched [

	| panel element trig gate |
	panel := self panelOn: TurboHoover new.
	element := panel element.
	trig := panel buttonNamed: 'TRIG' in: element.
	gate := panel buttonNamed: 'GATE' in: element.
	trig fire.
	trig fire.
	gate fire.
	self assert: sent asArray equals: {
			('Gate' -> 1.0).
			('Gate' -> 0.0).
			('Gate' -> 1.0) }
]

{ #category : 'tests' }
ICTurboVoicePanelTest >> testWholeTurnsSlicingOff [

	| panel element |
	panel := self panelOn: (ZdLoopPlayer folder: self loopsFolder).
	element := panel element.
	(panel knobs at: 'Slice') setValue: 4.
	(panel buttonNamed: 'WHOLE' in: element) fire.
	self assert: sent last equals: 'Slice' -> -1.0.
	self assert: (panel knobs at: 'Slice') currentValue equals: -1
]
