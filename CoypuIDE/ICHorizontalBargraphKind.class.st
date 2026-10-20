"
I am a Faust _hbargraph_, a horizontal meter. JUCE has no stock meter: it needs a meter component and an editor Timer.
"
Class {
	#name : 'ICHorizontalBargraphKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICHorizontalBargraphKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitHorizontalBargraph: aParameter
]
