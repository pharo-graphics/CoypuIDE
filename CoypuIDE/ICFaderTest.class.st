Class {
	#name : 'ICFaderTest',
	#superclass : 'TestCase',
	#instVars : [
		'fader'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'helper' }
ICFaderTest >> requestedExtentOf: anElement [
	"#extent only reflects reality after a layout pass; a detached element
	 reports 0@0. Read the exact resizer installed by #size: instead."

	| h v |
	h := anElement constraints horizontal resizer.
	v := anElement constraints vertical resizer.
	self assert: h class equals: BlLayoutExactResizer.
	self assert: v class equals: BlLayoutExactResizer.
	^ h size @ v size

]

{ #category : 'helper' }
ICFaderTest >> requestedPositionOf: anElement [
	^ anElement constraints position


]

{ #category : 'running' }
ICFaderTest >> setUp [
	super setUp.
	fader := ICFader new
]

{ #category : 'tests' }
ICFaderTest >> testApplySizeIsIdempotent [
	| before |
	fader barLength: 200 thickness: 40.
	before := {
		          (self requestedExtentOf: fader).
		          (self requestedExtentOf: fader bar).
		          (self requestedExtentOf: fader handle) }.
	fader applySize.
	fader applySize.
	self assert: {
			(self requestedExtentOf: fader).
			(self requestedExtentOf: fader bar).
			(self requestedExtentOf: fader handle) } equals: before
]

{ #category : 'tests' }
ICFaderTest >> testBarFitsInsideWidget [
	#( 60 140 260 ) do: [ :len |
		fader barLength: len.
		self assert: fader barOrigin x + fader barLength
			<= fader widgetExtent x ]
]

{ #category : 'helper' }
ICFaderTest >> testBarLengthUpdatesBarSize [
	fader barLength: 200.
	self assert: (self requestedExtentOf: fader bar) equals: 200 @ 20
]

{ #category : 'helper' }
ICFaderTest >> testBarThicknessUpdatesBarSize [
	fader barThickness: 40.
	self assert: (self requestedExtentOf: fader bar) equals: 100 @ 40

]

{ #category : 'helper' }
ICFaderTest >> testBatchSetterAppliesBoth [
	fader barLength: 200 thickness: 40.
	self assert: (self requestedExtentOf: fader bar) equals: 200 @ 40

]

{ #category : 'tests' }
ICFaderTest >> testBeSegmentedWithoutStepValueRaisesError [
	self should: [ fader beSegmented ] raise: Error

]

{ #category : 'tests' }
ICFaderTest >> testBeSmoothLiftsQuantization [
	fader stepValue: 10.
	fader beSegmented.
	fader beSmooth.
	fader setValue: 23.
	self assert: fader value closeTo: 23.0
]

{ #category : 'tests' }
ICFaderTest >> testBeVerticalFlipsBarSize [
	fader beVertical.
	self assert: (self requestedExtentOf: fader bar) equals: 20 @ 100
]

{ #category : 'tests' }
ICFaderTest >> testCallBackIsNilByDefault [
	self assert: fader callBack isNil
]

{ #category : 'helper' }
ICFaderTest >> testDefaultSizesComeFromDefaults [
	self assert: fader barLength equals: fader defaultBarLength.
	self assert: fader barThickness equals: fader defaultBarThickness.
	self assert: fader marginLength equals: fader defaultMarginLength.
	self assert: fader marginThickness equals: fader defaultMarginThickn
]

{ #category : 'tests' }
ICFaderTest >> testFontSizeFollowsBarThickness [
	fader barThickness: 40.
	self assert: fader fontSize equals: 30
]

{ #category : 'tests' }
ICFaderTest >> testHandleThicknessFollowsBarThickness [
	fader barThickness: 40.
	self assert: (self requestedExtentOf: fader handle) y equals: 40
]

{ #category : 'tests' }
ICFaderTest >> testIncrementValue [
	fader setValue: 20.
	fader incrementValue: 5.
	self assert: fader value closeTo: 25.0
]

{ #category : 'tests' }
ICFaderTest >> testInitializeLabelIsIdempotent [
	| f |
	f := ICFader label: 'Gain'.
	f initializeLabel.
	f initializeLabel.
	self assert: (self textChildrenOf: f) size equals: 4
]

{ #category : 'helper' }
ICFaderTest >> testMarginLengthMovesBarOrigin [
	fader marginLength: 30.
	self assert: (self requestedPositionOf: fader bar) x equals: 30

]

{ #category : 'tests' }
ICFaderTest >> testMinAndMaxLabelsFollowTheirValues [
	fader minValue: 10.
	fader maxValue: 90.
	self assert: fader minLabel text asString equals: '10'.
	self assert: fader maxLabel text asString equals: '90'
]

{ #category : 'tests' }
ICFaderTest >> testNamedFaderHasFourLabels [
	| f |
	f := ICFader label: 'Gain'.
	self assert: (self textChildrenOf: f) size equals: 4
]

{ #category : 'tests' }
ICFaderTest >> testOrientationCanBeSwitchedBack [
	fader beVertical.
	fader beHorizontal.
	self assert: (self requestedExtentOf: fader bar) equals: 100 @ 20
]

{ #category : 'tests' }
ICFaderTest >> testOrientationDoesNotDestroyLabels [
	fader beVertical.
	self assert: (self textChildrenOf: fader) size equals: 3.
	fader beHorizontal.
	self assert: (self textChildrenOf: fader) size equals: 3
]

{ #category : 'tests' }
ICFaderTest >> testOrientationPreservesValue [
	fader setValue: 25.
	fader beVertical.
	self assert: fader value closeTo: 25.0
]

{ #category : 'helper' }
ICFaderTest >> testResetSizeRestoresDefaults [
	fader barLength: 300 thickness: 60.
	fader resetSize.
	self assert: fader barLength equals: fader defaultBarLength.
	self assert: fader barThickness equals: fader defaultBarThickness
]

{ #category : 'tests' }
ICFaderTest >> testResizingPreservesValue [
	fader setValue: 25.
	fader barLength: 300 thickness: 50.
	self assert: fader value closeTo: 25.0

]

{ #category : 'tests' }
ICFaderTest >> testSegmentedQuantizesValue [
	fader stepValue: 10.
	fader beSegmented.
	fader setValue: 23.
	self assert: fader value closeTo: 20.0
]

{ #category : 'tests' }
ICFaderTest >> testSetToMax [
	fader setToMax.
	self assert: fader value closeTo: fader maxValue

]

{ #category : 'tests' }
ICFaderTest >> testSetToMin [
	fader setToMin.
	self assert: fader value closeTo: fader minValue
]

{ #category : 'tests' }
ICFaderTest >> testSetValueClampsAboveMax [
	fader setValue: 999.
	self assert: fader value closeTo: fader maxValue
]

{ #category : 'tests' }
ICFaderTest >> testSetValueClampsBelowMin [
	fader setValue: -999.
	self assert: fader value closeTo: fader minValue
]

{ #category : 'tests' }
ICFaderTest >> testSetValueRoundTrip [
	fader setValue: 25.
	self assert: fader value closeTo: 25.0
]

{ #category : 'tests' }
ICFaderTest >> testShrinkingWorksTooNotOnlyGrowing [
	fader barLength: 300.
	fader barLength: 80.
	self assert: (self requestedExtentOf: fader bar) x equals: 80
]

{ #category : 'tests' }
ICFaderTest >> testSizeSettersDoNotDestroyLabels [
	fader barLength: 200.
	fader barThickness: 40.
	fader marginLength: 20.
	self assert: (self textChildrenOf: fader) size equals: 3

]

{ #category : 'helper' }
ICFaderTest >> testStartsHorizontal [
	self assert: fader isHorizontal
]

{ #category : 'tests' }
ICFaderTest >> testUserCallBackReceivesValue [
	| seen |
	fader callBack: [ :v | seen := v ].
	fader setToMax.
	self assert: seen closeTo: 50.0
]

{ #category : 'tests' }
ICFaderTest >> testValueLabelUpdatesWithoutAnyCallBack [
	fader setToMax.
	self assert: fader valueLabel text asString equals: '50'
]

{ #category : 'tests' }
ICFaderTest >> testValueToCoordAndBackAreInverse [
	#( 0 10 25 40 50 ) do: [ :v |
		self assert: (fader valueAtCoord: (fader valueToCoord: v))
			closeTo: v ]
]

{ #category : 'tests' }
ICFaderTest >> testValueToCoordAndBackAreInverseWhenVertical [
	fader beVertical.
	#( 0 10 25 40 50 ) do: [ :v |
		self assert: (fader valueAtCoord: (fader valueToCoord: v))
			closeTo: v ]
]

{ #category : 'tests' }
ICFaderTest >> testVerticalIsTallerThanWide [
	fader beVertical.
	self assert: fader widgetExtent y > fader widgetExtent x

]

{ #category : 'helper' }
ICFaderTest >> testWidgetExtentIsApplied [
	self assert: (self requestedExtentOf: fader) equals: fader widgetExtent
]

{ #category : 'helper' }
ICFaderTest >> testWidgetGrowsWithBarLength [
	| before |
	before := fader widgetExtent x.
	fader barLength: fader barLength + 100.
	self assert: fader widgetExtent x equals: before + 100
]

{ #category : 'helper' }
ICFaderTest >> textChildrenOf: anElement [
	^ anElement children select: [ :each | each isKindOf: BlTextElement ]
]
