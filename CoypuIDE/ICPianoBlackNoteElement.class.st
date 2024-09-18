Class {
	#name : 'ICPianoBlackNoteElement',
	#superclass : 'ToElement',
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

{ #category : 'initialization' }
ICPianoBlackNoteElement >> initialize [

	super initialize.
	self size: 20 @ 75.
	self geometry: BlRectangleGeometry new.
	self constraintsDo: [ :e | e frame vertical alignTop ]
]
