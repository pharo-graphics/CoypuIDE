"
A widget with a pair of buttons that increment or  decrement a value.
"
Class {
	#name : 'ICNentry',
	#superclass : 'BlElement',
	#instVars : [
		'plus',
		'minus',
		'inputValue',
		'value',
		'inputLabel',
		'callback'
	],
	#category : 'CoypuIDE-numericalEntry',
	#package : 'CoypuIDE',
	#tag : 'numericalEntry'
}

{ #category : 'visual properties' }
ICNentry >> backgroundPaint [

^ Color black
]

{ #category : 'accessing' }
ICNentry >> borderPaint [

^ Color green
]

{ #category : 'accessing' }
ICNentry >> callback: aBlock [

callback := aBlock.
]

{ #category : 'buttons' }
ICNentry >> changeValueTo: aValue [

inputValue text: ( self configuredString: aValue asString).
inputValue text fontSize: 30.
value := aValue
]

{ #category : 'evaluating' }
ICNentry >> configuredString: aString [

	^ aString asRopedText attributes:
		  { (BlTextForegroundAttribute paint: self borderPaint ) }
]

{ #category : 'as yet unclassified' }
ICNentry >> createRect [

	| rect |
	rect := BlElement new
		        background: Color gray;
		        border: (BlBorder paint: self borderPaint width: 2);
		        size: 50 @ 28;
		        layout: BlFrameLayout new;
		        margin: (BlInsets all: 8);
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 180).

	^ rect
]

{ #category : 'buttons' }
ICNentry >> decreaseInput [

	self changeValueTo: value - 1
]

{ #category : 'buttons' }
ICNentry >> increaseInput [ 

self changeValueTo: value + 1.
]

{ #category : 'initialization' }
ICNentry >> initialize [

	super initialize.
	self size: self inputExtent.
	self background: self backgroundPaint.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 10).

	self border: (BlBorder paint: self borderPaint width: 4).
	"self label: 'Input'."
	self initializePlusButton.
	self initializeMinusButton.
	self initializeInputValue: 0.
	self layout: BlFrameLayout new
]

{ #category : 'initialization' }
ICNentry >> initializeInputValue: aValue [

	inputValue := BlTextElement new.
	inputValue constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	inputValue transformDo: [ :t | t translateBy: 0 @ 10 ].
	self changeValueTo: aValue.
	self addChild: inputValue
]

{ #category : 'as yet unclassified' }
ICNentry >> initializeMinusButton [

	| rect |
	rect := self createRect.
	rect constraintsDo: [ :c | c frame horizontal alignRight ].
	rect transformDo: [ :t | t translateBy: 0 @ 34 ].

	plus := BlTextElement new text: (self configuredString: '-').
	plus text fontSize: 30.
	plus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	rect
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self increaseInput ].
	rect addChild: plus.
	self addChild: rect
]

{ #category : 'as yet unclassified' }
ICNentry >> initializePlusButton [

	| rect |
	rect := self createRect.
	rect constraintsDo: [ :c | c frame horizontal alignRight ].
	
	plus := BlTextElement new text: (self configuredString: '+').
	plus text fontSize: 30.
	plus constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	rect
		addEventHandlerOn: BlMouseDownEvent
		do: [ :e | self increaseInput ].
	rect addChild: plus.
	self addChild: rect
]

{ #category : 'accessing' }
ICNentry >> inputExtent [

	^ 200 @ 80
]

{ #category : 'accessing' }
ICNentry >> label: aString [

	inputLabel := BlTextElement new.
	inputLabel text: (self configuredString: aString).
	inputLabel text fontSize: 20.
	inputLabel constraintsDo: [ :c | c frame horizontal alignCenter ].
	inputLabel transformDo: [ :t | t translateBy: 0 @ 10 ].

	self addChild: inputLabel
]
