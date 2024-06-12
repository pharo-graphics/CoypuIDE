examples
exampleSimplePattern

	<script>
	| patternelem space |
	patternelem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	space root addChild: patternelem.
	space toTheme: MfMooflodTheme new.
	patternelem transformDo: [ :c | c translateBy: 180 @ 200 ].
	space show.
	^ patternelem