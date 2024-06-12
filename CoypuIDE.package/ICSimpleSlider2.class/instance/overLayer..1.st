api - bounds
overLayer
	"additional layer on top for grid"
	|size container direc num width|
	size := self 
		        ifHorizontal: [ self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ self defaultBarLength ].
	
	direc:= self direction.
	num:= self defaultBarLength / 20.
	width:= self defaultBarThickness / 12. 
	container:=  BlElement new
		  	geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
			background: (Color red alpha:0.0);
			border: (BlBorder paint: (Color r:42  g:42  b:42  range:255 ) width: width);
		  	size: size;
			layout: (BlGridLayout new
			columnCount: 2);
		  	yourself.
			
	2 timesRepeat: [ 
		|div|
		div:= BlElement new
		constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		direc ifTrue: [ c grid horizontal span: 2  ]
			 	ifFalse: [ c grid vertical span: 2  ].
		];
		background: (Color purple alpha: 0.0);
		constraintsDo: [ :c |
		c horizontal matchParent .
		c vertical matchParent ];
		layout: BlFlowLayout horizontal;
		border: (BlBorder paint: (Color r:42  g:42  b:42  range:255 ) width: width / 2).
		
		"Horizontal grid"
		direc ifTrue: [ 
			num timesRepeat: [ |elt|
				elt:= BlElement new
		 		border: (BlBorder
				paint: (Color purple alpha:0.0) width: 2);
				size:  6 @ self defaultBarThickness * 2;
				background: (Color r:42  g:42  b:42  range:255 );
				margin: (BlInsets left:0 right: num*2).
				div addChild: elt. 
			 	].
			].
		container addChild: div. ].
		"vertical grid to be made"

	^ container.