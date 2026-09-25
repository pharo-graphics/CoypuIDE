Class {
	#name : 'CoypuLogElement',
	#superclass : 'ToElement',
	#instVars : [
		'list',
		'maxEntries',
		'colors',
		'loggers'
	],
	#category : 'CoypuIDE-Logging',
	#package : 'CoypuIDE',
	#tag : 'Logging'
}

{ #category : 'initialization' }
CoypuLogElement >> basicAddEntry: aSignal [
	list dataAccessor add: aSignal.
	list dataAccessor size > maxEntries ifTrue: [ list dataAccessor removeFirst ]
]

{ #category : 'initialization' }
CoypuLogElement >> entryCount [
	^ list dataAccessor size
]

{ #category : 'initialization' }
CoypuLogElement >> initialize [

	super initialize.
	maxEntries := 500.
	colors := Dictionary new.
	loggers := OrderedCollection new.
	list := ToListElement new
		        nodeBuilder: [ :node :holder |
			        node addChild: (self labelFor: holder dataItem) ];
		        constraintsDo: [ :c |
				        c horizontal matchParent.
				        c vertical matchParent ];
		        yourself.
	self
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
		addChild: list
]
