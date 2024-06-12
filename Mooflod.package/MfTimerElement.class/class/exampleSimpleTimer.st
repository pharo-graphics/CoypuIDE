example
exampleSimpleTimer

	<script>
	| timer space |
	space := BlSpace new.
	space root layout: BlBasicLayout new.
	timer := MfTimerElement new value: 10.
	timer transformDo: [ :c | c translateBy: 200 @ 150 ].
	space root addChild: timer.
	space toTheme: MfMooflodTheme new.
	space show.
	^ timer