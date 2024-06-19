Class {
	#name : 'ICPercussionsIcon',
	#superclass : 'ICIcon',
	#category : 'ICIcons',
	#package : 'ICIcons'
}

{ #category : 'initialization' }
ICPercussionsIcon >> initialize [
	super initialize.
	self initializeSize.
	self initializeLineColor.
	self initializeBackColor.
	self initializeIcon.
]

{ #category : 'initialization' }
ICPercussionsIcon >> initializeIcon [ 
	|container ele ele2 ele3 ele4 ele5 ele6 ele7 ele8 ele9 ele10 ele11 ele12|
	container:= BlElement new
	size: 80 @ 80;
	geometry:BlRectangleGeometry new;
	background: background;
	layout: BlFrameLayout new;
	padding:(BlInsets all: 5).

ele:= BlElement new
	geometry: BlEllipseGeometry new;
	size: 70 @ 25;
	background:(Color white alpha:0.0);
	border: (BlBorder paint: color width: 4);
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.].

ele2:= BlElement new
	geometry: BlEllipseGeometry new;
	size: 70 @ 25;
	background:(Color white alpha:0.0);
	border: (BlBorder paint: color width: 4);
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignCenter.].
	
ele3:= BlElement new
	geometry: BlEllipseGeometry new;
	size: 70 @ 25;
	background:background;
	border: (BlBorder paint: background width: 4);
	transformDo:[:t| t translateBy: 0@ -4];
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignCenter.].
	
ele4:= BlElement new
	background: color;
	size: 4@25;
	geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
	transformDo:[:t| t translateBy: 0@ -10];
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignLeft.].

ele5:= BlElement new
	background: color;
	size: 4@25;
	geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
	transformDo:[:t| t translateBy: 0@ -10];
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignRight.].
	
ele6:= BlElement new
	geometry: BlCircleGeometry new;
	size: 12@12;
	background:(Color white alpha:0.0);
	border: (BlBorder paint: color width: 4);
		transformDo:[:t| t translateBy: -5@  10];
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignCenter.].

ele7:= BlElement new
	geometry: BlCircleGeometry new;
	size: 12@12;
	background:(Color white alpha:0.0);
	border: (BlBorder paint: color width: 4);
	transformDo:[:t| t translateBy: 8@ 0];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.].

ele8:= BlElement new
	background: color;
	size: 4@25;
	geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
	transformDo:[:t| t 
		rotateBy: 50;
		translateBy: 20@ 12.
		
		];
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignCenter.].

ele9:= BlElement new
	background: color;
	size: 4@25;
	geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
	transformDo:[:t| t 
		rotateBy: -70;
		translateBy: -20@ -2.
		];
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignCenter.].


ele10:= BlElement new
	background: color;
	border: (BlBorder paint: color width: 3);
geometry: (	BlPolylineGeometry vertices: {(4 @ 40). ( 14 @ 65) .
 . (28 @ 45)  }).

ele11:= BlElement new
	background: color;
	border: (BlBorder paint: color width: 3);
geometry: (	BlPolylineGeometry vertices: {(28 @ 45) . (42 @ 68 ) . ( 56 @ 45) .
 }).

ele12:= BlElement new
	background: color;
	border: (BlBorder paint: color width: 3);
geometry: (	BlPolylineGeometry vertices: {( 56 @ 45) . (70 @ 60) . (70@ 36)
}).
	
container addChildren:{ele2 . ele3 .ele .ele4 .ele5. ele6. ele7. ele8. ele9. ele10. ele11. ele12 }.

self addChild: container.


]
