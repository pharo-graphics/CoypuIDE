Class {
	#name : 'ICPianoNoteElement',
	#superclass : 'ToElement',
	#instVars : [
		'width',
		'height',
		'isPressed',
		'bgColor'
	],
	#classVars : [
		'note'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

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

	self addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent | self toggle ]).

	self addEventHandler: (BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :anEvent |
				 self toggle.
				 Transcript show: 'Key up' ])
]

{ #category : 'accessing' }
ICPianoNoteElement >> isPressed [

	^ isPressed
]

{ #category : 'accessing' }
ICPianoNoteElement >> isPressed: aBoolean [

	isPressed := aBoolean
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
