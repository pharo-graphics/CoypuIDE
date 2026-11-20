Extension { #name : 'TurboPhuck' }

{ #category : '*CoypuIDE' }
TurboPhuck >> buildUIForGains [
	"one ICTurboGainFader per <name>Gain global of the ChucK VM, 16 to a row, on black.
	Twice a second the names of the instruments in the Performance turn yellow."

	| defaults faders grid |
	defaults := self gainDefaults.
	faders := self gainNames collect: [ :each | self faderForGain: each default: (defaults at: each ifAbsent: [ 0.5 ]) ].
	self highlightPerformedIn: faders.
	grid := BlElement new
		        geometry: BlRectangleGeometry new;
		        layout: (BlGridLayout new
				         columnCount: 16;
				         cellSpacing: 0);
		        constraintsDo: [ :c |
				        c horizontal fitContent.
				        c vertical fitContent ];
		        background: Color black;
		        addChildren: faders;
		        yourself.
	grid enqueueTask: (BlRepeatedTaskAction new
			 delay: 500 milliSeconds;
			 action: [ self highlightPerformedIn: faders ];
			 yourself).
	^ grid
]

{ #category : '*CoypuIDE' }
TurboPhuck >> displayMasterUI [

	| hpfFreqKnob pitchShiftKnob knobs sizes row space |
	pitchShiftKnob := ICDarkKnob2
		                  label: 'pitchShift'
		                  minValue: 0.01
		                  maxValue: 2
		                  callBack: [ :i |
		                  PhuckVM uniqueInstance
			                  setValue: i
			                  parameter: 'pitchShift' ].
	pitchShiftKnob setValue: 1.

	hpfFreqKnob := ICDarkKnob2
		               label: 'highpassFreq'
		               minValue: 20
		               maxValue: 2400
		               callBack: [ :i |
		               PhuckVM uniqueInstance
			               setValue: i
			               parameter: 'highpassFreq' ].

	knobs := {
		         pitchShiftKnob.
		         hpfFreqKnob }.
	sizes := knobs collect: [ :each | each widgetSize ].

	row := BlElement new
		       layout: BlLinearLayout horizontal;
		       constraintsDo: [ :c |
				       c horizontal fitContent.
				       c vertical fitContent ];
		       addChildren: knobs;
		       yourself.

	space := BlSpace new
		         title: 'Master';
		         extent: sizes sum @ sizes max;
		         yourself.
	space root addChild: row.
	space show.
	^ space
]

{ #category : '*CoypuIDE' }
TurboPhuck >> displayUIForGains [
	"display the gain mixer UI made with Bloc: as wide as the faders, at most 900 high, scrolling the rest"

	| space ui scroller |
	"first we build the UI"
	ui := self buildUIForGains.
	ui forceLayout.
	scroller := ui asScrollableElement.
	scroller constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	space := BlSpace new
		         title: 'TurboPhuck Gains';
		         extent: ui extent x @ (ui extent y min: 900);
		         yourself.
	space root
		background: Color black;
		addChild: scroller.
	space show.
	^ space
]

{ #category : '*CoypuIDE' }
TurboPhuck >> faderForGain: aGlobalName default: aNumber [
	"70% of the default ICMixerFader width (thickness 70); the value is set before the callBack, so building the fader sends nothing to the VM"

	^ (ICTurboGainFader label: (aGlobalName allButLast: 4))
		  barLength: 120 thickness: 49;
		  minValue: 0;
		  maxValue: 1;
		  stepValue: 0.01;
		  setValue: aNumber;
		  callBack: [ :value | PhuckVM uniqueInstance setValue: value parameter: aGlobalName ];
		  yourself
]

{ #category : '*CoypuIDE' }
TurboPhuck >> gainDefaults [
	"<name>Gain -> initial value, as declared in the TurboPhuck shred"

	| result matcher |
	result := Dictionary new.
	matcher := '([0-9.]+)\s*=>\s*global\s+float\s+(\w+Gain)' asRegex.
	matcher
		matchesIn: self class codeWithOSCSender
		do: [ :each | result at: (matcher subexpression: 3) put: (matcher subexpression: 2) asNumber ].
	^ result
]

{ #category : '*CoypuIDE' }
TurboPhuck >> gainNames [
	"every <name>Gain global of the VM (or of the TurboPhuck shred if the VM has none yet), master first"

	| globals names |
	globals := PhuckVM uniqueInstance globals.
	(globals isNil or: [ globals isEmpty ]) ifTrue: [ globals := PhuckVM uniqueInstance globalsIn: self class codeWithOSCSender ].
	names := (globals keys select: [ :each | each size > 4 and: [ each endsWith: 'Gain' ] ]) collect: [ :each | each asString ].
	^ names asArray sorted: [ :a :b | a = 'masterGain' or: [ b ~= 'masterGain' and: [ a asLowercase <= b asLowercase ] ] ]
]

{ #category : '*CoypuIDE' }
TurboPhuck >> highlightPerformedIn: aCollectionOfFaders [
	"yellow names for the instruments that are in the Performance"

	| performed |
	performed := self performedInstrumentNames.
	aCollectionOfFaders do: [ :each | each highlighted: (performed includes: each name) ]
]

{ #category : '*CoypuIDE' }
TurboPhuck >> performedInstrumentNames [

	^ (Performance uniqueInstance keys collect: [ :each | each asString ]) asSet
]
