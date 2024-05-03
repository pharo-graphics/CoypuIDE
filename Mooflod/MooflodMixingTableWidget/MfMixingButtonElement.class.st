Class {
	#name : #MfMixingButtonElement,
	#superclass : #ToElement,
	#category : #MooflodMixingTableWidget
}

{ #category : #initialization }
MfMixingButtonElement >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self background: Color lightBlue.

]
