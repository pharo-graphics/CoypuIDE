Class {
	#name : 'MfVisualizerSectionElement',
	#superclass : 'ToElement',
	#classVars : [
		'added'
	],
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'boolean' }
MfVisualizerSectionElement >> added [ 
^added
]

{ #category : 'boolean' }
MfVisualizerSectionElement >> added:boolean [

added:= boolean
]

{ #category : 'initialization' }
MfVisualizerSectionElement >> initialize [

	super initialize.
	self geometry: BlRectangleGeometry new.
	self size: 500 @ 200.
	self border: (BlBorder paint: Color white width: 2).
	self layout: BlFrameLayout new
]
