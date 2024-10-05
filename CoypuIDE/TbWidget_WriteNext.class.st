Class {
	#name : 'TbWidget_WriteNext',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'switch',
		'indicator',
		'value'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TbWidget_WriteNext class >> Example [ 
	<script>
	| container e1 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 10;
		cellSpacing: 10
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 249 g:239  b:224  range:255).
		"background: Color white."

e1:=TbWidget_WriteNext new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'as yet unclassified' }
TbWidget_WriteNext class >> toggleable [
	|ele|
	ele:= self new.
	ele reInitializeEvents.
	^ ele.
]

{ #category : 'evaluating' }
TbWidget_WriteNext >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'evaluating' }
TbWidget_WriteNext >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}. 
]

{ #category : 'initialization' }
TbWidget_WriteNext >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'initialization' }
TbWidget_WriteNext >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'initialization' }
TbWidget_WriteNext >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'as yet unclassified' }
TbWidget_WriteNext >> initializeEvents [

	switch
		childrenDo: [ :i|   
				i addEventHandler: (BlEventHandler
				 	on: BlMouseDownEvent
				 	do: [ :anEvent |
						self toggle.
					]).
	].
		
	
]

{ #category : 'initialization' }
TbWidget_WriteNext >> initializeLayout [
	|label l1 l2|
	
	self border: (BlBorder paint: (Color gray) width: 2).
	
	l1 := BlTextElement new.
	l1 text: (self configuredString: 'D. S. ' size: 16).
	l1 border: (BlBorder paint: (Color gray) width: 2);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		].
	l2 := BlTextElement new.
	l2 text: (self configuredString: 'WRITE / NEXT ' size: 16).
	l2 border: (BlBorder paint: (Color gray) width: 2);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
		].
	l2 transformDo: [ :t|
		t translateBy:0@ -24. 
		].
	
	
	label := BlTextElement new.
	label text: (self configuredString: 'TAP' size:16).
	label constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
		].
	label transformDo: [ :t|
		t translateBy:0@ -6. 
		].
	
	self switch: (TbHorizontalSwitch2 new).
	switch constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				];
		transformDo: [ :t|
			t translateBy:0@ -15. 
		].
	
	
	
	self addChildren: {l1. l2. label. self switch}.
	
]

{ #category : 'initialization' }
TbWidget_WriteNext >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbWidget_WriteNext >> initializeWidgetSize [
	widgetSize:= 160@180.
]

{ #category : 'initialization' }
TbWidget_WriteNext >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'as yet unclassified' }
TbWidget_WriteNext >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'as yet unclassified' }
TbWidget_WriteNext >> switch [
	^switch
]

{ #category : 'as yet unclassified' }
TbWidget_WriteNext >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'initialization' }
TbWidget_WriteNext >> toggle [
	self switch toggle.
	self toggleValue.
]

{ #category : 'initialization' }
TbWidget_WriteNext >> toggleValue [
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'initialization' }
TbWidget_WriteNext >> value [
	^value
]

{ #category : 'initialization' }
TbWidget_WriteNext >> value: anInteger [
	value:= anInteger.
]
