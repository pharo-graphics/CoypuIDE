Class {
	#name : 'TbIcon_Selector0',
	#superclass : 'TbIcon',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'example' }
TbIcon_Selector0 class >> Example [ 
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

e1:=TbIcon_Selector0 new.

container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'initialization' }
TbIcon_Selector0 >> initializeIcon [ 

	|e1 e2 e3 e4 e5 e6 e7 e8 e9|
	self size: 60@40.
	e1:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@28;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:19@ 0. 
		].
	e2:= BlElement new
    geometry: BlEllipseGeometry new;
    size: 15@8;
    background: Color veryVeryDarkGray ;
	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t rotateBy: -35.
			t translateBy:14@ -8. 
			
		].

	e3:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
									 (35 @ 0).
                           (37 @ 20).
                           (42 @ 2).
                           (45 @ 17) });
          size: 10 @ 30;
          background: Color veryVeryDarkGray ;
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2);
				transformDo:[:t|
				t translateBy:14@0. 
				].
	

	e4:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@28;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:2@ 0. 
		].
	e5:= BlElement new
    geometry: BlEllipseGeometry new;
    size: 15@8;
    background: Color veryVeryDarkGray ;
	constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			
			t rotateBy: -35.
			t translateBy:-3@ -8. 
		].

	e6:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
									 (35 @ 0).
                           (37 @ 20).
                           (42 @ 2).
                           (45 @ 17) });
          size: 10 @ 30;
          background: Color veryVeryDarkGray ;
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2);
			transformDo:[:t|
				t translateBy:-3@0. 
				].
			
	e7:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@28;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:-15@ 0. 
		].
	e8:= BlElement new
    	geometry: BlEllipseGeometry new;
    	size: 15@8;
    	background: Color veryVeryDarkGray ;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			
			t rotateBy: -35.
			t translateBy:-20@ -8. 
		].

		e9:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
									 (35 @ 0).
                           (37 @ 20).
                           (42 @ 2).
                           (45 @ 17) });
          size: 10 @ 30;
          background: Color veryVeryDarkGray ;
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2);
			transformDo:[:t|
				t translateBy:-20@0. 
				].


	
	self addChildren: { e1 . e2. e3. e4. e5. e6. e7. e8. e9}.
]
