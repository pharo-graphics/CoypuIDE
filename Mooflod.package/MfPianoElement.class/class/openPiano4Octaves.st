examples
openPiano4Octaves

	<script>
	| space aPiano |
	space := BlSpace new.
	space root
		background: Color lightRed;
		layout: BlFlowLayout horizontal.
	aPiano := MfPianoElement new.
	aPiano nOctaves: 4.
	aPiano transformDo: [ :c | c translateBy: 200 @ 200 ].
	space root addChild: aPiano.
	space show.
	^ space