example
exampleSimpleFilledSquare

	<script>
	| aSquare space |
	aSquare := MfFilledSquareElement new.
	aSquare setValue: 65.
	
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aSquare transformDo: [ :c | c translateBy: 280 @ 150 ].
	space toTheme: MfMooflodTheme new.
	space root addChild: aSquare.
	space show.
	^ aSquare