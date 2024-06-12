example
openInputWithSkin

	<script>
	| space anInput |
	space := BlSpace new.
	space toTheme: MfMooflodTheme new.
	anInput := self new position: 200 @ 200.
	space root addChild: anInput.
	space show.
	^ anInput