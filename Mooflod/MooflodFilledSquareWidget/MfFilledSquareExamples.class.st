Class {
	#name : #MfFilledSquareExamples,
	#superclass : #Object,
	#category : #MooflodFilledSquareWidget
}

{ #category : #'as yet unclassified' }
MfFilledSquareExamples class >> exampleSimpleFilledSquare [

	<script>
	| c |
	c := MfFilledSquareElement new.
	c setValue: 100.
	c openFilledSquare: c
]
