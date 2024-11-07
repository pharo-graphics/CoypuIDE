Class {
	#name : 'TbKnob2',
	#superclass : 'TbKnob',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbKnob2 class >> basicExample [

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
TbKnob2 >> color6 [
	^ (Color r: 241 g:224  b:205  range:255).
]

{ #category : 'initialization' }
TbKnob2 >> initializeDefaultValues [

	minValue := 0.
	maxValue := 100.
	stepValue := nil.
	diameter :=120.
	minAngle := -135.
	maxAngle := 135
]

{ #category : 'initialization' }
TbKnob2 >> initializeGeometry [
	
	|e1 e2  st st2 marker k kb kb2 kf k1 |

	self size: 180 @ 220.
	self background: (self backColor alpha:0.0).
   "self border: (BlBorder paint: (Color gray) width: 2)."
	self clipChildren: false.
	self layout: BlFrameLayout new.
	self padding:(BlInsets all: 7).
	
	e1:= BlElement new
		size: 130 asPoint;
		geometry: (BlCircleGeometry new);
		background: Color veryDarkGray;
		transformDo:[:t | 
				t translateBy: -1.2@ -1.2];
		constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
		transformDo:[:t | t translateBy:2.2@ -1.2];
		effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 10@35  width: 60).
	
	
	e2:= BlElement new
		size: 122 asPoint;
		geometry: (BlCircleGeometry new);
		background: (BlRadialGradientPaint new
		stops: { 0 -> self color2. 1 -> self color1 };
		center: 35@35;
		radius: 150;
		yourself);
		constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
		transformDo:[:t | t translateBy:3@ 0].
	
		self addChildren:{ e1. e2}.
	
	
	"st:= -280.
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
	transformDo:[:t | t translateBy:3@ 0].	
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
	transformDo:[:t | t translateBy:3@ 0].	
	self addChild:dash.]."
		

	k:= BlElement new
			geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
			 size: self knobSize-40 @ self knobSize +20;
			 clipChildren: true;
			 background: (self color4 alpha:1);
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter];
			layout: BlFrameLayout new;
			effect: (BlGaussianShadowEffect color: (Color brown alpha:1)   offset: 0@0  width: 24).
		
	

	
	marker := BlElement new
		          size: 24 @ 7;
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          background: self color4;
					transformDo:[:t | t rotateBy:80.
						t translateBy: 5@ 5];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignTop].
					
			marker zIndex: 100.
	k1 := BlElement new
		          size: 24 @ 100;
		          transformDo: [ :t | t translateBy: -2 @ 0 ];
					
		          geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		          background: self color5 ;
					transformDo:[:t | t rotateBy:90.
						t translateBy: 0@ -40];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignTop].
			
	kf := BlElement new
		          size: 46@72;
		          geometry: (BlRoundedRectangleGeometry cornerRadius:4);
		          background: self color6;
					transformDo:[:t | t rotateBy:0.
						t translateBy: 6@ 5];
					 constraintsDo: [ :c |
				 	c frame horizontal alignCenter.
					 c frame vertical alignCenter].
				
	kb := BlElement new
		          size: 24@40;
		          geometry: (BlRoundedRectangleGeometry cornerRadius:3);
		          background: (self color4 alpha:1);
					transformDo:[:t | t rotateBy:-30.
						t translateBy: -16@ -6];
					 constraintsDo: [ :c |
				 	c frame horizontal alignLeft.
					 c frame vertical alignTop].
	kb2 := BlElement new
		          size: 14@40;
		          geometry: (BlRoundedRectangleGeometry cornerRadius:3);
		          background: (self color4 alpha:1);
					transformDo:[:t | t rotateBy:10.
						t translateBy: 10@ -3];
					 constraintsDo: [ :c |
				 	c frame horizontal alignRight.
					 c frame vertical alignTop].							
			
	k addChildren: {k1. marker. kb. kb2. kf}.
	
		
	self knob: k.
	self addChild: self knob.
]

{ #category : 'accessing' }
TbKnob2 >> labelSize [ 
	^20
]
