"
I am an ICPianoNoteElement I have black and white subclasses
"
Class {
	#name : 'ICPianoNoteElement',
	#superclass : 'ToElement',
	#instVars : [
		'width',
		'height',
		'isPressed',
		'bgColor',
		'noteNumber'
	],
	#classVars : [
		'CallbackDown',
		'CallbackUp',
		'computerKeysToMIDINN'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'accessing' }
ICPianoNoteElement class >> callbackDown [

	^ CallbackDown ifNil: [
		  CallbackDown := [ :x | (x asString , ' keyDown ') traceCr ] ]
]

{ #category : 'accessing' }
ICPianoNoteElement class >> callbackDown: aCallback [

	CallbackDown := aCallback
]

{ #category : 'accessing' }
ICPianoNoteElement class >> callbackUp [

	^ CallbackUp ifNil: [
		  CallbackUp := [ :x | (x asString , ' keyUp ') traceCr ] ]
]

{ #category : 'accessing' }
ICPianoNoteElement class >> callbackUp: aCallback [

	CallbackUp := aCallback
]

{ #category : 'as yet unclassified' }
ICPianoNoteElement class >> computerKeysToMIDINN [

	| computerKeys |
	computerKeys := Dictionary new.
	computerKeys
	"lower Octave"
		add: #z => 48; "C"
		add: #s => 49; "C#" 
		add: #x => 50; "D"
		add: #d => 51; "D#"
		add: #c => 52; "E"
		add: #v => 53; "F"
		add: #g => 54;
		add: #b => 55; "G"
		add: #h => 56; "G#"
		add: #n => 57; "A"
		add: #j => 58; "A#"
		add: #m => 59. "B"
]

{ #category : 'accessing' }
ICPianoNoteElement >> bgColor [

	^ bgColor
]

{ #category : 'accessing' }
ICPianoNoteElement >> bgColor: aColor [

	bgColor := aColor
]

{ #category : 'api - bounds' }
ICPianoNoteElement >> height [

^ height
]

{ #category : 'api - bounds' }
ICPianoNoteElement >> height: anInteger [

	height := anInteger 
]

{ #category : 'initialization' }
ICPianoNoteElement >> initialize [

	super initialize.
	isPressed := false.
	self initializeEvents
]

{ #category : 'initialization' }
ICPianoNoteElement >> initializeEvents [

	| cbUp cbDown |
	cbUp := self class callbackUp.
	cbUp traceCr.
	cbDown := self class callbackDown.
	self addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent |
				 self toggle.
				 cbDown value: self noteNumber ]).

	self addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :anEvent |
				 self toggle.
				 cbUp value: self noteNumber ])
]

{ #category : 'accessing' }
ICPianoNoteElement >> isPressed [

	^ isPressed
]

{ #category : 'accessing' }
ICPianoNoteElement >> isPressed: aBoolean [

	isPressed := aBoolean
]

{ #category : 'accessing' }
ICPianoNoteElement >> noteNumber [

	^ noteNumber
]

{ #category : 'accessing' }
ICPianoNoteElement >> noteNumber: anInteger [

	noteNumber := anInteger
]

{ #category : 'evaluating' }
ICPianoNoteElement >> toggle [

	self togglePressed.
	self isPressed = false
		ifTrue: [ self background: self bgColor ]
		ifFalse: [ self background: (Color yellow alpha: 1.0) ]
]

{ #category : 'switch' }
ICPianoNoteElement >> togglePressed [

self isPressed = false
ifTrue: [ self isPressed: true ] ifFalse: [ self isPressed: false ]
]

{ #category : 'initialization' }
ICPianoNoteElement >> toggleValue [

	self value = 0
		ifTrue: [ self value: 1 ]
		ifFalse: [ self value: 0 ]
]

{ #category : 'api - bounds' }
ICPianoNoteElement >> width [

	 ^ width 
]

{ #category : 'api - bounds' }
ICPianoNoteElement >> width: anInteger [

	width := anInteger
]
