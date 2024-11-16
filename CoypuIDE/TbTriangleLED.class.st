Class {
	#name : 'TbTriangleLED',
	#superclass : 'TbLED',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbTriangleLED class >> TriangleLEDexample [ 
	<script>
	| container e1 e2 e3 |
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
		
		background: (Color r: 249 g:239  b:224  range:255).
		"background: (Color veryVeryDarkGray)."
			


e1:=self new.
e2:= self new toggle.
e3:= self new toggle toggle.


container addChildren: { e1. e2. e3}.
container openInSpace.
	
]

{ #category : 'evaluating' }
TbTriangleLED >> initializeIndicator [	
	|e|
	self indicator: (BlElement new
            geometry: BlTriangleGeometry new;
				background: (self offColor alpha:1.0);
            size: 20@20;
				layout: BlFrameLayout new;
				transformDo: [ :t|
					t rotateBy: -90 ];
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				]).
	
	e:= BlElement new
            geometry: BlTriangleGeometry new;
				background: (Color veryDarkGray alpha:1.0);
            size: 5@5;
				transformDo: [ :t|
					
					t translateBy: 2@ -2.
		 		];
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				].
			
	indicator addChild: e.
	
	self addChild: self indicator.
]

{ #category : 'evaluating' }
TbTriangleLED >> initializeWidgetSize [
	widgetSize:= 60@50.
]

{ #category : 'evaluating' }
TbTriangleLED >> offColor [
	"^ (Color r:1 g:1  b:1  range:255)."
	"^ (Color veryVeryDarkGray)."
	^ Color black.
]

{ #category : 'evaluating' }
TbTriangleLED >> toggle [
	|d|
	self toggleValue.
	
	d:= (BlElement new
            		geometry: BlTriangleGeometry new;
					"background: (Color orange alpha:1.0);"
					background: (Color r:253 g:100 b:75 range:255);
            		size: 5@5;
						transformDo: [ :t|
							t scaleBy:1.5.
							t translateBy: 2@ -1.
		 			];
					effect: (BlGaussianShadowEffect color: (Color white alpha:1.0)   offset: 0@ 0  width: 10);
           		constraintsDo: [ :c |
						c frame horizontal alignCenter.
						c frame vertical alignCenter.
		]).
		self value = 1 
		ifTrue: [ 
			"On Mode"
			indicator background: (Color red alpha: 1.0);
			effect: (BlGaussianShadowEffect color: (Color red alpha:1.0)   offset: -2 @ 2   width: 15).
			indicator addChild: d.
		
			
	 ] 
		ifFalse: [ 
			"Off Mode"
			
			indicator background: self offColor;
			effect: (BlGaussianShadowEffect color: (Color green alpha:0.0)   offset: 5@ 0  width: 35);
			removeChildAt: 2.	
		
	].
]
