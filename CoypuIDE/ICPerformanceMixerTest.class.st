Class {
	#name : 'ICPerformanceMixerTest',
	#superclass : 'TestCase',
	#instVars : [
		'performed',
		'mixer'
	],
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'helpers' }
ICPerformanceMixerTest >> faderNamed: aString [

	^ ICTurboGainFader
		  label: aString
		  min: 0
		  max: 1
		  value: 0.5
		  step: 0.01
		  callBack: [ :value |  ]
]

{ #category : 'helpers' }
ICPerformanceMixerTest >> fakeDspSending: aCollection [
	"a DSP with three UI items, two of them levels; setValue:parameter: adds parameter -> value to aCollection"

	| class items |
	items := Dictionary new.
	items
		at: 'kickuLevel' put: (Dictionary new
				 at: #shortname put: 'kickuLevel';
				 at: #min put: 0;
				 at: #max put: 1;
				 at: #init put: 0.4;
				 at: #step put: 0.01;
				 yourself);
		at: 'acidLevel' put: (Dictionary new
			 at: #shortname put: 'acidLevel';
			 at: #min put: 0;
			 at: #max put: 2;
			 at: #init put: 1;
			 at: #step put: 0.01;
			 yourself);
		at: 'acidCutoff' put: (Dictionary new
			 at: #shortname put: 'acidCutoff';
			 at: #min put: 20;
			 at: #max put: 2000;
			 at: #init put: 500;
			 at: #step put: 1;
			 yourself).
	class := DSP newAnonymousSubclass.
	class compile: 'getUIItemsLabeledDictionary ^ self class items'.
	class compile: 'setValue: aFloat parameter: aString self class sent add: aString -> aFloat'.
	class class addInstVarNamed: 'items sent'.
	class class compile: 'items ^ items'.
	class class compile: 'sent ^ sent'.
	class class compile: 'items: aDictionary sent: aCollection items := aDictionary. sent := aCollection'.
	class items: items sent: aCollection.
	^ class basicNew
]

{ #category : 'running' }
ICPerformanceMixerTest >> setUp [

	super setUp.
	performed := Set new.
	mixer := ICPerformanceMixer title: 'test'.
	mixer performedNames: [ performed ].
	#( 'master' 'acid' 'kick' 'snare' ) do: [ :each | mixer add: (self faderNamed: each) for: each ].
	mixer alwaysShow: 'master'
]

{ #category : 'helpers' }
ICPerformanceMixerTest >> shownNames [

	^ mixer element children asArray collect: [ :each | each name ]
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testDspInstrumentNameForLevel [

	| dsp |
	dsp := DSP basicNew.
	self assert: (dsp instrumentNameForLevel: 'kickuLevel') equals: 'kick'.
	self assert: (dsp instrumentNameForLevel: 'acidLevel') equals: 'acid'.
	self assert: (dsp instrumentNameForLevel: 'cutoff') equals: 'cutoff'
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testDspLevelMixerHasOneFaderPerLevel [

	| levels |
	levels := (self fakeDspSending: OrderedCollection new) levelMixerTitled: 'Levels'.
	self assert: levels faders keys asArray equals: #( 'acid' 'kick' ).
	self assert: (levels faders at: 'acid') maxValue equals: 2.
	self assert: (levels faders at: 'kick') value closeTo: 0.4
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testDspLevelMixerSendsToItsParameter [

	| sent levels |
	sent := OrderedCollection new.
	levels := (self fakeDspSending: sent) levelMixerTitled: 'Levels'.
	self assert: sent isEmpty.
	(levels faders at: 'kick') setValue: 0.7.
	self assert: sent size equals: 1.
	self assert: sent first key equals: 'kickuLevel'.
	self assert: sent first value closeTo: 0.7
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testDspLevelMixerShowsNothingWithoutPerformance [

	| levels |
	levels := (self fakeDspSending: OrderedCollection new) levelMixerTitled: 'Levels'.
	levels performedNames: [ #(  ) ].
	self assert: levels element children asArray equals: { levels emptyElement }.
	levels performedNames: [ #( #kick ) ].
	levels refresh.
	self assert: (levels element children asArray collect: [ :each | each name ]) equals: #( 'kick' )
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testHiddenFaderKeepsItsValue [

	| kick |
	kick := mixer faders at: 'kick'.
	performed add: 'kick'.
	mixer refresh.
	kick setValue: 0.8.
	performed remove: 'kick'.
	mixer refresh.
	self deny: (self shownNames includes: 'kick').
	performed add: 'kick'.
	mixer refresh.
	self assert: (mixer element children includes: kick).
	self assert: kick value closeTo: 0.8
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testOnlyAlwaysShownWithEmptyPerformance [

	self assert: self shownNames equals: #( 'master' )
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testPerformedNamesMayBeSymbols [

	performed add: #snare.
	mixer refresh.
	self assert: self shownNames equals: #( 'master' 'snare' )
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testRefreshFollowsThePerformanceInMixerOrder [

	performed addAll: #( 'snare' 'acid' ).
	mixer refresh.
	self assert: self shownNames equals: #( 'master' 'acid' 'snare' ).
	performed remove: 'acid'.
	mixer refresh.
	self assert: self shownNames equals: #( 'master' 'snare' )
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testRefreshLeavesAnUnchangedGridAlone [

	| children |
	performed add: 'acid'.
	mixer refresh.
	children := mixer element children asArray.
	mixer refresh.
	self assert: (mixer element children asArray with: children collect: [ :a :b | a == b ]) equals: #( true true )
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testTurboPhuckGainMixerAlwaysShowsMaster [

	| gains |
	gains := TurboPhuck basicNew gainMixer.
	gains performedNames: [ #(  ) ].
	self assert: (gains faders includesKey: 'acid').
	self assert: (gains element children asArray collect: [ :each | each name ]) equals: #( 'master' )
]

{ #category : 'tests' }
ICPerformanceMixerTest >> testUnknownPerformedNamesAreIgnored [

	performed add: 'theremin'.
	mixer refresh.
	self assert: self shownNames equals: #( 'master' )
]
