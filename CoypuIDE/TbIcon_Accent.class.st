Class {
	#name : 'TbIcon_Accent',
	#superclass : 'TbIcon',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'example' }
TbIcon_Accent class >> Example [ 
	<script>
	| container e1 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 2;
		cellSpacing: 10
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 249 g:239  b:224  range:255).
		"background: Color white."

e1:=TbIcon_Accent new.

container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'initialization' }
TbIcon_Accent >> initializeIcon [ 

	|e1 e2 e3 e4 e5 e6|
	e1:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@35;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignRight.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			
			t rotateBy: 10.
			t translateBy:-5@ 0.
		].

	e2:= BlElement new
    geometry: (BlRoundedRectangleGeometry cornerRadius: 1);
    size: 15@4;
    background: (Color veryVeryDarkGray alpha:1.0) ;
		
	constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
				];
				transformDo: [ :t|
			t translateBy:2@ -4. 
			
		].
	
	
	e3:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
									 (48 @ 0).
                           (45 @ 7).
                           (40 @ 15).
                           (33 @ 10) });
          size: 10 @ 30;
          background: (Color veryVeryDarkGray alpha:0.0);
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2);
           transformDo:[:t|
					t rotateBy:0.
					t translateBy: 0@0.
				].
	
	e4:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
								   (44 @ 13).
                           (42 @ 15).
                           (38 @ 23).
                           (30 @ 18) });
          size: 10 @ 30;
          background: (Color veryVeryDarkGray alpha:0.0) ;
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2).
	e5:= BlElement new
    geometry: BlEllipseGeometry new;
    size: 8@6;
    background: Color veryVeryDarkGray ;
	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:10@ -28. 
		].
	e6:= BlElement new
    geometry: BlEllipseGeometry new;
    size: 8@6;
    background: Color veryVeryDarkGray ;
	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:8@ -20. 
			
		].

	
	self addChildren: { e1 . e2. e3. e4. e5. e6}.
]
