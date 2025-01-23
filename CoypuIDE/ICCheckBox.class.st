"
A simple checkbox, I have a bhaviour similar to a toggle button, but click is on the box, not on the label
"
Class {
	#name : 'ICCheckBox',
	#superclass : 'ICLabelButton',
	#instVars : [
		'clickBox',
		'clickSymbol'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'evaluating' }
ICCheckBox >> clickBox [

^ clickBox
]

{ #category : 'evaluating' }
ICCheckBox >> clickBox: aBlElement [

clickBox := aBlElement 
]

{ #category : 'initialization' }
ICCheckBox >> initializeClickBox [

	self clickBox: (BlElement new
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
			 background: Color white;
			 layout: BlFrameLayout new;
			 size: 30 @ 32;
			 border: (BlBorder paint: Color darkGray width: 4)).
	self initializeClickSymbol.
	self addChild: clickBox
]

{ #category : 'as yet unclassified' }
ICCheckBox >> initializeClickSymbol [

	| check |
	check := (Unicode value: 16r2713) asRopedText attributes: {
			         (BlTextForegroundAttribute paint: Color red).
			         BlFontWeightAttribute bold.
			         (BlFontSizeAttribute size: 30) }.
	clickSymbol := BlTextElement new text: check.

	clickSymbol constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ]
]

{ #category : 'evaluating' }
ICCheckBox >> initializeEvents [

	clickBox addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent |
				 self toggle.
				 self callback value: self value ]).

	
]

{ #category : 'evaluating' }
ICCheckBox >> initializeWidget [

	self size: self widgetSize.
	self background: self backColor.
	self layout: BlLinearLayout horizontal .
	self padding: (BlInsets all: 10)
]

{ #category : 'evaluating' }
ICCheckBox >> toggle [

	self toggleValue.
	self value = 0
		ifTrue: [ clickBox removeChild: clickSymbol ]
		ifFalse: [ clickBox addChild: clickSymbol ]
]
