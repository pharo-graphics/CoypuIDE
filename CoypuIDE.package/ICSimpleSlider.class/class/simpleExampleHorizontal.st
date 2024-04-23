example
simpleExampleHorizontal
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beHorizontal.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider currentValue asRopedText.

	slider
		addEventHandlerOn: BlSliderValueChangedEvent
		do: [ textElt text: slider currentValue asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace