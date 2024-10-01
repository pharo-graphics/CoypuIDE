Class {
	#name : 'TbLabelledLED',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'indicator',
		'inputLabel',
		'value',
		'led',
		'label',
		'inputText'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TbLabelledLED class >> LabelledLEDexample [ 
	<script>
	| container e1 e2 e3 e4 e5 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 2
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		"background: Color white ."
		background: (Color r: 249 g:239  b:224  range:255).

e1:=TbLabelledLED label:'CV'.
e1 toggle.
e2:=TbLabelledLED label:'GATE'.
e3:=TbLabelledLED label:'HEADPHONE'.
e4:=TbLabelledLED label:'OUTPUT'.
e5:=TbLabelledLED label:'DC 9V'.


container addChildren: { e1. e2. e3. e4. e5}.
container openInSpace.
	
]

{ #category : 'accessing' }
TbLabelledLED class >> label: aString [ 
	|e|
	e:= self new inputText: aString.
	e initializeLabel.
	^ e.
]

{ #category : 'accessing' }
TbLabelledLED >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color black) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'accessing' }
TbLabelledLED >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'initialization' }
TbLabelledLED >> initialize [

	super initialize.
	self value: 0.
	self inputText: 'NONE'.
	self background: (Color gray alpha:0.0).
	self padding: (BlInsets  top:0 left:5  bottom:5  right:5 ).
	self initializeLayout.
	self initializeWidget.

	
]

{ #category : 'accessing' }
TbLabelledLED >> initializeLabel [ 
	inputLabel := BlTextElement new.
	inputLabel text: (self configuredString: inputText ).
	inputLabel constraintsDo: [ :c | 
		c grid horizontal alignCenter.
		c grid vertical alignTop.
		].
	inputLabel zIndex: 200.
	self label: inputLabel.
	self addChildren: { label }.

]

{ #category : 'initialization' }
TbLabelledLED >> initializeLayout [
	self layout: (BlGridLayout new
		rowCount: 2;
		columnCount: 1;
		cellSpacing: 0).
	self constraintsDo: [ :c |
      c horizontal fitContent.
		c vertical fitContent.
	].

	
]

{ #category : 'initialization' }
TbLabelledLED >> initializeWidget [

	led:= TbTriangleLED new.
	led constraintsDo: [ :c | c grid horizontal alignCenter.].	
	self addChildren:{led}. 
	
]

{ #category : 'accessing' }
TbLabelledLED >> inputText [ 
	^inputText.
]

{ #category : 'accessing' }
TbLabelledLED >> inputText: aString [
	inputText:= aString.
]

{ #category : 'accessing' }
TbLabelledLED >> label [
	^ label.
]

{ #category : 'accessing' }
TbLabelledLED >> label: aBlock [
	label:= aBlock.
]

{ #category : 'evaluating' }
TbLabelledLED >> led [
	^led.
]

{ #category : 'initialization' }
TbLabelledLED >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
		].
]

{ #category : 'evaluating' }
TbLabelledLED >> toggle [
	self led toggle.
	self toggleValue.
]

{ #category : 'initialization' }
TbLabelledLED >> toggleValue [
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'accessing' }
TbLabelledLED >> value [
	^value.
]

{ #category : 'accessing' }
TbLabelledLED >> value: anInteger [
	value:= anInteger.
]
