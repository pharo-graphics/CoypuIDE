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
		'callbackDown',
		'callbackUp'
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
ICPianoKeyboardElement >> blackKeyWidth [

	^ 16
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

	^ callbackDown ifNil: [
		  callbackDown := [ :x | x asString , ' keyDown ' ] ]
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackDown: anObject [

	callbackDown := anObject
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackUp [

	^ callbackUp ifNil: [
		  callbackUp := [ :x | (x asString , ' keyUp ') traceCr ] ]
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> callbackUp: aCallback [

	callbackUp :=aCallback
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

	^ 70
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> highestNote: anObject [

	highestNote := anObject
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
	self initializeEvents .
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
ICPianoKeyboardElement >> initializeEvents [

| cbUp cbDown |
cbUp := self callbackUp .
cbDown := self callbackDown .
	self addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent |
				 cbDown value: (self getNoteAtPosition: anEvent position) ]).
			
		self addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :anEvent |
				 cbUp value: (self getNoteAtPosition: anEvent position) ])
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
ICPianoKeyboardElement >> whiteKeyWidth [

	^ 32
]

{ #category : 'accessing' }
ICPianoKeyboardElement >> whiteKeyWidth: anObject [

	whiteKeyWidth := anObject
]
