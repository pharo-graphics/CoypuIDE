Class {
	#name : 'SampleTbButtonGroup',
	#superclass : 'BlElement',
	#instVars : [
		'btn1',
		'btn2',
		'led',
		'switch',
		'back',
		'widgetSize',
		'button',
		'indicator',
		'value'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
SampleTbButtonGroup class >> examplebtns [
	<script>
	"An example of different btns and indicators working together (can be used later to combine components)"
	| container e1|
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
		background: Color veryVeryDarkGray.

e1:= SampleTbButtonGroup new.


container addChildren: { e1}.
container openInSpace.

]

{ #category : 'accessing' }
SampleTbButtonGroup >> back [
	^back.
]

{ #category : 'accessing' }
SampleTbButtonGroup >> back: anInteger [
	back:= anInteger.
]

{ #category : 'accessing' }
SampleTbButtonGroup >> backColor [
	"^ (Color veryVeryDarkGray alpha:1.0)"
	^ (Color r: 249 g:239  b:224  range:255)

]

{ #category : 'initialization' }
SampleTbButtonGroup >> btn [
	^btn2.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> btn1 [
	^btn1.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> btn1: aBlock [
	btn1:= aBlock.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> btn2 [
	^btn2.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> btn2: aBlock [
	btn2:= aBlock.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> initialize [

	super initialize.
	self value: 1.
	self initializeWidgetSize.
	self initializeWidget.
	self padding: (BlInsets all: 20).
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'initialization' }
SampleTbButtonGroup >> initializeEvents [
	"Note: Use events on the children of the elements, else events will also be triggered on paddings and margins."

		[ :i| 
				  
				i addEventHandler: (BlEventHandler
				 on: BlMouseDownEvent
				 do: [ :anEvent |
					btn2 toggle.
					led toggle.
					]).
		] value: btn1 children last.
	
	[ :i| 
				  
				i addEventHandler: (BlEventHandler
				 on: BlMouseUpEvent
				 do: [ :anEvent |
					btn2 toggle.
					led toggle.
					]).
		] value: btn1 children last.
	"btn1
		
		childrenDo: [ :i| 
				  
				i addEventHandler: (BlEventHandler
				 on: BlMouseDownEvent
				 do: [ :anEvent |
					btn2 toggle.
					led toggle.
					]).
		]."
	
	"btn1
		childrenDo: [ :i| 
			  	i addEventHandler: (BlEventHandler
				 on: BlMouseUpEvent
				 do: [ :anEvent |
					btn2 toggle.
					led toggle.
					]).
		]."
	
	switch
		childrenDo: [ :i|   
				i addEventHandler: (BlEventHandler
				 	on: BlMouseUpEvent
				 	do: [ :anEvent |
						btn1 toggle.
						self toggleBack.
					]).
		].
		
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> initializeLayout [

	self btn1: (TbLEDDarkButton new).
	btn1 constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
	].	
	btn1 toggle.	
	
	self switch: (TbSwitch new).
	switch constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
	].
	
	self led: (TbLED new).
	led constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
	].

	self btn2: (TbLEDButton new).
	btn2 constraintsDo: [ :c |
					c frame horizontal alignRight.
					c frame vertical alignCenter.
	].
	self addChildren: {self btn1. self switch. self led. self btn2}.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> initializeWidget [
	self size: widgetSize.
	self background: (self backColor ).

	"self background:(Color r: 240 g:230  b:214  range:255)."
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
SampleTbButtonGroup >> initializeWidgetSize [
	widgetSize:= 300@200.
]

{ #category : 'initialization' }
SampleTbButtonGroup >> led [
 ^led
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> led: aBlock [
	led:= aBlock.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> switch [
 ^switch
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> switch: aBlock [
	switch:= aBlock.
	
]

{ #category : 'initialization' }
SampleTbButtonGroup >> toggleBack [
	self toggleValue.
	self value = 0 
		ifTrue: [ self background:Color black ]
		ifFalse: [ self background: self backColor].
]

{ #category : 'initialization' }
SampleTbButtonGroup >> toggleValue [
	self value = 0 
		ifTrue: [ self value: 1 ] 
		ifFalse: [ self value: 0 ].
]

{ #category : 'initialization' }
SampleTbButtonGroup >> value [
	^ value.
]

{ #category : 'accessing' }
SampleTbButtonGroup >> value: anInteger [
	value:= anInteger.
]
