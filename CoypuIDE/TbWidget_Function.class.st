Class {
	#name : 'TbWidget_Function',
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
TbWidget_Function class >> Example [ 
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

e1:=TbWidget_Function new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'setting' }
TbWidget_Function >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryVeryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'setting' }
TbWidget_Function >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryVeryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}. 
]

{ #category : 'setting' }
TbWidget_Function >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'setting' }
TbWidget_Function >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'accessing' }
TbWidget_Function >> indicator [
	^indicator.
]

{ #category : 'setting' }
TbWidget_Function >> indicator: aBlock [
	indicator:= aBlock.
]

{ #category : 'initialization' }
TbWidget_Function >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'initialization' }
TbWidget_Function >> initializeEvents [

	switch
		childrenDo: [ :i|   
				i addEventHandler: (BlEventHandler
				 	on: BlMouseDownEvent
				 	do: [ :anEvent |
						self toggleValue.
						self indicator toggle.
					]).
				i addEventHandler: (BlEventHandler
				 	on: BlMouseUpEvent
				 	do: [ :anEvent |
						self toggleValue.
						self indicator toggle.
					]).
				
	].
		
	
]

{ #category : 'initialization' }
TbWidget_Function >> initializeLayout [
	|label l1 l2 l3 bg|
	
	self border: (BlBorder paint: (Color gray) width: 2).
	self padding:(BlInsets top:10 right:10  bottom:30  left:10 ).
	l1 := BlTextElement new.
	l1 text: (self configuredString: 'FUNCTION' size: 18);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop.
		].
	l1 transformDo: [ :t|
		t translateBy:0@ 12. 
		].
	
	l2 := BlTextElement new.
	l2 text: (self configuredString: 'NORMAL' size: 14);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter.
		].
	l2 transformDo: [ :t|
		t translateBy:5@ -34. 
		].
	
	l3 := BlTextElement new.
	l3 text: (self configuredString: 'MODE' size: 14);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter.
		].
	l3 transformDo: [ :t|
		t translateBy:-5@ -20. 
		].


	
	
	label := BlTextElement new.
	label text: (self configuredStringDark: 'BAR' size:16).
	label constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
		].
	label transformDo: [ :t|
		t translateBy:15@ -25. 
		].
	
	bg:= BlElement new
		geometry: BlRectangleGeometry new;
		size:45@25;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
		];
	 	transformDo: [ :t|
		t translateBy:5@ -17. 
		].
	
	self switch: (TbSwitch new).
	switch constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
				];
		transformDo: [ :t|
			t translateBy:10@ 0. 
		].
	self indicator: (TbLED new).
	indicator constraintsDo: [ :c |
					c frame horizontal alignRight.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:0@ 0. 
		].
	
	
	
	self addChildren: {l1. l2. l3. bg. label.self indicator. self switch}.
	
]

{ #category : 'initialization' }
TbWidget_Function >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbWidget_Function >> initializeWidgetSize [
	widgetSize:= 160@200.
]

{ #category : 'setting' }
TbWidget_Function >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'accessing' }
TbWidget_Function >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'accessing' }
TbWidget_Function >> switch [
	^switch
]

{ #category : 'setting' }
TbWidget_Function >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'api - operations' }
TbWidget_Function >> toggle [

	self switch toggle.
	self indicator toggle.
	self toggleValue.
	
]

{ #category : 'api - operations' }
TbWidget_Function >> toggleValue [
	"Toggles the value of widget (not the value of inner elements)"
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'accessing' }
TbWidget_Function >> value [
	^value
]

{ #category : 'setting' }
TbWidget_Function >> value: anInteger [
	value:= anInteger.
]
