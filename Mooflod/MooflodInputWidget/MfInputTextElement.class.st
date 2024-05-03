Class {
	#name : #MfInputTextElement,
	#superclass : #BlTextElement,
	#category : #MooflodInputWidget
}

{ #category : #initialization }
MfInputTextElement >> initialize [ 

super initialize .
self text: ('Input' asRopedText attributes:  { (BlTextForegroundAttribute paint: Color white)}).
self text fontSize: 25.
self constraintsDo: [ :c |
	c frame horizontal alignCenter ].
self transformDo: [ :t |
	t translateBy: 0@10].
]
