Class {
	#name : 'TbKnob1',
	#superclass : 'TbKnob',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbKnob1 class >> basicExample [

	<script>

	|container knob |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 2;
		cellSpacing: 50
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 233 g:224  b:208  range:255).
		"background: (Color r: 249 g:239  b:224  range:255)."
		"background: Color white."
	
	knob := self label:'RESONANCE'.
	container addChildren: { knob }. 
	container openInSpace.

	"knob callBack: [ :v | v inspect ]"
]

{ #category : 'accessing' }
TbKnob1 >> initializeDefaultValues [

	minValue := 0.
	maxValue := 100.
	stepValue := nil.
	diameter :=120.
	minAngle := -135.
	maxAngle := 135
]

{ #category : 'initialization' }
TbKnob1 >> initializeGeometry [
	
	|e1 e2  st st2 marker k kb k1 |

	self size: 180 @ 200.
	self background: (self backColor alpha:0.0).
   "self border: (BlBorder paint: (Color gray) width: 2)."
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding:(BlInsets all: 7).
	
	e1:= BlElement new
	size: 130 asPoint;
	geometry: (BlCircleGeometry new);
	"transformDo: [ :t | t translateBy: 30@30 ];"
	background: Color veryDarkGray;
	transformDo:[:t | 
		t translateBy: -1.2@ -1.2];
	constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			transformDo:[:t | t translateBy:2.2@ 10.8];
		effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 10@35  width: 60).
	
	e2:= BlElement new
	size: 122 asPoint;
	geometry: (BlCircleGeometry new);
	"transformDo: [ :t | t translateBy: 30@30 ];"
	background: (BlRadialGradientPaint new
	stops: { 0 -> self color2. 1 -> self color1 };
	center: 35@35;
	radius: 150;
	yourself);
	constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
		transformDo:[:t | t translateBy:3@ 12].
	
	
		self addChildren:{ e1. e2}.
	
	
	st:= -280.
	1 to: 11 do: [:i |
	|dash curr|
	curr:= (i * 30).
	curr:= curr + st.
	curr:= curr + 10. 
	dash:= 
	 BlElement new
		           background: Color veryVeryDarkGray ;
		           size: diameter+ 50 asPoint;
	geometry: (BlAnnulusSectorGeometry new
			 startAngle: curr;
			 endAngle: curr + 2;
			 innerRadius: 0.82;
			 outerRadius: 0.97);	

	constraintsDo: [ :c |
	c frame horizontal alignCenter.
	c frame vertical alignCenter ];
	transformDo:[:t | t translateBy:3@ 12].	
	self addChild:dash.].
		
	st2:= -265.
	1 to: 10 do: [:i |
	|dash curr|
	curr:= (i * 30).
	curr:= curr + st2.
	curr:= curr + 10. 
	dash:= 
	 BlElement new
		           background: Color veryVeryDarkGray ;
		           size: diameter+ 50 asPoint;
	geometry: (BlAnnulusSectorGeometry new
			 startAngle: curr;
			 endAngle: curr + 1.5;
			 innerRadius: 0.82;
			 outerRadius: 0.88);	

	constraintsDo: [ :c |
	c frame horizontal alignCenter.
	c frame vertical alignCenter ];
	transformDo:[:t | t translateBy:3@ 12].	
	self addChild:dash.].
		
	


	k:= BlElement new
			 geometry: BlCircleGeometry new;
			 size: self knobSize-15 asPoint;
			 clipChildren: true;
			 background: (self color1 alpha:1);
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			layout: BlFrameLayout new.
		
	
	kb:= BlElement new
			 geometry: BlCircleGeometry new;
			 size: self knobSize-5 asPoint;
			 clipChildren: false;
			 background: (self color4 alpha:1);
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			transformDo:[:t | t translateBy:4@ 16];
			effect: (BlGaussianShadowEffect color: (Color brown alpha:0.7)   offset: 3@12  width: 17).
	
		self addChild:kb.
	


	
	marker := BlElement new
		          size: 34 @ 7;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          background: self color4;
		          "position: self knobSize / 2 @ 5."
					transformDo:[:t | t rotateBy:90.
						t translateBy: 0@ 5];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignTop].
					
			marker zIndex: 100.
		k1 := BlElement new
		          size: 24 @ 100;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          background: self color5 ;
		          "position: self knobSize / 2 @ 5."
					transformDo:[:t | t rotateBy:90.
						t translateBy: 0@ -35];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignTop].
					
			marker zIndex: 100.
			
	k addChildren: {k1. marker}.
	
		
	self knob: k.
	self addChild: self knob.
]

{ #category : 'initialization' }
TbKnob1 >> labelSize [ 
	^20
]
