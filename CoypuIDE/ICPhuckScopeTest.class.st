"
I test ICPhuckScope without libphuck: I am the scope's source myself (I answer scopeInto: with a sine of period 100 samples).
"
Class {
	#name : 'ICPhuckScopeTest',
	#superclass : 'TestCase',
	#instVars : [
		'scope',
		'position',
		'reads'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'source' }
ICPhuckScopeTest >> scopeInto: aFloatArray [
	"half a sample of phase, so the rising crossings fall cleanly between samples 100 and 101, 200 and 201..."

	reads := reads + 1.
	position ifNil: [ ^ nil ].
	1 to: aFloatArray size do: [ :i | aFloatArray at: i put: (i - 0.5 * 2 * Float pi / 100) sin ].
	^ position
]

{ #category : 'running' }
ICPhuckScopeTest >> setUp [

	super setUp.
	reads := 0.
	position := 0.
	scope := ICPhuckScope on: self
]

{ #category : 'tests' }
ICPhuckScopeTest >> testColorsComeFromTheTheme [

	| theme |
	theme := Smalltalk ui theme.
	self assert: scope backColor equals: theme backgroundColor.
	self assert: scope markerColor equals: theme borderColor.
	self assert: scope traceColor equals: theme successTextColor
]

{ #category : 'tests' }
ICPhuckScopeTest >> testDefaultExtent [

	| world expected |
	world := scope currentWorld extent.
	expected := (world x / 4) rounded @ (world y / 5) rounded.
	self assert: scope defaultExtent equals: expected.
	"an element has its size only after a layout pass"
	scope forceLayout.
	self assert: scope extent equals: expected
]

{ #category : 'tests' }
ICPhuckScopeTest >> testNotRunningSourceIsIgnored [

	position := nil.
	scope refresh.
	self assert: reads equals: 1.
	self assert: (scope samples allSatisfy: [ :s | s = 0.0 ])
]

{ #category : 'tests' }
ICPhuckScopeTest >> testRefreshReadsTheSource [

	scope refresh.
	self assert: reads equals: 1.
	"the samples are 32-bit floats"
	self assert: (scope samples at: 26) closeTo: (25.5 * 2 * Float pi / 100) sin precision: 1.0e-6
]

{ #category : 'tests' }
ICPhuckScopeTest >> testSpanIsClamped [

	scope span: 1.
	self assert: scope span equals: 2.
	scope span: 1000000.
	self assert: scope span equals: scope samples size // 2
]

{ #category : 'tests' }
ICPhuckScopeTest >> testTriggerIsTheLatestRisingCrossing [
	"span 1024 of 2048 samples: the search starts at 1025, the latest crossing before it is at 1001"

	scope refresh.
	self assert: scope triggerIndex equals: 1001
]

{ #category : 'tests' }
ICPhuckScopeTest >> testTriggerOnSilenceIsTheStart [

	self assert: scope triggerIndex equals: 1
]

{ #category : 'tests' }
ICPhuckScopeTest >> testVerticesOnePerColumnInside [

	| vertices |
	scope refresh.
	vertices := scope verticesFor: 300 @ 100.
	self assert: vertices size equals: 300.
	self assert: vertices first x equals: 0.
	self assert: vertices last x equals: 299.
	self assert: (vertices allSatisfy: [ :p | p y between: 0 and: 100 ]).
	"the trace starts on the rising crossing, so at mid height"
	self assert: (vertices first y - 50) abs < 5
]
