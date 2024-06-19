Class {
	#name : 'ICWaveIcon',
	#superclass : 'ICIcon',
	#category : 'ICIcons',
	#package : 'ICIcons'
}

{ #category : 'initialization' }
ICWaveIcon >> initialize [
	super initialize.
	self initializeSize.
	self initializeLineColor.
	self initializeBackColor.
	self initializeIcon.
]

{ #category : 'initialization' }
ICWaveIcon >> initializeIcon [
	|container ele ele2 ele3 ele4 ele5 ele6 ele7|
	container:= BlElement new
	size: 80 @80;
	geometry:BlRectangleGeometry new;
	background: background ;
	layout: BlFrameLayout new;
	padding:(BlInsets all: 10).

ele:= BlElement new
	geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 60;
	background:color;
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].

ele2:= BlElement new
	geometry:(BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 30;
	background:color;
	transformDo:[:t| t translateBy: -10@ 0.];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
ele3:= BlElement new
	geometry:(BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 45;
	background:color;
	transformDo:[:t| t translateBy: -20@ 0.];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
ele4:= BlElement new
	geometry:(BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 30;
	background:color;
	transformDo:[:t| t translateBy: -30@ 0.];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
ele5:= BlElement new
	geometry:(BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 45;
	background:color;
	transformDo:[:t| t translateBy: 10@0.];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
ele6:= BlElement new
	geometry:(BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 20;
	background:color;
	transformDo:[:t| t translateBy: 20@ 0.];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
ele7:= BlElement new
	geometry:(BlRoundedRectangleGeometry cornerRadius: 3);
	size: 6 @ 30;
	background:color;
	transformDo:[:t| t translateBy: 30@ 0.];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
container addChildren: { ele. ele2.  ele3.  ele4.  ele5.  ele6.  ele7 }.

self addChild: container.
]
