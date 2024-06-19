Class {
	#name : 'ICBassDrumIcon',
	#superclass : 'ICIcon',
	#category : 'ICIcons',
	#package : 'ICIcons'
}

{ #category : 'initialization' }
ICBassDrumIcon >> initialize [
	super initialize.
	self initializeSize.
	self initializeLineColor.
	self initializeBackColor.
	self initializeIcon.
]

{ #category : 'initialization' }
ICBassDrumIcon >> initializeIcon [
	|container ele ele2 ele3 ele4 ele5 ele6 st |
	container:= BlElement new
	size: 80 @ 80;
	geometry:BlRectangleGeometry new;
	background: background;
	layout: BlFrameLayout new;
	padding:(BlInsets all: 5).

	ele:= BlElement new
	geometry: BlCircleGeometry new;
	size: 65 asPoint;
	background:(Color white alpha: 0.0);
	border: (BlBorder paint: (color) width: 4);

	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
	

	ele2:= BlElement new
	background: color;
	size:8@8;
	geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].
	
ele3:= BlElement new
	background: (Color white alpha:0.0);
	size:15@15;
	border: (BlBorder paint: color width: 3);
	geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignCenter.
		].


	
ele4:= BlElement new
	background: (color);
	size: 3@35;
	
	geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignCenter.].

ele5:=BlElement new
	background: (color);

geometry:(BlRoundedRectangleGeometry cornerRadius: 4);
		size: 3@22;
		transformDo:[:t | 
		t rotateBy:30.
		];	
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignLeft.].

ele6:=BlElement new
	background: (color);

geometry:(BlRoundedRectangleGeometry cornerRadius: 4);
		size: 3@22;
		transformDo:[:t | 
		t rotateBy:-30.
		];	
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignRight.].


st:= -80.
1 to: 6 do: 
  [:i |
	|dash curr|

	curr:= (i * 60).
	curr:= curr + st.
	curr:= curr + 10. 
	dash:= 
	 BlElement new
		           background: color;
		           size: 70 asPoint;"
"geometry: (BlAnnulusSectorGeometry new
			 startAngle: curr;
			 endAngle: curr + 20;
			 innerRadius: 0.9;
			 outerRadius: 1.0);	

constraintsDo: [ :c |
c frame horizontal alignLeft.
c frame vertical alignBottom ].

container addChild: dash.
	 ].

container addChildren:{ele . ele2 .ele3 .ele4 .ele5. ele6 }.

self addChild: container.
	
	
]
