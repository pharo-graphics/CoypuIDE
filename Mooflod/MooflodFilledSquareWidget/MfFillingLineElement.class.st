Class {
	#name : #MfFillingLineElement,
	#superclass : #ToElement,
	#category : #MooflodFilledSquareWidget
}

{ #category : #initialization }
MfFillingLineElement >> initialize [

	super initialize.
	self size: 200 @ 0.
	self geometry: BlRectangleGeometry new.
	self background: Color black.
	self constraintsDo: [ :e |
		e frame vertical alignBottom.
		e frame horizontal alignCenter ].
	self border: (BlBorder paint: Color black width: 1)
]
