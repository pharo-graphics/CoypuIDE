"
I am the virtual Tp33 Bass Line connected to the Acid sound from TurboPhausto
"
Class {
	#name : 'Tp33',
	#superclass : 'Tp33_OnlyUI',
	#instVars : [
		'audioEngine',
		'notesArray',
		'isRunning',
		'patternPlay',
		'isPitchMode',
		'pattern1',
		'mode'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'accessing' }
Tp33 >> audioEngine [

	^ audioEngine
]

{ #category : 'accessing' }
Tp33 >> audioEngine: aDsp [

	audioEngine := aDsp
]

{ #category : 'as yet unclassified' }
Tp33 >> halfSize [

"approximately half size"
self transformDo: [ :t | t scaleBy:0.55. t translateBy: -350 @ (-180) ].
]

{ #category : 'initialization' }
Tp33 >> initialize [

	| dsp p |
	super initialize.
	mode := TpIdleMode new machine: self.
	"notesArrray is neeeded to map the keyboard buttons to note numbers"
	self initializeNotesArray.
	isRunning := false.



	dsp := Acid new stereo asDsp.
	dsp init.
	dsp start.
	audioEngine := dsp.
	self initializeNotesCallbacks.
	"just temporary patternPlay"
	p := Performance uniqueInstance forDsp: dsp.
	'40 , 40 , 41, 41, 43, 43, 40, 40, 40, 38, 38, 40, 38, 43, 43, 43'
		asDirtNotes to: #Acid.
	self initializeKnobsValuesAndRanges.

	self initializeWidgetsCallbacks.
	self initializeKnobsCallbacks
]

{ #category : 'initialization' }
Tp33 >> initializeKnobsCallbacks [

	self knob_CutoffFreq callBack: [ :v |
		self audioEngine setValue: v parameter: 'AcidCutoffFreq' ].
	self knob_Resonance callBack: [ :v |
		self audioEngine setValue: v parameter: 'AcidResonance' ].
	self knob_EnvMod callBack: [ :v |
		self audioEngine setValue: v parameter: 'AcidEnvMod' ].
	self knob_Tempo callBack: [ :v |
		Performance uniqueInstance freq: v bpm ]
]

{ #category : 'initialization' }
Tp33 >> initializeKnobsValuesAndRanges [

	self knob_CutoffFreq
		minValue: 0.2;
		maxValue: 1;
		stepValue: 0.001.

	self knob_Resonance
		minValue: 0;
		maxValue: 24;
		stepValue: 0.001.

	self knob_EnvMod
		minValue: 0.1;
		maxValue: 1;
		stepValue: 0.001.
		
		self knob_Tempo 
		minValue: 80;
		maxValue: 180;
		stepValue: 0.001.
		
]

{ #category : 'initialization' }
Tp33 >> initializeNotesArray [

	notesArray := Array new: 13.
	notesArray
		at: 1 put: self note_C1;
		at: 2 put: self note_CSharp;
		at: 3 put: self note_D;
		at: 4 put: self note_DSharp;
		at: 5 put: self note_E;
		at: 6 put: self note_F;
		at: 7 put: self note_FSharp;
		at: 8 put: self note_G;
		at: 9 put: self note_GSharp;
		at: 10 put: self note_A;
		at: 11 put: self note_ASharp;
		at: 12 put: self note_B;
		at: 13 put: self note_C
]

{ #category : 'initialization' }
Tp33 >> initializeNotesCallbacks [

	self mode handleKeyboardNotes.
]

{ #category : 'initialization' }
Tp33 >> initializeWidgetsCallbacks [

	| perf |
	perf := Performance uniqueInstance.
	self widget_RunStop callback: [ :v |
		self isRunning: v = 1.
		self isRunning
			ifTrue: [ Performance uniqueInstance playFor: 88 bars ]
			ifFalse: [ Performance uniqueInstance stop ] ].
	"we change the state and toggle the other button on the UI "
	self widget_PitchMode callback: [ self mode handleSwitchPitchMode ].
	"ENTER TIME MODE"
	self widget_TimeMode switch callback: [
		self mode handleSwitchTimeMode ].
	"we need to access the button inside the widget"
	self widget_PatternClear switch callback: [ 16 rests to: #Acid ].

	"note_9 , note_0 and note_100 behaviour depends on the mode"
	self note_9 callback: [ self mode handleNote_9 ].
	self note_0 callback: [ self mode handleNote_0 ].
	self note_100 callback: [ self mode handleNote_100 ].

	"function button"
	self widget_Function switch callback: [ self mode handleFunctionSwitch ]
]

{ #category : 'accessing' }
Tp33 >> isPitchMode [

	^ isPitchMode
]

{ #category : 'accessing' }
Tp33 >> isPitchMode: aBoolean [

	isPitchMode := aBoolean
]

{ #category : 'accessing' }
Tp33 >> isRunning [

^ isRunning 
]

{ #category : 'accessing' }
Tp33 >> isRunning: aBoolean [

isRunning := aBoolean 
]

{ #category : 'accessing' }
Tp33 >> mode [
	^ mode
]

{ #category : 'accessing' }
Tp33 >> mode: aTpMode [

	mode := aTpMode 
]

{ #category : 'instance creation' }
Tp33 >> newWithDsp: aDsp [

audioEngine := aDsp.
self initialize.
]

{ #category : 'accessing' }
Tp33 >> noteNumbers [

"MIDI NOTE NUMBERS at CENTER POSITION"

^ #( 48 49 50 51 52 53 54 55 56 57 58 59 60 )
]

{ #category : 'accessing' }
Tp33 >> notesArray [

	^ notesArray
]

{ #category : 'accessing' }
Tp33 >> notesArray: anArrayOfBlElements [

	notesArray := anArrayOfBlElements 
]

{ #category : 'as yet unclassified' }
Tp33 >> octaves [
	"Tp33 has 3 octaves, they can be changed with the transpose switches both for execution and writing"
^ self shouldBeImplemented 
	
]

{ #category : 'accessing' }
Tp33 >> patternPlay [

	^ patternPlay
]

{ #category : 'accessing' }
Tp33 >> patternPlay: anObject [

	patternPlay := anObject
]
