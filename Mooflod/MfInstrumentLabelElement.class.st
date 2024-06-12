Class {
	#name : 'MfInstrumentLabelElement',
	#superclass : 'BlTextElement',
	#category : 'Mooflod-VisualizerRepresentation',
	#package : 'Mooflod',
	#tag : 'VisualizerRepresentation'
}

{ #category : 'initialization' }
MfInstrumentLabelElement >> initialize [

	super initialize.
	self text: ('Instrument :' asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	self text fontSize: 18.
	self transformDo: [ :t | t translateBy: 20 @ 25 ]
]
