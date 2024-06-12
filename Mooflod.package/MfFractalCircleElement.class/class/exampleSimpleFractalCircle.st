example
exampleSimpleFractalCircle

	<script>
	| c space | 
	c := MfFractalCircleElement new.
	c setValue: 100.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	c transformDo: [ :c | c translateBy: 200 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: c.
	space show.
	^ c