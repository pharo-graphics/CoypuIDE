Class {
	#name : 'TbLabel_BassLine',
	#superclass : 'TbLabel',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'initialization' }
TbLabel_BassLine >> initializeLabel [
	| label|
	self fontColor: Color veryVeryDarkGray.

				
	label := BlTextElement new;
				text: (self configuredString: 'Bass Line' size:60).
				
	label constraintsDo:[:c | c frame horizontal alignCenter. c frame vertical alignCenter].
		
	
	self addChildren: { label}.
	
	
]

{ #category : 'initialization' }
TbLabel_BassLine >> initializeSize [
	self widgetSize: 300@80.
]
