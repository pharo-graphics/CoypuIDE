Class {
	#name : #MfTimerElementSkin,
	#superclass : #ToRawSkin,
	#category : #MooflodTimerWidget
}

{ #category : #'event handling' }
MfTimerElementSkin >> installLookEvent: anEvent [
	"when installing the skin, changes the properties of widget mentionned down here"

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: e defaultGeometry.
		e size: 300 @ 300.
		e background: e backgroundPaint ]
]

{ #category : #'event handling' }
MfTimerElementSkin >> pressedLookEvent: anEvent [
	"Change the color of the widget when clicking on it"

	super pressedLookEvent: anEvent.

]
