Class {
	#name : 'TbIcon_TransposeDown',
	#superclass : 'TbIcon',
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'example' }
TbIcon_TransposeDown class >> Example [ 
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

e1:=TbIcon_TransposeUp new.

container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'initialization' }
TbIcon_TransposeDown >> initializeIcon [ 

	|e1 e2 e3 e4 e5|
	e1:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@28;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:10@ 0. 
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
			t translateBy:8@ -3. 
			t rotateBy: -35.
		].
	e3:= BlElement new
    geometry: BlEllipseGeometry new;
    size: 15@15;
    background: (Color veryVeryDarkGray alpha:1.0) ;
		border: (BlBorder paint: (Color veryVeryDarkGray ) width: 2);
	constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignCenter.
				];
				transformDo: [ :t|
			t translateBy:0@ -4. 
			
		].
	e4:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
									 (35 @ 0).
                           (40 @ 17).
                           (45 @ -2).
                           (50 @ 10) });
          size: 10 @ 30;
          background: Color veryVeryDarkGray ;
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2).
	
	e5:= BlElement new
          geometry: (BlBezierCurveGeometry controlPoints: {
                           
									 (35 @ 8).
                           (40 @ 25).
                           (45 @ 6).
                           (50 @ 18) });
          size: 10 @ 30;
          background: Color veryVeryDarkGray ;
          outskirts: BlOutskirts centered;
          border: (BlBorder paint: Color veryVeryDarkGray width:2).

	
	self addChildren: { e1 . e2. e3. e4. e5}.
]
