"
I am a basic Container with default grid layout black background to which you can add your own widgets
"
Class {
	#name : 'ICContainer',
	#superclass : 'BlSpace',
	#category : 'CoypuIDE-Container',
	#package : 'CoypuIDE',
	#tag : 'Container'
}

{ #category : 'adding' }
ICContainer >> addChild: aBlElement [
self root addChild: aBlElement .
self extent: self root boundingBox extent.

]

{ #category : 'initialization' }
ICContainer >> initialize [

	super initialize.
	self root
		geometry: BlRectangleGeometry new;
		background: Color black;
		layout: (BlGridLayout new
				 columnCount: 16;
				 cellSpacing: 0);
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ]
]
