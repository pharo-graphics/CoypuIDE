"
I am a PianoKeyboard that can be used with Coypu and Phausto
"
Class {
	#name : 'ICPianoKeyboardElement',
	#superclass : 'BlElement',
	#instVars : [
		'whiteKeyWidth',
		'blackKeyWidth',
		'keyHeight',
		'lowestNote',
		'highestNote',
		'pianoKeys',
		'blackKeys',
		'startOctave',
		'callbackUp',
		'callbackDown'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'as yet unclassified' }
ICPianoKeyboardElement class >> computerKeysToMIDINN [

	| computerKeys |
	computerKeys := Dictionary new.
	computerKeys
		add: 'Z' -> 48;
		"C"add: 'S' -> 49;
		"C#"add: 'X' -> 50;
		"D"add: 'D' -> 51;
		"D#"add: 'C' -> 52;
		"E"add: 'V' -> 53;
		"F"add: 'G' -> 54;
		add: 'B' -> 55;
		"G"add: 'H' -> 56;
		"G#"add: 'N' -> 57;
		"A"add: 'J' -> 58;
		"A#"add: 'M' -> 59;
		"B"add: '<' -> 60;
		"upper Octave Z to M"add: 'Q' -> 60;
		"C"add: '2' -> 61;
		"C#"add: 'W' -> 62;
		"D"add: '3' -> 63;
		"D#"add: 'E' -> 64;
		"E"add: 'R' -> 65;
		"F"add: '5' -> 66;
		add: 'T' -> 67;
		"G"add: '6' -> 68;
		"G#"add: 'Y' -> 69;
		"A"add: '7' -> 70;
		"A#"add: '8' -> 71;
		"B"add: 'U' -> 72.

	^ computerKeys
]

