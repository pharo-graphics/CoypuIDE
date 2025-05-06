"
A simple container for Knobs
"
Class {
	#name : 'ICKnobContainer',
	#superclass : 'BlElement',
	#category : 'CoypuIDE-Containers',
	#package : 'CoypuIDE',
	#tag : 'Containers'
}

{ #category : 'as yet unclassified' }
ICKnobContainer class >> columns: anInteger background: aColor [

	^ self new
		  geometry: BlRectangleGeometry new;
		  layout: (BlGridLayout new
				   columnCount: anInteger;
				   cellSpacing: 0);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical fitContent
			  "c vertical matchParent " ];
		  background: aColor
]
