Class {
	#name : 'TbHorizontalSwitch2',
	#superclass : 'TbSwitch',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'initialization' }
TbHorizontalSwitch2 >> initializeSwitch [
	|s|
	self switch: (BlElement new
            geometry:(BlRoundedRectangleGeometry cornerRadius: 6);
				background: self switchOnColor;
				transformDo: [ :t|
					t translateBy: 0@ -4 ];
				effect: (BlGaussianShadowEffect color: (self shadowColor)   offset: 0@ 4  width: 10);
            size: 90@60;
	         margin: (BlInsets all: 10);
				layout: BlFrameLayout new;
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				]).
	s:= BlElement new
            geometry: (BlRoundedRectangleGeometry cornerRadius: 6);
				background: self switchOffColor;
            size: 85@47 ;
	         margin: (BlInsets all: 2);
           	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				].
	switch addChild: s.
	self addChild:self switch. 
]

{ #category : 'initialization' }
TbHorizontalSwitch2 >> initializeWidget [
	self size: widgetSize.
	self background: (Color gray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbHorizontalSwitch2 >> initializeWidgetSize [
	widgetSize:= 100@70.
]
