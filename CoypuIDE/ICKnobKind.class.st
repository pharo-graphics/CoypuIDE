Class {
	#name : 'ICKnobKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICKnobKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitKnob: aParameter

]
