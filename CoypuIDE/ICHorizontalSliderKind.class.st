Class {
	#name : 'ICHorizontalSliderKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICHorizontalSliderKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitHorizontalSlider: aParameter
]
