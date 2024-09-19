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
		'blackKeys'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'examples' }
ICPianoKeyboardElement class >> openPiano [

	<script>
	| space aPiano |
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
ICPianoKeyboardElement >> balckKeyWidth [

	^ 12
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> highestNote [

	^ 70
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initalizeWhiteNotes [

	| whiteNoteX |
	whiteNoteX := self pianoX.

	pianoKeys size timesRepeat: [
		self addChild:
			(ICPianoWhiteNoteElement new position: whiteNoteX @ 0).
		whiteNoteX := whiteNoteX + self whiteKeyWidth ]
]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initialize [

	super initialize.

	self
		extent: 1000 @ 200;
		background: Color black.
	self initializeKeys.
	self initalizeWhiteNotes.
	self initializeBlackKeys.

]

{ #category : 'initialization' }
ICPianoKeyboardElement >> initializeBlackKeys [

	| blackNoteX blackNoteOffsets blackOffset |
	"Initial position for first black key (C#) relative to C"
	blackNoteX := self pianoX + (self whiteKeyWidth * 0.75).

	"Define the black key offsets within the octave (C#, D#, F#, G#, A#)"
	blackNoteOffsets := {
		                    self whiteKeyWidth. "C# to D#"
		                    (self whiteKeyWidth * 2). "D# to F# (skipping E)"
		                    self whiteKeyWidth. "F# to G#"
		                    self whiteKeyWidth. "G# to A#"
		                    self whiteKeyWidth "A# to next C" }.

	"Iterate through the black keys and position them"
	blackKeys withIndexDo: [ :note :index | "Get the correct offset for the black key based on the current position"
		blackOffset := blackNoteOffsets at: index - 1 \\ 5 + 1.

		"Create and position the black key"
		self addChild:
			(ICPianoBlackNoteElement new position: blackNoteX @ 0).

		"Move to the next black key position"
		blackNoteX := blackNoteX + blackOffset.

		"At the end of the octave (after A#), add extra space for the next octave"
		index - 1 \\ 5 = 4 ifTrue: [
			blackNoteX := blackNoteX + self whiteKeyWidth ] ]
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
ICPianoKeyboardElement >> lowestNote [
^ 24
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> pianoX [
	"where white notes start"

	^ 150
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> whiteKeyWidth [

	^ 24
]
