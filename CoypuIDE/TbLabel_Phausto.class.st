Class {
	#name : 'TbLabel_Phausto',
	#superclass : 'TbLabel',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'initialization' }
TbLabel_Phausto >> initializeLabel [

	| label |
	self fontColor: Color veryVeryDarkGray.
	BlTextElement new.
	label := BlTextElement text:
		        (self configuredString: 'Phausto' size: 60).
	label constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	self addChildren: { label }
]

{ #category : 'initialization' }
TbLabel_Phausto >> initializeSize [

	self widgetSize: 300 @ 80
]