{ #category : 'as yet unclassified' }
ICPianoKeyboardElement class >> newForDsp: aDsp [
	"the keyboard can play a DSP designed for MIDI control following Phausto/Faust rules"

	| anICPianoKeyboardElement |
	
	aDsp requirePianoKeyboard
		ifFalse: [
		Error new signal: 'This is not a MIDI DSP check its creation' ]
		ifTrue: [
			ICPianoNoteElement callbackDown: [ :x |
				aDsp setValue: x midiNoteToFreq parameter: 'freq'.
				aDsp setValue: 1 parameter: 'gate' ].
			ICPianoNoteElement callbackUp: [ :x |
				aDsp setValue: 0 parameter: 'gate' ].
			anICPianoKeyboardElement := self new.
	anICPianoKeyboardElement initializeComputerKeysEventsTo: aDsp.
			].
	^ anICPianoKeyboardElement
]

{ #category : 'examples' }
ICPianoKeyboardElement class >> openPiano [

	<script>
	| space aPiano |
	ICPianoNoteElement
		callbackUp: nil;
		callbackDown: nil.
	space := BlSpace new
		         extent: 1000 @ 100;
		         title: 'ICPianoKeyboard'.
	space root background: Color black.
	"layout: BlFlowLayout horizontal."
	aPiano := self new.
	"aPiano transformDo: [ :c | c translateBy: 200 @ 200 ]."
	space root addChild: aPiano.
	space show.
	^ space
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> blackKeyWidth [

	^ 12
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> blackKeyWidth: anObject [

	blackKeyWidth := anObject
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> blackKeys [
^ blackKeys
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> blackKeys: anObject [

	blackKeys := anObject
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackDown [

	^ callbackDown  ifNil: [ :x | ( x asString , ' keyDown') traceCr ]
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackDown: aCallback [

	callbackDown := aCallback 
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackUp [

	^ callbackUp ifNil: [ :x | ( x asString , ' keyUp') traceCr ]
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackUp: aCallback [

	callbackUp := aCallback 
]

{ #category : 'accessing - position' }
ICPianoKeyboardElement >> getNoteAtPosition: aPoint [
    | xPos yPos noteStart noteEnd blackKeyHeight closestNote note |
    
    xPos := aPoint x.
    yPos := aPoint y.
    blackKeyHeight :=70. "The height of the black keys"
    closestNote := nil.

    "1. First, prioritize checking for black keys"
    closestNote := self blackKeys
        detect: [ :blackKey | 
            noteStart := (blackKey - self lowestNote) * self whiteKeyWidth + (self whiteKeyWidth // 2) - (self blackKeyWidth // 2).
            noteEnd := noteStart + self blackKeyWidth.
            "Check if the x position is within the black key's width and the y position is within the black key's height"
            (xPos >= noteStart and: [ xPos <= noteEnd ]) and: [ yPos <= blackKeyHeight ]
        ] ifNone: [ nil ].

    "2. If a black key is detected, return it."
    closestNote ifNotNil: [ ^ closestNote ].

    "3. If no black key is detected, check for white keys"
    note := self pianoKeys
        detect: [ :whiteKey | 
            noteStart := (whiteKey - self lowestNote) * self whiteKeyWidth.
            noteEnd := noteStart + self whiteKeyWidth.
            "Check if the x position is within the white key's width"
            xPos >= noteStart and: [ xPos <= noteEnd ]
        ] ifNone: [ nil ].

    "4. Ensure a valid note is always returned, default to the closest white key if needed"
    ^ note ifNil: [ self lowestNote ].

]

{ #category : 'accessing' }
ICPianoKeyboardElement >> highestNote [

	^ 96
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> highestNote: anObject [

	highestNote := anObject
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initalizeWhiteKeys [

	| whiteNoteX whiteNoteNumbers  counter |
	whiteNoteX := self pianoX.
	counter := 0. "Initialize counter to 0 for the note numbering"
	whiteNoteNumbers := #( 0 2 4 5 7 9 11 ).
	pianoKeys size timesRepeat: [ "Calculate the current note number based on the counter"
		| noteNumber octave |
		"Calculate octave: every 7 increments of the counter"
		octave := counter // 7 * 12.

		"Calculate the note within the octave using modulo operation"
		noteNumber := octave + (whiteNoteNumbers at: counter \\ 7 + 1).

		self addChild: (ICPianoWhiteNoteElement new
				 position: whiteNoteX @ 0;
				 noteNumber: noteNumber + (self startOctave * 12)).
		whiteNoteX := whiteNoteX + self whiteKeyWidth.

		counter := counter + 1 "Increment the counter for the next note" ]
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initialize [

	super initialize.

	self
		extent: 1400 @ 200;
		background: Color black.
	self initializeKeys.
	self initalizeWhiteKeys.
	self initializeBlackKeys.
	"self initializeEvents."
	self initializeComputerKeyboardVisualEvents
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initializeBlackKeys [
	| blackNoteX blackNoteOffsets blackOffset noteNumber currentOctave numOctaves blackKeyCount totalBlackKeys |
	
	"Initial position for the first black key (C#) relative to C"
	blackNoteX := self pianoX + (self whiteKeyWidth * 0.75).
	
	"Number of octaves in the keyboard"
	numOctaves := 6. "You have a 6-octave keyboard"
	
	"Total number of black keys"
	blackKeyCount := 5. "Five black keys per octave"
	totalBlackKeys := numOctaves * blackKeyCount.
	
	"Define the black key offsets within the octave (C#, D#, F#, G#, A#)"
	blackNoteOffsets := { 
		                    self whiteKeyWidth. "C# to D#"
		                    (self whiteKeyWidth * 2). "D# to F# (skipping E)"
		                    self whiteKeyWidth. "F# to G#"
		                    self whiteKeyWidth. "G# to A#"
		                    self whiteKeyWidth. "A# to next C" }.

	"Start with the first octave"
	currentOctave := self startOctave.

	"Iterate through the black keys and position them for multiple octaves"
	(1 to: totalBlackKeys) do: [ :globalIndex | 
		| localIndex |
		
		"Calculate the local index (1 to 5) for the black key within the current octave"
		localIndex := (globalIndex - 1 \\ blackKeyCount) + 1.
		
		"Calculate the note number based on the index of the black key within the current octave"
		noteNumber := localIndex = 1
			              ifTrue: [ 1 ] "C#"
			              ifFalse: [ 
				              localIndex = 2
					              ifTrue: [ 3 ] "D#"
					              ifFalse: [ 
						              localIndex = 3
							              ifTrue: [ 6 ] "F#"
							              ifFalse: [ 
								              localIndex = 4
									              ifTrue: [ 8 ] "G#"
									              ifFalse: [ 10 ] "A#" ] ] ].
		
		"Create and position the black key with the correct note number for the current octave"
		self addChild: (ICPianoBlackNoteElement new
				 position: blackNoteX @ 0;
				 noteNumber: noteNumber + (currentOctave * 12)).
		
		"Get the correct offset for the black key based on the current position"
		blackOffset := blackNoteOffsets at: localIndex.

		"Move to the next black key position"
		blackNoteX := blackNoteX + blackOffset.

		"At the end of the octave (after A#), add extra space for the next octave"
		localIndex = blackKeyCount ifTrue: [
			"Move to the next octave and adjust the position"
			blackNoteX := blackNoteX + self whiteKeyWidth.
			currentOctave := currentOctave + 1 ] ].

]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initializeComputerKeyboardVisualEvents [

	| keysToMIDInn octaveOffset sortedNotes |
	keysToMIDInn := self class computerKeysToMIDINN.
	sortedNotes := self sortedNotes.
	octaveOffset := self lowestNote - 1.
	self addEventHandler: (BlEventHandler
			 on: BlKeyDownEvent
			 do: [ :anEvent |
				 keysToMIDInn
					 at: anEvent key name
					 ifPresent: [ :k | (sortedNotes at: k - octaveOffset) toggle
						 ] ]).

	self addEventHandler: (BlEventHandler
			 on: BlKeyUpEvent
			 do: [ :anEvent |
				 keysToMIDInn
					 at: anEvent key name
					 ifPresent: [ :k | (sortedNotes at: k - octaveOffset) toggle ] ]).

	self requestFocus

	"
		self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: Color red ] ].
	self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: Color darkGray ] ].
	self requestFocus"
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initializeComputerKeysEventsTo: aDsp [
	"control a dsp with computer keyboard - at the moment only monophonic. no mechanism for glide"

	| keysToMIDInn |
	keysToMIDInn := self class computerKeysToMIDINN.
	self addEventHandler: (BlEventHandler
			 on: BlKeyDownEvent
			 do: [ :anEvent |
				 keysToMIDInn at: anEvent key name ifPresent: [ :k |
					"!!!!!!! transposed by 1 octave - mechanism for octave must be adjusted"
					 aDsp setValue: (k + 12) midiNoteToFreq parameter: 'freq'.
					 aDsp setValue: 1 parameter: 'gate' ] ]).

	self addEventHandler: (BlEventHandler
			 on: BlKeyUpEvent
			 do: [ :anEvent | aDsp setValue: 0 parameter: 'gate' ]).
	self requestFocus
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initializeEvents [

	| keysToMIDInn |
	
	keysToMIDInn := self class computerKeysToMIDINN.

	self addEventHandler: (BlEventHandler
			 on: BlKeyDownEvent
			 do: [ :anEvent |
				 keysToMIDInn at: anEvent key name ifPresent: [ :k | k traceCr ] ]).

	self addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :anEvent |  ]).
	self requestFocus

	"
		self addEventHandlerOn: BlKeyDownEvent do: [ :anEvent |
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: Color red ] ].
	self addEventHandlerOn: BlKeyUpEvent do: [ :anEvent |
		keymap
			at: anEvent key
			ifPresent: [ :aButton | aButton background: Color darkGray ] ].
	self requestFocus"
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initializeKeys [
	"Initialize both white and black keys"

	pianoKeys := OrderedCollection new.
	blackKeys := OrderedCollection new.

	self lowestNote to: (self highestNote + 1)do: [ :midiNote |
		| isBlackKey |
		isBlackKey := self isBlackKey: midiNote.

		isBlackKey
			ifTrue: [ blackKeys add: midiNote ]
			ifFalse: [ pianoKeys add: midiNote ] ].

	^ self
]

{ #category : 'testing' }
ICPianoKeyboardElement >> isBlackKey: midiNote [
    | noteInOctave |
    noteInOctave := midiNote \\ 12.
    ^ #(1 3 6 8 10) includes: noteInOctave
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> keyHeight [

^ 120
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> keyHeight: anObject [

	keyHeight := anObject
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> lowestNote [

	^ 24
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> lowestNote: anObject [

	lowestNote := anObject
]

{ #category : 'as yet unclassified' }
ICPianoKeyboardElement >> newForDsp: aDsp [ 
	^ self class newForDsp: aDsp 
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> pianoKeys [

	^ pianoKeys
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> pianoKeys: anObject [

	pianoKeys := anObject
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> pianoX [
	"where white notes start"

	^ 150
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> sortedNotes [
	" return Piano keys sorted by their note number"

	^ self  children asSortedCollection: [ :a :b |
		  a noteNumber < b noteNumber ]
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> startOctave [

	^ startOctave ifNil: [  startOctave := 2 ]
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> startOctave: anInteger [

	startOctave := anInteger
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> whiteKeyWidth [

	^ 24
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> whiteKeyWidth: anObject [

	whiteKeyWidth := anObject
]
