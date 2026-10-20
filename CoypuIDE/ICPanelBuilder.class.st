"
I build a panel from a collection of ICParameters: one widget per parameter, sorted by label, in a grid of columnCount columns. I own the arrangement only; the widget factory decides the toolkit, the widgets and the container.

buildUI, buildUIColumn: and buildUIForLevels are three configurations of me.

Pattern: Builder
"
Class {
	#name : 'ICPanelBuilder',
	#superclass : 'Object',
	#instVars : [
		'parameters',
		'widgetFactory',
		'columnCount'
	],
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'as yet unclassified' }
ICPanelBuilder class >> parameters: aCollection factory: aWidgetFactory columns: anInteger [
	"aCollection: ICParameters. aWidgetFactory: an ICWidgetFactory."

	^ self new
		initializeParameters: aCollection factory: aWidgetFactory columns: anInteger;
		yourself

]

{ #category : 'building' }
ICPanelBuilder >> build [
	"Arrangement only. Toolkit and colours come from the factory."

	^ widgetFactory newPanel
		layout: self gridLayout;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: (self orderedParameters collect: [ :each | widgetFactory widgetFor: each ]);
		yourself
]

{ #category : 'building' }
ICPanelBuilder >> gridLayout [

	^ BlGridLayout new
		columnCount: columnCount;
		cellSpacing: 0;
		yourself
]

{ #category : 'initialization' }
ICPanelBuilder >> initializeParameters: aCollection factory: aWidgetFactory columns: anInteger [

	parameters := aCollection.
	widgetFactory := aWidgetFactory.
	columnCount := anInteger
]

{ #category : 'building' }
ICPanelBuilder >> orderedParameters [
	"By label, case-insensitive, as CoypuIDE always showed them."

	^ parameters sorted: [ :a :b | a label asLowercase < b label asLowercase ]
]
