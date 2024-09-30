Class {
	#name : 'TbOnOffSwitch',
	#superclass : 'TbSwitch',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'initialization' }
TbOnOffSwitch >> initializeSwitch [
	|s l1 l2 l3|
	self switch: (BlElement new
            geometry:(BlRoundedRectangleGeometry cornerRadius: 4);
				background: (self switchOnColor );
				transformDo: [ :t|
					t translateBy: 0@ -4 ];
				effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 0@ 4  width: 10);
            size: 60@30 ;
	         margin: (BlInsets all: 10);
				layout: BlFrameLayout new;
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				]).
	s:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				background: self switchOffColor;
				layout: BlFrameLayout new;
            size: 30@25 ;
	         margin: (BlInsets all: 2);
				padding: (BlInsets all: 5);
           	constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
				].
	l1:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
				background: self lineColor;
				layout: BlFrameLayout new;
            size: 3@15;
	         margin: (BlInsets all: 2);
           	constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
				].
	l2:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
				background: self lineColor;
				layout: BlFrameLayout new;
            size: 3@15 ;
	         margin: (BlInsets all: 2);
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				].
	l3:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
				background: self lineColor;
				layout: BlFrameLayout new;
            size: 3@15 ;
	         margin: (BlInsets all: 2);
           	constraintsDo: [ :c |
					c frame horizontal alignRight.
					c frame vertical alignCenter.
				].
	s addChildren: { l1. l2. l3 }.
	switch addChild: s.
	self addChild:self switch. 
]

{ #category : 'initialization' }
TbOnOffSwitch >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbOnOffSwitch >> initializeWidgetSize [
	widgetSize:= 70@50.
]

{ #category : 'initialization' }
TbOnOffSwitch >> lineColor [
	^ (Color r:166 g:136 b:108 range:255).


]

{ #category : 'initialization' }
TbOnOffSwitch >> switchOnColor [ 
 ^ (Color r:110 g:90 b:70 range:255).
]

{ #category : 'initialization' }
TbOnOffSwitch >> toggle [
	self toggleValue.
	self value = 1 
		ifTrue: [ 
			"On Mode"
			
			switch background: (self switchOnColor alpha: 1.0);
			childrenDo: [ :i|   
				    i constraintsDo: [ :c |
						c frame horizontal alignRight.
						c frame vertical alignCenter.
					].
					
			].
	 ] 
		ifFalse: [ 
			"Off Mode"
		
			
			switch background: (self switchOnColor alpha: 1.0);
				childrenDo: [ :i|   
				    i constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
				].
				
				].
			
			
			
		
	].
]
