as yet unclassified
exampleVisualizer

	<script>
	| v |
	v := MfVisualizerElement new level: 2.
	v addInstrument: 'Kick'.
	"v level: 1."
	v addInstrument: 'Snare'.
	v initAnimation: 8 * 16.
	v openVisualizer: v