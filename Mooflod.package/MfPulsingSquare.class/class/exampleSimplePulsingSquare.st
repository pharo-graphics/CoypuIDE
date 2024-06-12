example
exampleSimplePulsingSquare

	<script>
	| space aSquare |
	space := BlSpace new.
	space root layout: BlFlowLayout horizontal.
	aSquare :=  MfPulsingSquare new.
	aSquare transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: aSquare.
	space show.
	^ aSquare
