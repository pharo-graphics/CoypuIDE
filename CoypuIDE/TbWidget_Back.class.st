Class {
	#name : 'TbWidget_Back',
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
TbWidget_Back class >> AllWidgetExamples [
	<script>
	| container e1 e2 e3 e4 e5 e6 e7|
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 4;
		cellSpacing: 10
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 249 g:239  b:224  range:255).
		"background: Color white."

e1:=TbWidget_Back new.

e2:=TbWidget_WriteNext new.
e3:=TbWidget_PatternClear new.
e4:=TbWidget_RunStop new.
e5:=TbWidget_PitchMode new.
e6:=TbWidget_Function new.
e7:=TbWidget_TimeMode new.



container addChildren: { e1. e3. e5. e7. e2. e4. e6}.
container openInSpace.
	
]

{ #category : 'as yet unclassified' }
TbWidget_Back class >> Example [ 
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

e1:=TbWidget_Back new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'evaluating' }
TbWidget_Back >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'evaluating' }
TbWidget_Back >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}. 
]

{ #category : 'initialization' }
TbWidget_Back >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'initialization' }
TbWidget_Back >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'initialization' }
TbWidget_Back >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'as yet unclassified' }
TbWidget_Back >> initializeEvents [

	switch
		childrenDo: [ :i|   
				i addEventHandler: (BlEventHandler
				 	on: BlMouseDownEvent
				 	do: [ :anEvent |
						self toggleValue.
					]).
				i addEventHandler: (BlEventHandler
				 	on: BlMouseUpEvent
				 	do: [ :anEvent |
						self toggleValue.
					]).
				
	].
		
	
]

{ #category : 'initialization' }
TbWidget_Back >> initializeLayout [
	|label l1|
	
	self border: (BlBorder paint: (Color gray) width: 2).
	
	l1 := BlTextElement new.
	l1 text: (self configuredString: '%' size: 16).
	l1 border: (BlBorder paint: (Color gray) width: 2);
	 	padding: (BlInsets all:5);
		constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		].
	
	label := BlTextElement new.
	label text: (self configuredString: 'BACK' ).
	label constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
		].
	label transformDo: [ :t|
		t translateBy:0@ -10. 
		].
	self switch: (TbHorizontalSwitch new).
	switch constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
	].	
	
	self addChildren: {l1. label. self switch}.
	
]

{ #category : 'initialization' }
TbWidget_Back >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbWidget_Back >> initializeWidgetSize [
	widgetSize:= 160@120.
]

{ #category : 'initialization' }
TbWidget_Back >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'as yet unclassified' }
TbWidget_Back >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'as yet unclassified' }
TbWidget_Back >> switch [
	^switch
]

{ #category : 'as yet unclassified' }
TbWidget_Back >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'initialization' }
TbWidget_Back >> toggle [
	self switch toggle.
	self toggleValue.
]

{ #category : 'initialization' }
TbWidget_Back >> toggleValue [
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'initialization' }
TbWidget_Back >> value [
	^value
]

{ #category : 'initialization' }
TbWidget_Back >> value: anInteger [
	value:= anInteger.
]
