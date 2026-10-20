Class {
	#name : 'ICVerticalSliderKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICVerticalSliderKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitVerticalSlider: aParameter
]
