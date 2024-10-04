Class {
	#name : 'TbBackWidget',
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
TbBackWidget class >> Example [ 
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

e1:=TbBackWidget new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'as yet unclassified' }
TbBackWidget class >> toggleable [
	|ele|
	ele:= self new.
	ele reInitializeEvents.
	^ ele.
]

{ #category : 'evaluating' }
TbBackWidget >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'initialization' }
TbBackWidget >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'initialization' }
TbBackWidget >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'as yet unclassified' }
TbBackWidget >> initializeEvents [

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
TbBackWidget >> initializeLayout [
	|label|
	
	self border: (BlBorder paint: (Color gray) width: 2).
	label := BlTextElement new.
	label text: (self configuredString: 'BACK' ).
	label constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
		].
	label transformDo: [ :t|
		t translateBy:0@ -16. 
		].
	self switch: (TbHorizontalSwitch new).
	switch constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
	].	
	
	
	self addChildren: {label. self switch}.
	
]

{ #category : 'initialization' }
TbBackWidget >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbBackWidget >> initializeWidgetSize [
	widgetSize:= 160@120.
]

{ #category : 'initialization' }
TbBackWidget >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'as yet unclassified' }
TbBackWidget >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'as yet unclassified' }
TbBackWidget >> switch [
	^switch
]

{ #category : 'as yet unclassified' }
TbBackWidget >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'initialization' }
TbBackWidget >> toggle [
	self switch toggle.
	self toggleValue.
]

{ #category : 'initialization' }
TbBackWidget >> toggleValue [
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'initialization' }
TbBackWidget >> value [
	^value
]

{ #category : 'initialization' }
TbBackWidget >> value: anInteger [
	value:= anInteger.
]
