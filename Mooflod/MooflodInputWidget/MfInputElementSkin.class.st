Class {
	#name : #MfInputElementSkin,
	#superclass : #ToRawSkin,
	#category : #MooflodInputWidget
}

{ #category : #'event handling' }
MfInputElementSkin >> installLookEvent: anEvent [
	"when installing the skin, changes the properties of widget mentionned down here"

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')).
		e background: e backgroundPaint ]
]

{ #category : #'event handling' }
MfInputElementSkin >> pressedLookEvent: anEvent [
	"Change the color of the widget when clicking on it"
	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e plus background: Color blue.
		e minus background: Color red.
		]. 
]
