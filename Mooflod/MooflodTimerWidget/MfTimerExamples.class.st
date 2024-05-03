Class {
	#name : #MfTimerExamples,
	#superclass : #Object,
	#category : #MooflodTimerWidget
}

{ #category : #'as yet unclassified' }
MfTimerExamples class >> exampleSimpleTimer [

	<script>
	| timer |
	timer := MfTimerElement new value: 10.
	timer openTimer: timer
]
