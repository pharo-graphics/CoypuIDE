"
I am a Faust _vbargraph_, a vertical meter. JUCE has no stock meter: it needs a meter component and an editor Timer.
"
Class {
	#name : 'ICVerticalBargraphKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICVerticalBargraphKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitVerticalBargraph: aParameter
]
