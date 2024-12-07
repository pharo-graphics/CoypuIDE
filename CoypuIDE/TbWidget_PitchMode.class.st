Class {
	#name : 'TbWidget_PitchMode',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'switch',
		'indicator',
		'value',
		'callback'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbWidget_PitchMode class >> Example [ 
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

e1:=TbWidget_PitchMode new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'accessing' }
TbWidget_PitchMode >> callback [

	^ callback
]

{ #category : 'accessing' }
TbWidget_PitchMode >> callback: anObject [

	callback := anObject
]

{ #category : 'setting' }
TbWidget_PitchMode >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryVeryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'setting' }
TbWidget_PitchMode >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryVeryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}. 
]

{ #category : 'setting' }
TbWidget_PitchMode >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'setting' }
TbWidget_PitchMode >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'accessing' }
TbWidget_PitchMode >> indicator [
	^indicator.
]

{ #category : 'setting' }
TbWidget_PitchMode >> indicator: aBlock [
	indicator:= aBlock.
]

{ #category : 'initialization' }
TbWidget_PitchMode >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'initialization' }
TbWidget_PitchMode >> initializeEvents [
	"Mouse Up Event is chosen instead of down to make a smooth transition when the user unclicks the switch."
	switch
		childrenDo: [ :i|   
				i addEventHandler: (BlEventHandler
				 	on: BlMouseUpEvent
				 	do: [ :anEvent |
						self toggle.
					]).
	].
		
	
]

{ #category : 'initialization' }
TbWidget_PitchMode >> initializeLayout [
	|label|
	
	"self border: (BlBorder paint: (Color gray) width: 2)."

	label := BlTextElement new.
	label text: (self configuredStringDark: 'PITCH MODE' size:16).
	label constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		].
	label transformDo: [ :t|
		t translateBy:0@ 0. 
		].
	
	self switch: (TbHorizontalSwitch toggleable ).
	switch constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
	].	
	switch switch effect: (BlGaussianShadowEffect color: (Color veryDarkGray alpha:0.7)   offset: 0@ 4  width: 10).
	self indicator: (TbLED new).
	indicator constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:0@ 10. 
		].
	
	
	
	self addChildren: {label.self indicator. self switch}.
	
]

{ #category : 'initialization' }
TbWidget_PitchMode >> initializeWidget [
	self size: widgetSize.
	self background: (Color veryVeryDarkGray alpha:1.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbWidget_PitchMode >> initializeWidgetSize [
		widgetSize:= 160@120.
]

{ #category : 'setting' }
TbWidget_PitchMode >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'accessing' }
TbWidget_PitchMode >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'accessing' }
TbWidget_PitchMode >> switch [
	^switch
]

{ #category : 'setting' }
TbWidget_PitchMode >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'api - operations' }
TbWidget_PitchMode >> toggle [
	"Toggles the value of indicator and the widget (The switch is toggled automatically due to its own toggle nature)"
	self toggleValue.
	self indicator toggle.
	
]

{ #category : 'api - operations' }
TbWidget_PitchMode >> toggleValue [
	"Toggles the value of widget (not the value of inner elements)"


"Toggles the value of widget (not the value of inner elements)"

	self value = 0
		ifTrue: [
			self value: 1.
			self callback value ]
		ifFalse: [
			self value: 0.
			self callback value ]

]

{ #category : 'accessing' }
TbWidget_PitchMode >> value [
	^value
]

{ #category : 'setting' }
TbWidget_PitchMode >> value: anInteger [
	value:= anInteger.
]
