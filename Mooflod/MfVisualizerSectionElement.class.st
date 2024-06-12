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

{ #category : 'as yet unclassified' }
MfVisualizerSectionElement >> added [ 
^added
]

{ #category : 'as yet unclassified' }
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
