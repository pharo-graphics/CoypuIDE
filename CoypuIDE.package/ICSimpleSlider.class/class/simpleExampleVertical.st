example
simpleExampleVertical
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beVertical.
	textElt := BlTextElement new position: 40 @ 100.

	textElt text: slider currentValue asRopedText.

	slider
		addEventHandlerOn: BlSliderValueChangedEvent
		do: [ textElt text: slider currentValue asRopedText ].




	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace