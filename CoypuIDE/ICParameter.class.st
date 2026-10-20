Class {
	#name : 'ICParameter',
	#superclass : 'Object',
	#instVars : [
		'parameter',
		'kind'
	],
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'instance creation' }
ICParameter class >> on: aPhParameter [
	"The widget Faust declared, resolved once."

	^ self on: aPhParameter kind: (ICControlKind forParameter: aPhParameter)
]

{ #category : 'instance creation' }
ICParameter class >> on: aPhParameter kind: anICControlKind [
	"An explicit kind: the scene overrides what Faust declared."

	^ self new
		initializeParameter: aPhParameter kind: anICControlKind;
		yourself
]

{ #category : 'instance creation' }
ICParameter class >> onAll: aCollection [

	^ aCollection collect: [ :each | self on: each ]
]

{ #category : 'initialization' }
ICParameter >> acceptVisitor: aVisitor [

	^ kind acceptVisitor: aVisitor for: self
]

{ #category : 'accessing' }
ICParameter >> address [
	^ parameter address
]

{ #category : 'accessing' }
ICParameter >> initValue [
	^ parameter initValue
]

{ #category : 'initialization' }
ICParameter >> initializeParameter: aPhParameter kind: anICControlKind [

	parameter := aPhParameter.
	kind := anICControlKind
]

{ #category : 'accessing' }
ICParameter >> isHostParameter [
	^ parameter isHostParameter
]

{ #category : 'accessing' }
ICParameter >> isToggle [
	^ parameter isToggle
]

{ #category : 'accessing' }
ICParameter >> kind [ 
^ kind
]

{ #category : 'accessing' }
ICParameter >> label [
	^ parameter label
]

{ #category : 'accessing' }
ICParameter >> maxValue [
	^ parameter maxValue
]

{ #category : 'accessing' }
ICParameter >> minValue [
	^ parameter minValue

]

{ #category : 'accessing' }
ICParameter >> parameter [ 
^ parameter
]

{ #category : 'accessing' }
ICParameter >> parameterID [
	^ parameter parameterID
]

{ #category : 'accessing' }
ICParameter >> shortName [
	^ parameter shortName
]

{ #category : 'accessing' }
ICParameter >> stepValue [
	^ parameter stepValue
]
