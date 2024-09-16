Class {
	#name : 'TbLED',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'indicator',
		'value'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'as yet unclassified' }
TbLED class >> LEDexample [ 
	<script>
	| container e1 e2 |
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
		background: Color black .

e1:=TbLED new.
e2:= TbLED new toggle.


container addChildren: { e1. e2}.
container openInSpace.
	
]

{ #category : 'as yet unclassified' }
TbLED >> indicator [
	^indicator
]

{ #category : 'as yet unclassified' }
TbLED >> indicator: aBlock [
	indicator:= aBlock.
]

{ #category : 'initialization' }
TbLED >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:10).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeIndicator.
]

{ #category : 'as yet unclassified' }
TbLED >> initializeIndicator [	
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
	self addChild: self indicator.
]

{ #category : 'initialization' }
TbLED >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbLED >> initializeWidgetSize [
	widgetSize:= 60@50.
]

{ #category : 'evaluating' }
TbLED >> offColor [
	^ (Color r: 115 g:1  b:1  range:255).

]

{ #category : 'initialization' }
TbLED >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'initialization' }
TbLED >> toggle [
	self toggleValue.
	self value = 1 
		ifTrue: [ 
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
			
	 ] 
		ifFalse: [ 
			"Off Mode"
			"indicator background: self offColor;"
			indicator background: self offColor;
			effect: (BlGaussianShadowEffect color: (Color green alpha:0.0)   offset: 5@ 0  width: 35);
			childrenDo: [ :i|   
					i transformDo: [ :t |
						t translateBy: -4@ -4;
						scaleBy: 1.
					].
					i background: Color veryLightGray.
			
			].
			
		
	].
]

{ #category : 'initialization' }
TbLED >> toggleValue [
	self value = 0 
		ifTrue: [ self value: 1 ] 
		ifFalse: [ self value: 0 ].
]

{ #category : 'initialization' }
TbLED >> value [
	^value
]

{ #category : 'initialization' }
TbLED >> value: anInteger [
	value:= anInteger.
]
