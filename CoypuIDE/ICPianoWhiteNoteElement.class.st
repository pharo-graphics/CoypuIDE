Class {
	#name : 'ICPianoWhiteNoteElement',
	#superclass : 'ToElement',
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

{ #category : 'initialization' }
ICPianoWhiteNoteElement >> initialize [

	super initialize.
	self size: 36 @ 130.
	self geometry: BlRectangleGeometry new.
	self border: (BlBorder paint: Color black width: 1).

]

{ #category : 'accessing' }
ICPianoWhiteNoteElement >> note [
^note
]

{ #category : 'accessing' }
ICPianoWhiteNoteElement >> note: aNote [

note:= aNote .
]
