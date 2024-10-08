"
I am a Black Key of the Piano Keyboard
"
Class {
	#name : 'ICPianoBlackNoteElement',
	#superclass : 'ICPianoNoteElement',
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'instance creation' }
ICPianoBlackNoteElement class >> newWithColor: aColor [

	^ self new
		  background: aColor;
		  yourself
]

{ #category : 'api - bounds' }
ICPianoBlackNoteElement >> height: anInteger [

	height := anInteger 
]

{ #category : 'initialization' }
ICPianoBlackNoteElement >> initialize [

	super initialize.
	width := 16.
	height := 70.
	bgColor := Color black.
	self size: width @ height.
	self geometry: BlRectangleGeometry new.
	self background: self bgColor .
	self constraintsDo: [ :e | e frame vertical alignTop ]
]

{ #category : 'api - bounds' }
ICPianoBlackNoteElement >> width [ 
^ width
]

{ #category : 'api - bounds' }
ICPianoBlackNoteElement >> width: anInteger [

	width := anInteger 
]
