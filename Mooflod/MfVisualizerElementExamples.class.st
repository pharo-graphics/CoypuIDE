Class {
	#name : 'MfVisualizerElementExamples',
	#superclass : 'Object',
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'as yet unclassified' }
MfVisualizerElementExamples class >> exampleVisualizer [

	<script>
	| v |
	v := MfVisualizerElement new level: 2.
	v addInstrument: 'Kick'.
	v level: 1.
	v addInstrument: 'Snare'.
	v initAnimation: 8 * 16.
	v openVisualizer: v
]
