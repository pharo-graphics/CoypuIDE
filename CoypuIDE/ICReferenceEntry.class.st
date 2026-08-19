"
I describe one entry of the CoypuIDE reference browser: a message/UGen name, the category it belongs to, its value range, a prose summary and a list of code examples.
"
Class {
	#name : 'ICReferenceEntry',
	#superclass : 'Object',
	#instVars : [
		'name',
		'category',
		'range',
		'summary',
		'examples'
	],
	#category : 'CoypuIDE-reference',
	#package : 'CoypuIDE',
	#tag : 'reference'
}

{ #category : 'instance creation' }
ICReferenceEntry class >> name: aString category: aCategory [

	^ self new
		  name: aString;
		  category: aCategory;
		  yourself
]

{ #category : 'accessing' }
ICReferenceEntry >> category [

	^ category ifNil: [ 'Uncategorized' ]
]

{ #category : 'accessing' }
ICReferenceEntry >> category: aString [

	category := aString
]

{ #category : 'accessing' }
ICReferenceEntry >> examples [

	^ examples ifNil: [ examples := OrderedCollection new ]
]

{ #category : 'accessing' }
ICReferenceEntry >> examples: aCollection [

	examples := aCollection asOrderedCollection
]

{ #category : 'testing' }
ICReferenceEntry >> matches: aPattern [

	aPattern isEmptyOrNil ifTrue: [ ^ true ].
	^ (self name includesSubstring: aPattern caseSensitive: false) or: [
		  self summary includesSubstring: aPattern caseSensitive: false ]
]

{ #category : 'accessing' }
ICReferenceEntry >> name [

	^ name ifNil: [ '' ]
]

{ #category : 'accessing' }
ICReferenceEntry >> name: aString [

	name := aString
]

{ #category : 'printing' }
ICReferenceEntry >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(; << self name; nextPut: $)
]

{ #category : 'accessing' }
ICReferenceEntry >> range [  
^ range
]

{ #category : 'accessing' }
ICReferenceEntry >> range: aString [ 

range := aString
]

{ #category : 'accessing' }
ICReferenceEntry >> summary [

	^ summary ifNil: [ '' ]
]

{ #category : 'accessing' }
ICReferenceEntry >> summary: aString [

	summary := aString
]
