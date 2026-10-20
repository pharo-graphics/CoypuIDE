"
I am the abstract kind of the continuous controls: _hslider-, _vslider_ and _nentry_. **[style:knob]** on any of them answers an ICKnobKind instead (fromStyle:).'.

"
Class {
	#name : 'ICSliderKind',
	#superclass : 'ICControlKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'instance creation' }
ICSliderKind class >> fromStyle: aString [
	"[style:knob] turns hslider, vslider and nentry into a knob."

	^ aString = 'knob'
		ifTrue: [ ICKnobKind new ]
		ifFalse: [ self new ]
]
