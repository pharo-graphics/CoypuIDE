Class {
	#name : #MfFractalCircleExamples,
	#superclass : #Object,
	#category : #MooflodFractalCircleWidget
}

{ #category : #'as yet unclassified' }
MfFractalCircleExamples class >> exampleSimpleFractalCircle [

	<script>
	| c |
	c := MfFractalCircleElement new.
	c setValue: 28.
	c openFractalCircle: c
]
