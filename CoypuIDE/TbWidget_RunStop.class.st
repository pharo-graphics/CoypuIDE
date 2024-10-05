Class {
	#name : 'TbWidget_RunStop',
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
TbWidget_RunStop class >> Example [ 
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

e1:=TbWidget_RunStop new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'as yet unclassified' }
TbWidget_RunStop class >> toggleable [
	|ele|
	ele:= self new.
	ele reInitializeEvents.
	^ ele.
]

{ #category : 'evaluating' }
TbWidget_RunStop >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'evaluating' }
TbWidget_RunStop >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}. 
]

{ #category : 'initialization' }
TbWidget_RunStop >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'initialization' }
TbWidget_RunStop >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'accessing' }
TbWidget_RunStop >> indicator [
	^indicator.
]

{ #category : 'accessing' }
TbWidget_RunStop >> indicator: aBlock [
	indicator:= aBlock.
]

{ #category : 'initialization' }
TbWidget_RunStop >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'as yet unclassified' }
TbWidget_RunStop >> initializeEvents [

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
TbWidget_RunStop >> initializeLayout [
	|label l1 l2|
	
	self border: (BlBorder paint: (Color gray) width: 2).
	
	l1 := BlTextElement new.
	l1 text: (self configuredString: 'RUN ' size: 14);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop.
		].
	l1 transformDo: [ :t|
		t translateBy:22@ 10. 
		].
	l2 := BlTextElement new.
	l2 text: (self configuredString: 'BATTERY' size: 14);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop.
		].
	l2 transformDo: [ :t|
		t translateBy:5@ 10. 
		].

	
	
	label := BlTextElement new.
	label text: (self configuredString: 'RUN / STOP' size:16).
	label constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
		].
	label transformDo: [ :t|
		t translateBy:0@ -30. 
		].
	
	self switch: (TbHorizontalSwitch2 new).
	switch constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				];
		transformDo: [ :t|
			t translateBy:0@ 0. 
		].
	self indicator: (TbLED new).
	indicator constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:0@ 0. 
		].
	
	
	
	self addChildren: {l1. l2. label. self switch. self indicator}.
	
]

{ #category : 'initialization' }
TbWidget_RunStop >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbWidget_RunStop >> initializeWidgetSize [
	widgetSize:= 160@180.
]

{ #category : 'initialization' }
TbWidget_RunStop >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'as yet unclassified' }
TbWidget_RunStop >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'as yet unclassified' }
TbWidget_RunStop >> switch [
	^switch
]

{ #category : 'as yet unclassified' }
TbWidget_RunStop >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'initialization' }
TbWidget_RunStop >> toggle [
	self indicator toggle.
	self switch toggle.

	self toggleValue.
]

{ #category : 'initialization' }
TbWidget_RunStop >> toggleValue [
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'initialization' }
TbWidget_RunStop >> value [
	^value
]

{ #category : 'initialization' }
TbWidget_RunStop >> value: anInteger [
	value:= anInteger.
]
