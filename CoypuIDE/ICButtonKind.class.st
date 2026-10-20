Class {
	#name : 'ICButtonKind',
	#superclass : 'ICControlKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICButtonKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitButton: aParameter
]
