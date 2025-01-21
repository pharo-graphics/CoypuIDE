"
Simple BlTextElement that display a chaning values (designed to be used with Phausto PhHBarGraph)
"
Class {
	#name : 'ICValueDisplay',
	#superclass : 'BlElement',
	#instVars : [
		'labelText',
		'valueText'
	],
	#category : 'CoypuIDE-numericalEntry',
	#package : 'CoypuIDE',
	#tag : 'numericalEntry'
}

{ #category : 'evaluating' }
ICValueDisplay >> configuredString: aString [

	^ aString asRopedText attributes:
		  { (BlTextForegroundAttribute paint: self textPaint) }
]

{ #category : 'initialization' }
ICValueDisplay >> initialize [

	super initialize.
	self background: Color black.
	self layout: BlFrameLayout new.

	self size: self widgetSize.
	self constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self initializeValueText.
	self initializeLabel: 'Value'.

	self addChild: valueText
]

{ #category : 'accessing' }
ICValueDisplay >> initializeLabel: aString [

	labelText := BlTextElement new.
	labelText text: (self configuredString: aString).
	labelText text fontSize: 20.
	labelText constraintsDo: [ :c | c frame horizontal alignCenter ].


	self addChild: labelText
]

{ #category : 'initialization' }
ICValueDisplay >> initializeValueText [

	valueText := BlTextElement new.
	valueText text: (self configuredString: '0').
	valueText text fontSize: 80.
	valueText layout: BlFrameLayout new.

	valueText constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	valueText transformDo: [ :t | t translateBy: 0@6 ]
]

{ #category : 'accessing' }
ICValueDisplay >> label: aString [

	labelText text: (self configuredString: aString).
   labelText text fontSize: 20.
]

{ #category : 'as yet unclassified' }
ICValueDisplay >> textPaint [

^ Color red
]

{ #category : 'accessing' }
ICValueDisplay >> value: aNumber [

	valueText text: (self configuredString: aNumber asString).
	valueText text fontSize: 80
]

{ #category : 'as yet unclassified' }
ICValueDisplay >> widgetSize [

	^ 200 @ 80
]
