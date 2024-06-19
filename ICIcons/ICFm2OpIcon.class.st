Class {
	#name : 'ICFm2OpIcon',
	#superclass : 'ICIcon',
	#category : 'ICIcons',
	#package : 'ICIcons'
}

{ #category : 'initialization' }
ICFm2OpIcon >> initialize [
	super initialize.
	self initializeSize.
	self initializeLineColor.
	self initializeBackColor.
	self initializeIcon.
]

{ #category : 'initialization' }
ICFm2OpIcon >> initializeIcon [
	|container ele ele2 ele3 ele4 ele5 ele6 ele7|
	container:= BlElement new
	size: 80 @80;
	geometry:BlRectangleGeometry new;
	background: background ;
	layout: BlFrameLayout new;
	padding:(BlInsets all: 5).

ele:= BlElement new
	geometry: (BlRectangleGeometry new);
	size:  25@ 15;
	background:color;
	transformDo: [ :t|
		t translateBy: 5@0.
		 ];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignLeft.
		].
	
ele2:= BlElement new
	geometry: (BlRectangleGeometry new);
	size:  25@ 15;
	background:color;
	transformDo: [ :t|
		t translateBy: -5@0.
		 ];
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignRight.
		].


ele3:= BlElement new
	geometry: (BlRectangleGeometry new);
	size:  25@ 15;
	background:color;
	transformDo: [ :t|
		t translateBy: -5@5.
		 ];
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignRight.
		].
ele4:= BlElement new
	geometry: (BlRectangleGeometry new);
	size:  25@ 15;
	background:color;
	transformDo: [ :t|
		t translateBy: 5@ -5.
		 ];
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignLeft.
		].
ele5:= BlElement new
	geometry: (BlRectangleGeometry new);
	size:  18@ 25;
	background:(Color gray alpha:0.0);
	border: (BlBorder paint: color width: 2);
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignRight.
		].
ele6:= BlElement new
	background: (Color white alpha:0.0);

	border: (BlBorder paint: color width: 2);
geometry: (	BlPolylineGeometry vertices: {(54 @ 5). ( 54 @ 35) .
 . (20 @ 35) }).

ele7:= BlElement new
	background: (color);
	size:2@40;
	transformDo: [ :t|
		t translateBy: 15@ 0.
		 ];
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignLeft.
		].
	


container addChildren: { ele. ele2.  ele3.  ele4. ele5. ele6. ele7}.

self addChild: container.
]
