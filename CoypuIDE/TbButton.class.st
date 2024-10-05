"
I am an ICButton. I need a label and a callbackDown for MouseDown events and a callBackUp for MouseUp events
"
Class {
	#name : 'TbButton',
	#superclass : 'BlElement',
	#instVars : [
		'back',
		'widgetSize',
		'button',
		'indicator',
		'switch',
		'isOn',
		'value',
		'callbackDown',
		'callBackUp',
		'callback',
		'isToggleable'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbButton class >> allButtonExamples [
	<script>
	| container e1 e2 e3 e4 e5 e6 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 0
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: Color darkGray.

e1:= TbButton new.


container addChildren: { e1}.
container openInSpace.

]

{ #category : 'as yet unclassified' }
TbButton class >> layoutViewExample_1560_720 [
	<script>
	| container e1 e2 e3 e4 e5|
container:= BlElement new
	geometry: BlRectangleGeometry new;
	layout: (BlGridLayout new
		columnCount: 10;
		cellSpacing: 10
		);
	"size: 1280@720;"
	size: 1560@720;
	"background: Color veryVeryDarkGray ."
		"background: Color veryDarkGray ."
			background: Color black .


e1:= TbButton new.
e2:= TbLEDButton new.
e3:= TbLEDButton toggleable.
e4:= TbLEDDarkButton new.
e5:= TbLEDDarkButton toggleable.

container addChildren: { e1 . e2 . e3 . e4 . e5 }.
container openInSpace.
		
		
	
]

{ #category : 'api - attribute' }
TbButton class >> toggleable [
	|ele|
	ele:= self new.
	ele reInitializeEvents.
	^ ele.
]

{ #category : 'evaluating' }
TbButton >> back [
	^back
]

{ #category : 'evaluating' }
TbButton >> back: anElement [
	back:= anElement.
]

{ #category : 'evaluating' }
TbButton >> backColor [
	"^ (Color veryVeryDarkGray alpha:1.0)"
	^ (Color r: 249 g:239  b:224  range:255)

]

{ #category : 'evaluating' }
TbButton >> button [
	^ button.
]

{ #category : 'evaluating' }
TbButton >> button: anElement [
	button:= anElement.
]

{ #category : 'accessing' }
TbButton >> callBackUp [

	^ callBackUp
]

{ #category : 'accessing' }
TbButton >> callBackUp: aBlock [

	callBackUp := aBlock
]

{ #category : 'accessing' }
TbButton >> callback [

	^ callback
]

{ #category : 'accessing' }
TbButton >> callback: aBlock [

	callback := aBlock
]

{ #category : 'accessing' }
TbButton >> callbackDown [

	^ callbackDown
]

{ #category : 'accessing' }
TbButton >> callbackDown: aBlock [

	callbackDown := aBlock
]

{ #category : 'evaluating' }
TbButton >> indicator [
	^ indicator.
]

{ #category : 'evaluating' }
TbButton >> indicator: anElement [
	indicator:= anElement.
]

{ #category : 'evaluating' }
TbButton >> initialize [

	super initialize.
	isToggleable  := false.
	self value: 0.
	self initializeWidgetSize.
	self initializeWidget.
	self initializeSwitch.
	self initializeEvents
]

{ #category : 'initialization' }
TbButton >> initializeButton [
	|s|
	self button: (BlElement new
            geometry:(BlRoundedRectangleGeometry cornerRadius: 4);
				background: self switchOnColor;
				transformDo: [ :t|
					t translateBy: 0@ -4 ];
				effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 0@ 4  width: 10);
            size: 30@60 ;
	         margin: (BlInsets all: 10);
				layout: BlFrameLayout new;
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				]).
	s:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				background: self switchOffColor;
            size: 25@50 ;
	         margin: (BlInsets all: 2);
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				].
	button addChild: s.
]

{ #category : 'evaluating' }
TbButton >> initializeEvents [

	button addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent | self toggle ]).
	self isToggleable ifFalse: [
		button addEventHandler: (BlEventHandler
				 on: BlMouseUpEvent
				 do: [ :anEvent |
					 self toggle.
					]) ]
			
		
]

{ #category : 'initialization' }
TbButton >> initializeIndicator [	
	|e|
	self indicator: (BlElement new
            geometry: BlCircleGeometry new;
				background: (self offColor alpha:1.0);
            size: 20@20;
				layout: BlFrameLayout new;
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				]).
	
	e:= BlElement new
            geometry: BlCircleGeometry new;
				background: (Color veryLightGray alpha:1.0);
            size: 5@5;
				transformDo: [ :t|
					t translateBy: -4@ -4.
		 		];
				effect: (BlGaussianShadowEffect color: (Color white alpha:1.0)   offset: 0@ 0  width: 7);
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				].
			
	indicator addChild: e.
]

{ #category : 'evaluating' }
TbButton >> initializeSwitch [
	"Switch (backdrop) . Indicator (LED) . Button (Button)"
	
	"self switch: (BlElement new 
		geometry: (BlRoundedRectangleGeometry cornerRadius: 6);
		background: self backColor;
		layout: BlFrameLayout new;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
					c horizontal matchParent .
					c vertical matchParent.
		]).

	
	self initializeIndicator.
	
	self initializeButton.
	
	switch addChildren: {self indicator . self button }.
	self addChild: switch."
	

	self initializeIndicator.
	
	self initializeButton.
	self addChildren: {self indicator . self button}.
]

{ #category : 'evaluating' }
TbButton >> initializeWidget [
	self size: widgetSize.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	self padding: (BlInsets all: 5).
	self background: self backColor.
	self layout: BlFrameLayout new.




]

{ #category : 'evaluating' }
TbButton >> initializeWidgetSize [
	widgetSize:= 60@120.
]

{ #category : 'accessing' }
TbButton >> isOn [

	^ isOn
]

{ #category : 'accessing' }
TbButton >> isOn: anObject [

	isOn := anObject
]

{ #category : 'accessing' }
TbButton >> isToggleable [

	^ isToggleable
]

{ #category : 'accessing' }
TbButton >> isToggleable: aBoolean [

	isToggleable := aBoolean.
	self initializeEvents
]

{ #category : 'evaluating' }
TbButton >> offColor [
	^ (Color r: 115 g:1  b:1  range:255).

]

{ #category : 'evaluating' }
TbButton >> reInitializeEvents [

	button addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent | self toggle ]).
			
		
]

{ #category : 'evaluating' }
TbButton >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'evaluating' }
TbButton >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"

]

{ #category : 'evaluating' }
TbButton >> switch [
	^switch.
]

{ #category : 'evaluating' }
TbButton >> switch: anElement [
	switch:= anElement.
]

{ #category : 'evaluating' }
TbButton >> switchOffColor [
	^ (Color r:233 g:202 b:157 range:255).


]

{ #category : 'evaluating' }
TbButton >> switchOnColor [
	^ (Color r:166 g:136 b:108 range:255).


]

{ #category : 'evaluating' }
TbButton >> toggle [
	self toggleValue.
	self value = 0 
		ifTrue: [ 
			"Off Mode"
			indicator background: self offColor;
			effect: (BlGaussianShadowEffect color: (Color red alpha:0.0)   offset: 5@ 0  width: 35);
			childrenDo: [ :i|   
					i transformDo: [ :t |
						t translateBy: -4@ -4;
						scaleBy: 1.
					].
					i background: Color veryLightGray.
			
			].
			
			button background: (self switchOnColor alpha: 1.0);
				childrenDo: [ :i|   
				    i constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				].
				
				].
			
	 ] 
		ifFalse: [ 
			"On Mode"
			indicator background: (Color red alpha: 1.0);
			effect: (BlGaussianShadowEffect color: (Color red alpha:1.0)   offset: 4@4   width: 25);
			childrenDo: [ :i|   
					i transformDo: [ :t |
						t translateBy: -3@ -3;
						scaleBy: 3/2.
					].
					i background:Color veryVeryLightGray.
					
			].
			button background: (self switchOnColor alpha: 1.0);
			childrenDo: [ :i|   
				    i constraintsDo: [ :c |
						c frame horizontal alignCenter.
						c frame vertical alignBottom.
					].
					
			].
	].
]

{ #category : 'evaluating' }
TbButton >> toggleValue [
	self value = 0 
		ifTrue: [ self value: 1 ] 
		ifFalse: [ self value: 0 ].
]

{ #category : 'evaluating' }
TbButton >> value [
	^ value.
]

{ #category : 'evaluating' }
TbButton >> value: aBoolean [
	value:= aBoolean.
]

{ #category : 'accessing' }
TbButton >> widgetSize [

	^ widgetSize
]

{ #category : 'evaluating' }
TbButton >> widgetSize: aSize [
	widgetSize:= aSize.
]
