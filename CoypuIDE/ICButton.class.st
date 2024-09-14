"
I am an ICButton. I need a label and a callbackDown for MouseDown events and a callBackUp for MouseUp events
"
Class {
	#name : 'ICButton',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'button',
		'isOn',
		'value',
		'callbackDown',
		'callBackUp',
		'callback'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICButton class >> allButtonExamples [
	<script>
	| container e1 e2 e3 e4 e5 e6 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 0
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: Color darkGray.

e1:= ICIndicatorButton new.
e2:= ICOnOffButton new.
e3:= ICLabelButton label:'MONO'.

	"e1 value.
	e2 value.
	e3 value."
e4:= ICIndicatorButton new.
e5:= ICOnOffButton new.
e6:= ICLabelButton label:'STEREO'.
	e4 toggle.
	e5 toggle.
	e6 setValue:1.
	
	"e4 value.
	e5 value.
	e6 value."
container addChildren: { e1. e4. e2. e5 . e3. e6}.
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

{ #category : 'accessing' }
ICButton >> callBackUp [

	^ callBackUp
]

{ #category : 'accessing' }
ICButton >> callBackUp: aBlock [

	callBackUp := aBlock
]

{ #category : 'accessing' }
ICButton >> callback [

	^ callback
]

{ #category : 'accessing' }
ICButton >> callback: aBlock [

	callback := aBlock
]

{ #category : 'accessing' }
ICButton >> callbackDown [

	^ callbackDown
]

{ #category : 'accessing' }
ICButton >> callbackDown: aBlock [

	callbackDown := aBlock
]

{ #category : 'evaluating' }
ICButton >> initialize [

	super initialize.
	self value: 0.
	self initializeWidgetSize.
	self initializeWidget.
	self initializeButton.
	self initializeEvents
]

{ #category : 'as yet unclassified' }
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

	'sto inizializzando eventi bottino' traceCr.
	button
		addEventHandler: (BlEventHandler
				 on: BlMouseDownEvent
				 do: [ :anEvent |
					 self toggle.
					 self callback value: 1
					]);
		addEventHandler: (BlEventHandler
				 on: BlMouseUpEvent
				 do: [ :anEvent |
					 self toggle.
					 self callback value: 0
					])
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

{ #category : 'accessing' }
ICButton >> isOn [

	^ isOn
]

{ #category : 'accessing' }
ICButton >> isOn: anObject [

	isOn := anObject
]

{ #category : 'evaluating' }
ICButton >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
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

{ #category : 'accessing' }
ICButton >> widgetSize [

	^ widgetSize
]

{ #category : 'evaluating' }
ICButton >> widgetSize: aSize [
	widgetSize:= aSize.
]
