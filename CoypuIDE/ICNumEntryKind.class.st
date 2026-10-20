Class {
	#name : 'ICNumEntryKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICNumEntryKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitNumEntry: aParameter
]
