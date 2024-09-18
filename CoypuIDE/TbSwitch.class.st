Class {
	#name : 'TbSwitch',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'switch',
		'value'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TbSwitch class >> Switchexample [ 
	<script>
	| container e1 e2 e3|
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 10
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 249 g:239  b:224  range:255).

e1:=TbSwitch new.
e2:= TbSwitch new toggle.
e3:= TbSwitch toggleable.


container addChildren: { e1. e2. e3}.
container openInSpace.
	
]

{ #category : 'as yet unclassified' }
TbSwitch class >> toggleable [
	|ele|
	ele:= self new.
	ele reInitializeEvents.
	^ ele.
]

{ #category : 'as yet unclassified' }
TbSwitch >> backColor [
	"^ (Color veryVeryDarkGray alpha:1.0)"
	^ (Color r: 249 g:239  b:224  range:255)

]

{ #category : 'initialization' }
TbSwitch >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:0).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeSwitch.
	self initializeEvents.
]

{ #category : 'as yet unclassified' }
TbSwitch >> initializeEvents [


	switch
		addEventHandler: (BlEventHandler
				 on: BlMouseDownEvent
				 do: [ :anEvent |
					 self toggle.
					]).
	switch
		addEventHandler: (BlEventHandler
				 on: BlMouseUpEvent
				 do: [ :anEvent |
					 self toggle.
					]).
]

{ #category : 'as yet unclassified' }
TbSwitch >> initializeSwitch [
	|s|
	self switch: (BlElement new
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
	switch addChild: s.
	self addChild:self switch. 
]

{ #category : 'initialization' }
TbSwitch >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbSwitch >> initializeWidgetSize [
	widgetSize:= 40@80.
]

{ #category : 'evaluating' }
TbSwitch >> offColor [
	^ (Color r: 115 g:1  b:1  range:255).

]

{ #category : 'evaluating' }
TbSwitch >> reInitializeEvents [

	switch addEventHandler: (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent | self toggle ]).
			
		
]

{ #category : 'initialization' }
TbSwitch >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'as yet unclassified' }
TbSwitch >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'as yet unclassified' }
TbSwitch >> switch [
	^switch
]

{ #category : 'as yet unclassified' }
TbSwitch >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'as yet unclassified' }
TbSwitch >> switchOffColor [
	^ (Color r:233 g:202 b:157 range:255).
]

{ #category : 'as yet unclassified' }
TbSwitch >> switchOnColor [
	^ (Color r:166 g:136 b:108 range:255).
]

{ #category : 'initialization' }
TbSwitch >> toggle [
	self toggleValue.
	self value = 1 
		ifTrue: [ 
			"On Mode"
			
			switch background: (self switchOnColor alpha: 1.0);
			childrenDo: [ :i|   
				    i constraintsDo: [ :c |
						c frame horizontal alignCenter.
						c frame vertical alignBottom.
					].
					
			].
	 ] 
		ifFalse: [ 
			"Off Mode"
		
			
			switch background: (self switchOnColor alpha: 1.0);
				childrenDo: [ :i|   
				    i constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				].
				
				].
			
			
			
		
	].
]

{ #category : 'initialization' }
TbSwitch >> toggleValue [
	self value = 0 
		ifTrue: [ self value: 1 ] 
		ifFalse: [ self value: 0 ].
]

{ #category : 'initialization' }
TbSwitch >> value [
	^value
]

{ #category : 'initialization' }
TbSwitch >> value: anInteger [
	value:= anInteger.
]
