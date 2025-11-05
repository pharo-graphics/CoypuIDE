"
I am a basic Container with default grid layout black background to which you can add your own widgets
"
Class {
	#name : 'ICContainer',
	#superclass : 'BlSpace',
	#instVars : [
		'innerContainer'
	],
	#category : 'CoypuIDE-Container',
	#package : 'CoypuIDE',
	#tag : 'Container'
}

{ #category : 'adding' }
ICContainer >> addChild: aBlElement [

	self innerContainer addChild: aBlElement
]

{ #category : 'initialization' }
ICContainer >> initialize [

	super initialize.
	self extent: 80 @ 80.
	innerContainer := BlElement new
		                  border: (BlBorder paint: Color black width: 1);
		                  background: (Color black alpha: 0.2);
		                  layout: (BlGridLayout new
				                   columnCount: 8;
				                   cellSpacing: 0);
		                  addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt | self extent: evt target extent ];
		                  constraintsDo: [ :c |
				                  c horizontal fitContent.
				                  c vertical fitContent ];
		                  yourself.
	self root addChild: innerContainer
]

{ #category : 'accessing' }
ICContainer >> innerContainer [

	^ innerContainer
]

{ #category : 'accessing' }
ICContainer >> innerContainer: anObject [

	innerContainer := anObject
]

{ #category : 'column handling' }
ICContainer >> numberOfColumns: anInteger [

self innerContainer layout:   (BlGridLayout new
				                   columnCount: anInteger ;
				                   cellSpacing: 0).
]
