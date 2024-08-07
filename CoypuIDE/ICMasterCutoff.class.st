Class {
	#name : 'ICMasterCutoff',
	#superclass : 'BlElement',
	#instVars : [
		'value',
		'minValue',
		'maxValue',
		'line'
	],
	#category : 'CoypuIDE-cutoff',
	#package : 'CoypuIDE',
	#tag : 'cutoff'
}

{ #category : 'as yet unclassified' }
ICMasterCutoff class >> exampleLinearSlider [

	| master slider container textElt |
	master := self new.

	slider := ICSlider new.

	container := BlElement new layout: BlLinearLayout vertical;constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	container addChild: master.
	container addChild: slider.

	slider minValue: master minValue.
	slider maxValue: master maxValue.

	textElt := BlTextElement new text: slider minValue asRopedText.
	container addChild: textElt.

	slider callBack: [ :value |
		master setValue: value.
		textElt text: value asRopedText ].

	container openInSpace
]

{ #category : 'as yet unclassified' }
ICMasterCutoff class >> exampleLogarithmicSlider [

	| master slider container textElt |
	master := self new.

	slider := ICLogarithmicSlider new.

	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ].

	container addChild: master.
	container addChild: slider.

	slider minValue: master minValue.
	slider maxValue: master maxValue.

	textElt := BlTextElement new text: slider minValue asRopedText.
	container addChild: textElt.

	slider callBack: [ :value |
		master setValue: value.
		textElt text: value asRopedText ].

	container openInSpace
]

{ #category : 'as yet unclassified' }
ICMasterCutoff >> defaultLine [

	| curve firstLine secondLine container |
	curve := BlElement new
		         background: Color transparent;
		         border: (BlBorder paint: Color green width: 5);
		         outskirts: BlOutskirts centered;
		         geometry: (BlBezierCurveGeometry controlPoints: {
						          (0 @ 0).
						          (12.5 @ 0).
						          (25 @ 50).
						          (37.5 @ 50)
						          "  (0 @ 0).
						          (50 @ 0).
						          (100 @ 200).
						          (150 @ 200) " }).

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
		             position: 0 @ 37.5.

	container addChildren: {
			firstLine.
			curve }.

	^ container
]

{ #category : 'initialization' }
ICMasterCutoff >> initialize [

	super initialize.
	self size: 125 @ 75.
	self background: Color black.
	self initializeLine.
	self initializeDefaultValues.
	
]

{ #category : 'accessing' }
ICMasterCutoff >> initializeDefaultValues [

	minValue := 20.
	maxValue := 22000.
	self whenLayoutedDoOnce: [  self setValue: 20000].
]

{ #category : 'initialization' }
ICMasterCutoff >> initializeLine [

	self line: self defaultLine.
	self addChild: line
]

{ #category : 'accessing' }
ICMasterCutoff >> line [

 ^ line
]

{ #category : 'accessing' }
ICMasterCutoff >> line: aBlElement [

	line := aBlElement 
]

{ #category : 'accessing' }
ICMasterCutoff >> maxValue [

	^ maxValue
]

{ #category : 'accessing' }
ICMasterCutoff >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : 'accessing' }
ICMasterCutoff >> minValue [

	^ minValue
]

{ #category : 'accessing' }
ICMasterCutoff >> minValue: aNumber [

	minValue := aNumber
]

{ #category : 'accessing' }
ICMasterCutoff >> setValue: aNumber [

	| newX |
	value := aNumber.
	aNumber > self maxValue ifTrue: [ value := self maxValue ].
	aNumber < self minValue ifTrue: [ value := self minValue ].
	newX := self valueToPosition: value.
	self line position: newX @ 37.5
]

{ #category : 'accessing' }
ICMasterCutoff >> value [

	^ value
]

{ #category : 'as yet unclassified' }
ICMasterCutoff >> valueToPosition: aNumber [

	| minP maxP minV maxV scale result |
	minP := 0.
	maxP := self width - 10.
	minV := self minValue ln.
	maxV := self maxValue ln.

	scale := maxV - minV / (maxP - minP).

	result := aNumber ln - minV / scale + minP.

	^ result
]
