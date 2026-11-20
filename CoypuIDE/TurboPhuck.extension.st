Extension { #name : 'TurboPhuck' }

{ #category : '*CoypuIDE' }
TurboPhuck >> buildUIForGains [
	"one ICTurboGainFader per <name>Gain global of the ChucK VM, 16 to a row, on black.
	Only master and the instruments in the Performance are shown; twice a second the faders follow the Performance.
	Hidden faders are kept, so they come back with their value."

	| defaults faders grid |
	defaults := self gainDefaults.
	faders := OrderedDictionary new.
	self gainNames do: [ :each |
		faders at: (each allButLast: 4) put: (self faderForGain: each default: (defaults at: each ifAbsent: [ 0.5 ])) ].
	grid := BlElement new
		        geometry: BlRectangleGeometry new;
		        layout: (BlGridLayout new
				         columnCount: 16;
				         cellSpacing: 0);
		        constraintsDo: [ :c |
				        c horizontal fitContent.
				        c vertical fitContent ];
		        background: Color black;
		        yourself.
	self show: (self performedFadersIn: faders) in: grid.
	grid enqueueTask: (BlRepeatedTaskAction new
			 delay: 500 milliSeconds;
			 action: [ self show: (self performedFadersIn: faders) in: grid ];
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
	"display the gain mixer UI made with Bloc: the window follows the faders shown (at least 240 wide, at most 900 high, scrolling the rest)"

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
		         extent: (self gainsWindowExtentFor: ui extent);
		         yourself.
	space root
		background: Color black;
		addChild: scroller.
	ui addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt | space extent: (self gainsWindowExtentFor: evt target extent) ].
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
TurboPhuck >> gainsWindowExtentFor: aPoint [

	^ (aPoint x max: 240) @ (aPoint y min: 900)
]

{ #category : '*CoypuIDE' }
TurboPhuck >> performedFadersIn: aDictionary [
	"name -> fader: master always, then the instruments in the Performance, in aDictionary's order"

	| performed |
	performed := self performedInstrumentNames.
	^ (aDictionary associations
		   select: [ :each | each key = 'master' or: [ performed includes: each key ] ]
		   thenCollect: [ :each | each value ]) asArray
]

{ #category : '*CoypuIDE' }
TurboPhuck >> performedInstrumentNames [

	^ (Performance uniqueInstance keys collect: [ :each | each asString ]) asSet
]

{ #category : '*CoypuIDE' }
TurboPhuck >> show: someFaders in: aGrid [
	"only touch the grid when the faders to show have changed"

	aGrid children asArray = someFaders asArray ifTrue: [ ^ self ].
	aGrid
		removeChildren;
		addChildren: someFaders
]
