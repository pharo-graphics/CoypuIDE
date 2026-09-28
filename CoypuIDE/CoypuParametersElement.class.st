Class {
	#name : 'CoypuParametersElement',
	#superclass : 'BlElement',
	#instVars : [
		'parameters',
		'columns',
		'filterField'
	],
	#category : 'CoypuIDE-Logging',
	#package : 'CoypuIDE',
	#tag : 'Logging'
}

{ #category : 'instance creation' }
CoypuParametersElement class >> colorRules [
	"Ordered: first matching suffix wins ('freq' before 'q')"

	^ {
		  #( 'trigger' ) -> Color red.
		  #( 'freq' ) -> Color cyan.
		  #( 'level' 'gain' ) -> Color yellow.
		  #( 'attack' 'decay' 'sustain' 'release' ) -> Color green.
		  #( 'cutoff' 'q' 'resonance' 'envmod' ) -> Color orange.
		  #( 'index' 'ratio' ) -> Color magenta }
]

{ #category : 'instance creation' }
CoypuParametersElement class >> on: aCollection [
	^ self new
		setParameters: aCollection;
		yourself
]

{ #category : 'accessing' }
CoypuParametersElement >> colorFor: aName [
	| name |
	name := aName asLowercase.
	^ (self class colorRules
		detect: [ :rule | rule key anySatisfy: [ :suffix | name endsWith: suffix ] ]
		ifNone: [ nil -> Color lightGray ]) value
]

{ #category : 'accessing' }
CoypuParametersElement >> columnFor: aCollection [
	^ BlElement new
		layout: (BlLinearLayout vertical cellSpacing: 2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: (aCollection collect: [ :each | self labelFor: each ]);
		yourself
]

{ #category : 'displaying' }
CoypuParametersElement >> displayedNames [
	^ columns children flatCollect: [ :column | column children collect: [ :each | each text asString ] ]
]

{ #category : 'accessing' }
CoypuParametersElement >> filter: aString [
	filterField text: aString.
	self refresh
]

{ #category : 'initialization' }
CoypuParametersElement >> initialize [
	super initialize.
	parameters := #().
	filterField := ToTextField new
		placeholderText: 'Filter';
		whenTextEditedDo: [ self refresh ];
		yourself.
	columns := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 16);
		padding: (BlInsets all: 8);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		yourself.
	self
		layout: (BlLinearLayout vertical cellSpacing: 8);
		padding: (BlInsets all: 8);
		background: Color black;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChildren: {
			filterField.
			(columns asScrollableElement constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ]) }
]

{ #category : 'accessing' }
CoypuParametersElement >> labelFor: aName [
	^ ToLabel new
		text: (aName asRopedText
			foreground: (self colorFor: aName);
			fontName: 'Source Code Pro';
			fontSize: 13);
		yourself
]

{ #category : 'accessing' }
CoypuParametersElement >> refresh [
	| names perColumn |
	names := self visibleParameters.
	perColumn := (names size / 4) ceiling max: 1.
	columns removeChildren.
	columns addChildren: ((1 to: names size by: perColumn) collect: [ :start |
		self columnFor: (names copyFrom: start to: (start + perColumn - 1 min: names size)) ])
]

{ #category : 'initialization' }
CoypuParametersElement >> setParameters: aCollection [
	parameters := aCollection sorted: [ :a :b | a asLowercase < b asLowercase ].
	self refresh
]

{ #category : 'accessing' }
CoypuParametersElement >> visibleParameters [
	| filter |
	filter := filterField text asString.
	filter isEmpty ifTrue: [ ^ parameters ].
	^ parameters select: [ :each | each includesSubstring: filter caseSensitive: false ]
]
