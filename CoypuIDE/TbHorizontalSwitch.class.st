Class {
	#name : 'TbHorizontalSwitch',
	#superclass : 'TbSwitch',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'initialization' }
TbHorizontalSwitch >> initializeSwitch [
	|s|
	self switch: (BlElement new
            geometry:(BlRoundedRectangleGeometry cornerRadius: 4);
				background: self switchOnColor;
				transformDo: [ :t|
					t translateBy: 0@ -4 ];
				effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 0@ 4  width: 10);
            size: 60@35 ;
	         margin: (BlInsets all: 10);
				layout: BlFrameLayout new;
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				]).
	s:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
				background: self switchOffColor;
            size: 55@25 ;
	         margin: (BlInsets all: 2);
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				].
	switch addChild: s.
	self addChild:self switch. 
]

{ #category : 'initialization' }
TbHorizontalSwitch >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbHorizontalSwitch >> initializeWidgetSize [
	widgetSize:= 70@50.
]
