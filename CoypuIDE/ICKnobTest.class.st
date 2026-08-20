Class {
	#name : 'ICKnobTest',
	#superclass : 'TestCase',
	#instVars : [
		'knob'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'running' }
ICKnobTest >> estCallBackIsNilByDefault [
	self assert: knob callBack isNil
]

{ #category : 'running' }
ICKnobTest >> estMarkerIsChildOfKnob [
	self assert: (knob knob hasChild: knob marker)
]

{ #category : 'running' }
ICKnobTest >> estStepValueQuantizesCurrentValue [
	knob stepValue: 10.
	knob setValue: 47.
	self assert: knob currentValue closeTo: 50.0
]

{ #category : 'running' }
ICKnobTest >> setUp [
		super setUp.
	knob := ICKnob new
]

{ #category : 'running' }
ICKnobTest >> testAllSubElementsAreBuilt [
	self deny: knob knob isNil.
	self deny: knob disk isNil.
	self deny: knob outerRing isNil.
	self deny: knob marker isNil.
	self deny: knob minLabel isNil.
	self deny: knob maxLabel isNil.
	self deny: knob currentLabel isNil
]

{ #category : 'running' }
ICKnobTest >> testAngleIsClampedAtMax [
	knob angle: 200.
	self assert: knob angle equals: -135
]

{ #category : 'running' }
ICKnobTest >> testAngleIsClampedAtMin [
	knob angle: -200.
	self assert: knob angle equals: -135
]

{ #category : 'running' }
ICKnobTest >> testApplySizeIsIdempotent [
	| extents |
	knob diameter: 96.
	extents := { knob extent. knob knob extent. knob disk extent.
	             knob outerRing extent. knob marker extent }.
	knob applySize.
	knob applySize.
	self assert: { knob extent. knob knob extent. knob disk extent.
	               knob outerRing extent. knob marker extent } equals: extents

]

{ #category : 'running' }
ICKnobTest >> testCurrentLabelTracksValueWithoutAnyCallBack [
	knob setToMax.
	self assert: knob currentLabel text asString equals: '100.000'
]

{ #category : 'running' }
ICKnobTest >> testDefaultDiameter [
	self assert: knob diameter equals: knob defaultDiameter
]

{ #category : 'running' }
ICKnobTest >> testDefaultExtentFollowsDefaultDiameter [
	self assert: knob extent equals: knob widgetSize asPoint
]

{ #category : 'running' }
ICKnobTest >> testDiameterSetterReturnsSelf [
	self assert: (knob diameter: 96) identicalTo: knob

]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesDiskExtent [
	knob diameter: 96.
	self assert: knob disk extent equals: knob outerRing extent
]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesFontSize [
	knob diameter: 120.
	self assert: knob fontSz equals: 24

]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesKnobExtent [
	knob diameter: 96.
	self assert: knob knob extent equals: 96 @ 96
]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesMarkerExtent [
	knob diameter: 120.
	self assert: knob marker extent equals: 20 @ 40
]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesMarkerPosition [
	knob diameter: 120.
	self assert: knob marker position equals: 50 @ 10
]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesOuterRingExtent [
	knob diameter: 96.
	self assert: knob outerRing extent equals: 160 @ 160
]

{ #category : 'running' }
ICKnobTest >> testDiameterUpdatesOwnExtent [
	knob diameter: 96.
	self assert: knob extent equals: 256 @ 256
]

{ #category : 'tests' }
ICKnobTest >> testForMidi [ 

| knob |
knob := (ICKnob label: 'MidiControl') forMidi.

self assert: knob minValue equals: 0.
self assert: knob maxValue equals: 127.
self assert: knob stepValue equals: 1.
]

{ #category : 'running' }
ICKnobTest >> testForMidiRange [
	knob forMidi.
	self assert: knob minValue equals: 0.
	self assert: knob maxValue equals: 127.
	self assert: knob stepValue equals: 1
]

{ #category : 'running' }
ICKnobTest >> testKnobFitsInsideOuterRing [
	#( 48 96 144 ) do: [ :d |
		knob diameter: d.
		self assert: knob knob extent x < knob outerRing extent x.
		self assert: knob outerRing extent x < knob extent x ]
]

{ #category : 'running' }
ICKnobTest >> testLabelDiameterConstructor [
	| e |
	e := ICKnob label: 'Freq' diameter: 96.
	self assert: e diameter equals: 96.
	self assert: e extent equals: 256 @ 256.
	self assert: e inputText equals: 'Freq'
]

{ #category : 'running' }
ICKnobTest >> testMarkerFitsInsideKnob [
	#( 48 96 144 ) do: [ :d |
		knob diameter: d.
		self assert: knob marker extent x <= knob knob extent x.
		self assert: knob marker position x + knob marker extent x
			<= knob knob extent x ]
]

{ #category : 'running' }
ICKnobTest >> testMarkerIsHorizontallyCentered [
	#( 48 96 144 ) do: [ :d |
		| markerCenter |
		knob diameter: d.
		markerCenter := knob marker position x + (knob marker extent x / 2).
		self assert: markerCenter equals: knob knob extent x / 2 ]
]

{ #category : 'running' }
ICKnobTest >> testMaxValueUpdatesMaxLabel [
	knob maxValue: 20.
	self assert: knob maxLabel text asString equals: '20.0'

]

{ #category : 'running' }
ICKnobTest >> testProportionsAreScaleInvariant [
	| ratios |
	ratios := #( 48 96 144 ) collect: [ :d |
		          knob diameter: d.
		          { (knob knob extent x / knob extent x).
		            (knob outerRing extent x / knob extent x).
		            (knob marker extent x / knob knob extent x) } ].
	self assert: ratios asSet size equals: 1
]

{ #category : 'running' }
ICKnobTest >> testResetSizeRestoresDefaultDiameter [
	knob diameter: 144.
	knob resetSize.
	self assert: knob diameter equals: knob defaultDiameter.
	self assert: knob extent equals: knob widgetSize asPoint
]

{ #category : 'running' }
ICKnobTest >> testResizingDoesNotChangeValue [
	knob setValue: 50.
	knob diameter: 144.
	self assert: knob currentValue closeTo: 50.0
]

{ #category : 'running' }
ICKnobTest >> testSetToMax [
	knob setToMax.
	self assert: knob currentValue closeTo: knob maxValue
]

{ #category : 'running' }
ICKnobTest >> testSetToMin [
	knob setToMin.
	self assert: knob currentValue closeTo: knob minValue

]

{ #category : 'running' }
ICKnobTest >> testShrinkingWorksTooNotOnlyGrowing [
	knob diameter: 144.
	knob diameter: 48.
	self assert: knob extent equals: 128 @ 128.
	self assert: knob knob extent equals: 48 @ 48
]

{ #category : 'running' }
ICKnobTest >> testUserCallBackAndLabelBothUpdate [
	| seen |
	knob callBack: [ :v | seen := v ].
	knob setToMax.
	self assert: seen closeTo: 100.0.
	self assert: knob currentLabel text asString equals: '100.000'
]

{ #category : 'running' }
ICKnobTest >> testUserCallBackReceivesValue [
	| seen |
	seen := OrderedCollection new.
	knob callBack: [ :v | seen add: v ].
	knob setToMax.
	self assert: seen last closeTo: 100.0
]

{ #category : 'running' }
ICKnobTest >> testValueStaysInRangeWhateverTheAngle [
	#( -400 -135 0 135 400 ) do: [ :a |
		knob angle: a.
		self assert: knob currentValue >= knob minValue.
		self assert: knob currentValue <= knob maxValue ]
]

{ #category : 'running' }
ICKnobTest >> testValueToAngleAndBackAreInverse [
	#( 0 25 50 75 100 ) do: [ :v |
		knob setValue: v.
		self assert: knob angleToValue closeTo: v ]
]
