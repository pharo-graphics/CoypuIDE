"
I am a White Key of the PianoKeyboard
"
Class {
	#name : 'ICPianoWhiteNoteElement',
	#superclass : 'ToElement',
	#instVars : [
		'width',
		'height'
	],
	#classVars : [
		'note'
	],
	#category : 'CoypuIDE-PianoKeyboard',
	#package : 'CoypuIDE',
	#tag : 'PianoKeyboard'
}

{ #category : 'accessing' }
ICPianoWhiteNoteElement class >> newWithColor: aColor [

	^ self new background: aColor; yourself
]

{ #category : 'api - bounds' }
ICPianoWhiteNoteElement >> height [

^ height
]

{ #category : 'api - bounds' }
ICPianoWhiteNoteElement >> height: anInteger [

	height := anInteger 
]

{ #category : 'initialization' }
ICPianoWhiteNoteElement >> initialize [

	super initialize.
	width := 32.
	height := 120. 
	self size: width @ height.
	self geometry: BlRectangleGeometry new.
	self border: (BlBorder paint: Color black width: 1)
]

{ #category : 'accessing' }
ICPianoWhiteNoteElement >> note [
^note
]

{ #category : 'accessing' }
ICPianoWhiteNoteElement >> note: aNote [

note:= aNote .
]

{ #category : 'api - bounds' }
ICPianoWhiteNoteElement >> width [

	 ^ width 
]

{ #category : 'api - bounds' }
ICPianoWhiteNoteElement >> width: anInteger [

	width := anInteger
]
