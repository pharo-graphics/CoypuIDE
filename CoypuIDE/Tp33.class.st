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
		'patternPlay'
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

{ #category : 'initialization' }
Tp33 >> initialize [

	| dsp p |
	super initialize.
	self initializeNotesArray.
	isRunning := false.


	dsp := Acid new stereo asDsp.
	dsp init.
	dsp start.
	audioEngine := dsp.
	self initializeNotesCallbacks.
	"just temporary patternPlay"
	p := Performance uniqueInstance forDsp: dsp.
	'35 , 48 , 56 , 71, ~ , ~ , 52 , 38, 39 , 43, ~ , 53 , ~ , 36 , 46 , 51 , 65'
		asDirtNotes to: #Acid.

   self initializeWidgetsCallbacks .
	'acido engine iniz' traceCr
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

	| noteNumbers |
	noteNumbers := #( 60 61 62 63 64 65 66 67 68 69 70 71 72 73 ).

	notesArray do: [ :key | "callbacks on mouseDown"
		key callbackDown: [
			audioEngine
				setValue:
					(noteNumbers at: (notesArray indexOf: key)) midiNoteToFreq
				parameter: 'AcidNote'.
			audioEngine setValue: 1 parameter: 'AcidGate'.
			(noteNumbers at: (notesArray indexOf: key)) midiNoteToFreq traceCr ].

		"On mouseUp"
		key callBackUp: [ audioEngine setValue: 0 parameter: 'AcidGate' ] ]
]

{ #category : 'initialization' }
Tp33 >> initializeWidgetsCallbacks [

	self widget_RunStop callback: [ :v |
		self isRunning: v = 1.
		self isRunning
			ifTrue: [ Performance uniqueInstance playFor: 88 bars]
			ifFalse: [ Performance uniqueInstance stop ] ]
]

{ #category : 'accessing' }
Tp33 >> isRunning [

^ isRunning 
]

{ #category : 'accessing' }
Tp33 >> isRunning: aBoolean [

isRunning := aBoolean 
]

{ #category : 'instance creation' }
Tp33 >> newWithDsp: aDsp [

audioEngine := aDsp.
self initialize.
]

{ #category : 'accessing' }
Tp33 >> notesArray [

	^ notesArray
]

{ #category : 'accessing' }
Tp33 >> notesArray: anArrayOfBlElements [

	notesArray := anArrayOfBlElements 
]

{ #category : 'accessing' }
Tp33 >> patternPlay [

	^ patternPlay
]

{ #category : 'accessing' }
Tp33 >> patternPlay: anObject [

	patternPlay := anObject
]
