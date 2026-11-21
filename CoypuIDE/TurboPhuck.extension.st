Extension { #name : 'TurboPhuck' }

{ #category : '*CoypuIDE' }
TurboPhuck >> buildUIForGains [
	"the grid of the gain mixer: master and the instruments in the Performance, following it"

	^ self gainMixer element
]

{ #category : '*CoypuIDE' }
TurboPhuck >> displayMasterUI [
	"the master knobs (pitch shift, high-pass), then a row per aux bus of the rig (delay ...)"

	| rows element space |
	rows := self masterUIRows.
	element := BlElement new
		           layout: BlLinearLayout vertical;
		           constraintsDo: [ :c |
				           c horizontal fitContent.
				           c vertical fitContent ];
		           addChildren: (rows collect: [ :each | self rowOfKnobs: each ]);
		           yourself.
	space := BlSpace new
		         title: 'Master';
		         extent: (self extentOfRows: rows);
		         yourself.
	space root addChild: element.
	space show.
	^ space
]

{ #category : '*CoypuIDE' }
TurboPhuck >> displayUIForGains [
	"display the gain mixer UI made with Bloc: master and the instruments in the Performance, following it"

	^ self gainMixer open
]

{ #category : '*CoypuIDE' }
TurboPhuck >> extentOfRows: someRows [
	"the widest row by the sum of the tallest knob of each row"

	^ (someRows inject: 0 into: [ :width :each | width max: (each inject: 0 into: [ :sum :knob | sum + knob widgetSize ]) ])
	  @ (someRows inject: 0 into: [ :height :each | height + (each collect: [ :knob | knob widgetSize ]) max ])
]

{ #category : '*CoypuIDE' }
TurboPhuck >> faderForGain: aGlobalName default: aNumber [
	"the value is set before the callBack, so building the fader sends nothing to the VM"

	^ ICTurboGainFader
		  label: (aGlobalName allButLast: 4)
		  min: 0
		  max: 1
		  value: aNumber
		  step: 0.01
		  callBack: [ :value | PhuckVM uniqueInstance setValue: value parameter: aGlobalName ]
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
TurboPhuck >> gainMixer [
	"one ICTurboGainFader per <name>Gain global of the ChucK VM; master always shown"

	| defaults mixer |
	defaults := self gainDefaults.
	mixer := ICPerformanceMixer title: 'TurboPhuck Gains'.
	self gainNames do: [ :each |
		mixer add: (self faderForGain: each default: (defaults at: each ifAbsent: [ 0.5 ])) for: (each allButLast: 4) ].
	mixer alwaysShow: 'master'.
	^ mixer
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
TurboPhuck >> masterKnobs [
	"pitch shift and high-pass of the master bus; the callback goes in last, so building them sends nothing to the VM"

	| pitchShiftKnob hpfFreqKnob |
	pitchShiftKnob := ICLightKnob label: 'pitchShift' minValue: 0.01 maxValue: 2.
	pitchShiftKnob setValue: 1.
	pitchShiftKnob callBack: [ :i | PhuckVM uniqueInstance setValue: i parameter: 'pitchShift' ].
	hpfFreqKnob := ICLightKnob label: 'highpassFreq' minValue: 20 maxValue: 2400.
	hpfFreqKnob callBack: [ :i | PhuckVM uniqueInstance setValue: i parameter: 'highpassFreq' ].
	^ {
		  pitchShiftKnob.
		  hpfFreqKnob }
]

{ #category : '*CoypuIDE' }
TurboPhuck >> masterUIRows [
	"the knobs of displayMasterUI, one collection per row: the master, then each aux bus"

	^ { self masterKnobs } , (TurboAux all collect: [ :each | each uiKnobs ])
]

{ #category : '*CoypuIDE' }
TurboPhuck >> rowOfKnobs: someKnobs [

	^ BlElement new
		  layout: BlLinearLayout horizontal;
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  addChildren: someKnobs;
		  yourself
]
