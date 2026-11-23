Class {
	#name : 'DSPDisplayUITest',
	#superclass : 'TestCase',
	#instVars : [
		'dsps',
		'spaces'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
DSPDisplayUITest >> meterIn: anElement [

	^ anElement allChildrenBreadthFirstDetect: [ :each | each isKindOf: ICValueDisplay ] ifFound: [ :each | each ] ifNone: [ nil ]
]

{ #category : 'running' }
DSPDisplayUITest >> newDsp [
	"initialized, never started: no sound"

	| dsp |
	dsp := DSP create:
		       'import("stdfaust.lib"); process = _ * hgroup("amp", hslider("g", 0.5, 0, 1, 0.01)) : hbargraph("meter", 0, 1);'.
	dsp init.
	^ dsps add: dsp
]

{ #category : 'running' }
DSPDisplayUITest >> setUp [

	super setUp.
	dsps := OrderedCollection new.
	spaces := OrderedCollection new
]

{ #category : 'running' }
DSPDisplayUITest >> tearDown [

	spaces do: [ :each | each isOpened ifTrue: [ each close ] ].
	dsps do: [ :each | each destroy ].
	super tearDown
]

{ #category : 'tests' }
DSPDisplayUITest >> testClosingOneWindowStopsOnlyItsBargraphs [

	| dsp first second |
	dsp := self newDsp.
	first := (ICFaustUIBuilder forDsp: dsp) build.
	second := (ICFaustUIBuilder forDsp: dsp) build.
	dsp stopValueDisplaysIn: first.
	self deny: (self meterIn: first) shouldUpdate.
	self assert: (self meterIn: second) shouldUpdate
]

{ #category : 'tests' }
DSPDisplayUITest >> testClosingTheWindowForgetsTheSubscription [

	| dsp space |
	dsp := self newDsp.
	space := spaces add: dsp displayUI.
	self assert: (self waitUntil: [ space isOpened ]).
	space close.
	self assert: (self waitUntil: [ dsp announcer numberOfSubscriptions = 0 ]).
	dsp destroy
]

{ #category : 'tests' }
DSPDisplayUITest >> testDestroyStopsTheBargraphs [

	| dsp meter |
	dsp := self newDsp.
	meter := (ICFaustUIBuilder forDsp: dsp) build
		         allChildrenBreadthFirstDetect: [ :each | each isKindOf: ICValueDisplay ]
		         ifFound: [ :each | each ]
		         ifNone: [ nil ].
	self assert: meter shouldUpdate.
	dsp destroy.
	self deny: meter shouldUpdate
]

{ #category : 'tests' }
DSPDisplayUITest >> testDisplayUIClosesWhenItsDspIsDestroyed [

	| dsp space |
	dsp := self newDsp.
	space := spaces add: dsp displayUI.
	self assert: (self waitUntil: [ space isOpened ]).
	dsp destroy.
	self assert: (self waitUntil: [ space isOpened not ]).
	self assert: dsp displayedUI isNil
]

{ #category : 'running' }
DSPDisplayUITest >> waitUntil: aBlock [

	| start |
	start := Time millisecondClockValue.
	[ aBlock value or: [ Time millisecondClockValue - start > 3000 ] ] whileFalse: [ 20 milliSeconds wait ].
	^ aBlock value
]
