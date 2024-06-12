examples
exampleSimpleKeyboard

	<script>
	| k space |
	k := MfKeyboardElement new.
	space := BlSpace new.
	space root
		background: Color orange;
		layout: BlFlowLayout horizontal.
	k transformDo: [ :c |
		c rotateBy: -90.
		c translateBy: 50 @ 350 ].
	space root addChild: k.
	space show.
	^ space