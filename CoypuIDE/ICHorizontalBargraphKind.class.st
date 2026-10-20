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
