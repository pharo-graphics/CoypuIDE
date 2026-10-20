Class {
	#name : 'ICControlKind',
	#superclass : 'Object',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'instance creation' }
ICControlKind class >> fromStyle: aString [
	"[style:knob] turns hslider, vslider and nentry into a knob."

	^ aString = 'knob'
		ifTrue: [ ICKnobKind new ]
		ifFalse: [ self new ]
]

{ #category : 'visiting' }
ICControlKind >> acceptVisitor: aVisitor for: aParameter [

	^ self subclassResponsibility
]
