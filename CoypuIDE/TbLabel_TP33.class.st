Class {
	#name : 'TbLabel_TP33',
	#superclass : 'TbLabel',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'initialization' }
TbLabel_TP33 >> initializeLabel [

	| label label2 l|
	self fontColor: Color veryVeryDarkGray.
	self padding: (BlInsets top: 20 right:10  bottom:10  left:10 ).
	BlTextElement new.
	label := BlTextElement text:
		        (self configuredString: 'TP-33' size: 50).
	label constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	
	l:= BlElement new.
	l geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		size: 380@5;
		background: self fontColor;
		 constraintsDo: [ :c |
		c frame horizontal alignCenter .
		c frame vertical alignCenter ];
		transformDo:[:t |t translateBy: 0@5].
	
	label2 := BlTextElement text:
		        (self configuredString: 'Computer  Controlled' size: 35).
	label2 constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom].
	self addChildren: { label. l. label2}
]

{ #category : 'initialization' }
TbLabel_TP33 >> initializeSize [

	self widgetSize: 340 @ 130
]
