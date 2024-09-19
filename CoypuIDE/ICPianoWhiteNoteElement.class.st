"
I am a White Key of the PianoKeyboard
"
Class {
	#name : 'ICPianoWhiteNoteElement',
	#superclass : 'ICPianoNoteElement',
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
	width := 32.
	height := 120.
	bgColor := Color white.
	self size: width @ height.
	self geometry: BlRectangleGeometry new.
	self background: self bgColor .
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
