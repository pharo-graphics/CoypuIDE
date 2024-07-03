Class {
	#name : 'ICButton',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'button',
		'isOn',
		'value'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICButton class >> allButtonExamples [
	<script>
	| container e1 e2 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 4;
		cellSpacing: 0
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: Color darkGray.

	e1:= ICButton new.
	e2:= ICIndicatorButton new.

container addChildren: { e1. e2 }.
container openInSpace.
]

{ #category : 'evaluating' }
ICButton >> backColor [
	^ (Color veryVeryDarkGray alpha:1.0)

]

{ #category : 'evaluating' }
ICButton >> button [
	^ button.
]

{ #category : 'evaluating' }
ICButton >> button: anElement [
	button:= anElement.
]

{ #category : 'evaluating' }
ICButton >> initialize [
	super initialize.
	self value: 0.
	self initializeWidgetSize.
	self initializeWidget.
	self initializeButton.
	self initializeEvents.
]

{ #category : 'evaluating' }
ICButton >> initializeButton [
	
	self button: (BlElement new
            geometry: BlCircleGeometry new;
				background: Color red;
            size: widgetSize -20 asPoint;
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				]).
	self addChild: self button.
]

{ #category : 'evaluating' }
ICButton >> initializeEvents [
	button addEventHandler: (BlEventHandler
		on: BlMouseDownEvent 
		do: [ :anEvent | self toggle ]).
	
]

{ #category : 'evaluating' }
ICButton >> initializeWidget [
	self size: widgetSize.
	self background: self backColor.
	self layout: BlFrameLayout new.
	self padding: (BlInsets all: 10).


]

{ #category : 'evaluating' }
ICButton >> initializeWidgetSize [
	widgetSize:= 80@80.
]

{ #category : 'evaluating' }
ICButton >> toggle [
	self toggleValue.
	self value = 0 
		ifTrue: [ button background: (Color red alpha:
	1.0) ] 
		ifFalse: [ button background: (Color green alpha:
	1.0)].
]

{ #category : 'evaluating' }
ICButton >> toggleValue [
	self value = 0 
		ifTrue: [ self value: 1 ] 
		ifFalse: [ self value: 0 ].
]

{ #category : 'evaluating' }
ICButton >> value [
	^ value.
]

{ #category : 'evaluating' }
ICButton >> value: aBoolean [
	value:= aBoolean.
]

{ #category : 'evaluating' }
ICButton >> widgetSize: aSize [
	widgetSize:= aSize.
]
