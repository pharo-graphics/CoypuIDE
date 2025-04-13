Extension { #name : 'BlElement' }

{ #category : '*CoypuIDE' }
BlElement >> connectToOSCServer [

	| callback server |
	callback := [ :msg |
	            msg first ifNotNil: [
		            msg last ifNotNil: [
			            (self children
				             detect: [ :el | el inputText = (msg first findBetweenSubstrings: '/') last ]
				             ifNone: [ nil ]) ifNotNil: [ :foundElement |
				            foundElement setValue: msg last ] ] ] ].

	server := OSCServer new messageCalback: callback.
	^ server
]

{ #category : '*CoypuIDE' }
BlElement >> fromDictionary: aDictionary [
	"creates a UI element from a Dictionary"

	| widgetDictionary |
	widgetDictionary := Dictionary new
		                    add: #hslider -> #ICDarkKnob3;
		                    add: #button -> #ICOnOffButton.

	^ (self class environment at:
		   (widgetDictionary at: (aDictionary at: #type))) fromDictionary:
		  aDictionary
]

{ #category : '*CoypuIDE' }
BlElement >> fromDictionary: aDictionary forDsp: aDsp [
	"creates a UI element from a Dictionary"

	| widgetDictionary |
	widgetDictionary := Dictionary new.
	widgetDictionary
		add: #hslider -> #ICDarkKnob3;
		add: #vslider -> #ICDarkKnob3;
		add: #button -> #ICLabelButton;
		add: #hbargraph -> #ICValueDisplay;
		add: #nentry -> #ICNentry;
		add: #checkbox -> #ICLabelButton.
	^ (self class environment at:
		   (widgetDictionary at: (aDictionary at: #type)))
		  fromDictionary: aDictionary
		  forDsp: aDsp
]

{ #category : '*CoypuIDE' }
BlElement >> removeGateAndFreqElement [

"remove button and knob labeled freq and gate from a Phauso UI"
| childToRemove |
childToRemove := self children select: [ :l | (l inputText = 'freq') or: (l inputText = 'gate')  ].
childToRemove do: [ :e | self removeChild: e ]
]
