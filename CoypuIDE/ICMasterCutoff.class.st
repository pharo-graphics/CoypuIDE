Class {
	#name : #ICMasterCutoff,
	#superclass : #BlElement,
	#instVars : [
		'currentValue',
		'minValue',
		'maxValue',
		'line'
	],
	#category : #'CoypuIDE-cutoff'
}

{ #category : #accessing }
ICMasterCutoff >> currentValue [ 

	^ currentValue 
]

{ #category : #accessing }
ICMasterCutoff >> currentValue: aNumber [

	| newX | 
	currentValue := aNumber.
	aNumber > self maxValue ifTrue: [ currentValue := self maxValue ].
	aNumber < self minValue ifTrue: [ currentValue := self minValue ].
	newX := self valueToPosition: currentValue.
	self line position: newX @ 150
]

{ #category : #'as yet unclassified' }
ICMasterCutoff >> defaultLine [

	| curve firstLine secondLine container |
	curve := BlElement new
		         background: Color transparent;
		         border: (BlBorder paint: Color green width: 5);
		         outskirts: BlOutskirts centered;
		         geometry: (BlBezierCurveGeometry controlPoints: {
						          (0 @ 0).
						          (50 @ 0).
						          (100 @ 200).
						          (150 @ 200) }).

	firstLine := BlElement new
		             geometry: (BlLineGeometry from: -1000 @ 0 to: 0 @ 0);
		             border: (BlBorder paint: Color green width: 5);
		             outskirts: BlOutskirts centered.

	"secondLine := BlElement new
		              geometry:
			              (BlLineGeometry from: 150 @ 200 to: 1000 @ 200);
		              border: (BlBorder paint: Color lightRed width: 5);
		              outskirts: BlOutskirts centered."

	container := BlElement new
		             clipChildren: false;
		             position: 0 @ 150.

	container addChildren: {
			firstLine.
			curve
			"secondLine" }.


	^ container
]

{ #category : #initialization }
ICMasterCutoff >> initialize [

	super initialize.
	self size: 500 @ 300.
	self background: Color veryVeryLightGray.
	self initializeDefaultValues.
	self initializeLine.
]

{ #category : #accessing }
ICMasterCutoff >> initializeDefaultValues [ 

	minValue := 0.
	maxValue := 100.
	currentValue := 0.
]

{ #category : #initialization }
ICMasterCutoff >> initializeLine [

	self line: self defaultLine.
	self addChild: line
]

{ #category : #accessing }
ICMasterCutoff >> line [

 ^ line
]

{ #category : #accessing }
ICMasterCutoff >> line: aBlElement [

	line := aBlElement 
]

{ #category : #accessing }
ICMasterCutoff >> maxValue [

	^ maxValue
]

{ #category : #accessing }
ICMasterCutoff >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
ICMasterCutoff >> minValue [

	^ minValue
]

{ #category : #accessing }
ICMasterCutoff >> minValue: aNumber [

	minValue := aNumber
]

{ #category : #'as yet unclassified' }
ICMasterCutoff >> valueToPosition: aNumber [

	| normalized mapped |
	normalized := aNumber - self minValue
	              / (self maxValue - self minValue).
	mapped := normalized * (self width - 40).
	^ mapped
]
