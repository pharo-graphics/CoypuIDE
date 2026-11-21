Extension { #name : 'TurboVoice' }

{ #category : '*CoypuIDE' }
TurboVoice >> canSpork [
	"my editor shows a SPORK button"

	^ true
]

{ #category : '*CoypuIDE' }
TurboVoice >> display [
	"my editor: a knob per parameter, gate and toggle buttons, black background"

	^ (ICTurboVoicePanel on: self) open
]

{ #category : '*CoypuIDE' }
TurboVoice >> uiActions [
	"label -> (suffix -> value): click buttons of my editor that set one knob"

	^ #(  )
]

{ #category : '*CoypuIDE' }
TurboVoice >> uiKind [
	"shown after my name in the title of my editor"

	^ self class name
]

{ #category : '*CoypuIDE' }
TurboVoice >> uiLabelFor: aSuffix [
	"the name on the knob of aSuffix"

	^ aSuffix
]

{ #category : '*CoypuIDE' }
TurboVoice >> uiRanges [
	"suffix -> { min. max. step } of the knobs of an editor (ICTurboVoicePanel), for every parameter of the rig"

	^ Dictionary new
		  at: 'Note' put: #( 24 96 1 );
		  at: 'Gain' put: #( 0 1 0.01 );
		  at: 'Cutoff' put: #( 0 1 0.01 );
		  at: 'Resonance' put: #( 0.5 20 0.1 );
		  at: 'EnvMod' put: #( 0 1 0.01 );
		  at: 'Decay' put: #( 0.01 2 0.01 );
		  at: 'Tuning' put: #( -50 50 1 );
		  at: 'Detune' put: #( 0 20 0.1 );
		  at: 'Attack' put: #( 0.001 2 0.001 );
		  at: 'Sustain' put: #( 0 1 0.01 );
		  at: 'Release' put: #( 0.01 3 0.01 );
		  at: 'PitchAmt' put: #( 0 500 1 );
		  at: 'PitchDecay' put: #( 0.001 0.3 0.001 );
		  at: 'Click' put: #( 0 1 0.01 );
		  at: 'Index' put: #( 0 3 1 );
		  at: 'LfoAmount' put: #( 0 1 0.01 );
		  at: 'DSFreq' put: #( 20 2000 1 );
		  at: 'Q' put: #( 1 20 0.1 );
		  at: 'ModIndex' put: #( 0 10 0.01 );
		  at: 'ModRatio' put: #( 0.25 8 0.01 );
		  at: 'Mode' put: #( 0 3 1 );
		  at: 'Position' put: #( 0 1 0.01 );
		  at: 'Slice' put: #( -1 15 1 );
		  at: 'Length' put: #( 0 8 0.25 );
		  addAll: (TurboAux all collect: [ :each | each sendSuffix -> #( 0 1 0.01 ) ]) asDictionary;
		  yourself
]

{ #category : '*CoypuIDE' }
TurboVoice >> uiToggles [
	"suffixes my editor shows as toggle buttons (0 / 1) instead of knobs"

	^ #(  )
]
