Extension { #name : 'BlElement' }

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
		add: #button -> #ICLabelButton.

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
