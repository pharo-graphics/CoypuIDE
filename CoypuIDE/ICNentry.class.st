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
		'callback',
		'maxValue',
		'minValue'
	],
	#classInstVars : [
		'aNumber'
	],
	#category : 'CoypuIDE-numericalEntry',
	#package : 'CoypuIDE',
	#tag : 'numericalEntry'
}

{ #category : 'instance creation' }
ICNentry class >> fromDictionary: aDictionary forDsp: aDsp [

	(aDictionary at: #label) traceCr.
	^ (self new
		   label: (aDictionary at: #shortname);
		   minValue: (aDictionary at: #min);
		   maxValue: (aDictionary at: #max);
		   callback: [ :i |
			   aDsp setValue: i parameter: (aDictionary at: #shortname) ])
		  setValue: (aDictionary at: #init);
		  "stepValue: (aDictionary at: #step);"yourself
]

{ #category : 'visual properties' }
ICNentry >> backgroundPaint [

^ Color black
]

{ #category : 'accessing' }
ICNentry >> borderPaint [

^ Color cyan
]

{ #category : 'accessing' }
ICNentry >> callback [

	^ callback ifNil: [  callback :=  [ :v | Transcript show: v ]]
]

{ #category : 'accessing' }
ICNentry >> callback: aBlock [

callback := aBlock.
]

{ #category : 'evaluating' }
ICNentry >> configuredString: aString [

	^ aString asRopedText attributes:
		  { (BlTextForegroundAttribute paint: self borderPaint ) }
]

{ #category : 'initialization' }
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

	self setValue: (self value - 1 max: minValue )
]

{ #category : 'buttons' }
ICNentry >> increaseInput [

	self setValue: ((self value + 1) min: self maxValue).
]

{ #category : 'initialization' }
ICNentry >> initialize [

	super initialize.
	self size: self inputExtent.
	self background: self backgroundPaint.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 10).

	self border: (BlBorder paint: self borderPaint width: 4).
	self initializelabel: 'Input'.
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
	self setValue: aValue.
	self addChild: inputValue
]

{ #category : 'initialization' }
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
	rect addEventHandlerOn: BlMouseDownEvent do: [ :e |
		self decreaseInput.
		self callback value: self value ].
	rect addChild: plus.
	self addChild: rect
]

{ #category : 'initialization' }
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
		do: [ :e | self increaseInput. self callback value: self value  ].
	rect addChild: plus.
	self addChild: rect
]

{ #category : 'accessing' }
ICNentry >> initializelabel: aString [

	inputLabel := BlTextElement new.
	inputLabel text: (self configuredString: aString).
	inputLabel text fontSize: 20.
	inputLabel constraintsDo: [ :c | c frame horizontal alignCenter ].
	inputLabel transformDo: [ :t | t translateBy: 0 @ 10 ].

	self addChild: inputLabel
]

{ #category : 'accessing' }
ICNentry >> inputExtent [

	^ 200 @ 80
]

{ #category : 'accessing' }
ICNentry >> inputText [

	^ inputLabel text asString 
]

{ #category : 'accessing' }
ICNentry >> label: aString [

	
	inputLabel text: (self configuredString: aString).
	inputLabel text fontSize: 20.
	inputLabel constraintsDo: [ :c | c frame horizontal alignCenter ].
	inputLabel transformDo: [ :t | t translateBy: 0 @ 10 ].


]

{ #category : 'accessing' }
ICNentry >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICNentry >> maxValue: aNumber [


	maxValue := aNumber
]

{ #category : 'accessing' }
ICNentry >> minValue [ 
^ minValue
]

{ #category : 'accessing' }
ICNentry >> minValue: aNumber [

	minValue := aNumber
]

{ #category : 'buttons' }
ICNentry >> setValue: aValue [

inputValue text: ( self configuredString: aValue asString).
inputValue text fontSize: 30.
value := aValue
]

{ #category : 'buttons' }
ICNentry >> value [ 

^ inputValue text asString asNumber
]
