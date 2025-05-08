"
Creates a control panel for a MIDI device
"
Class {
	#name : 'ICControlPanel',
	#superclass : 'BlElement',
	#instVars : [
		'c',
		'f',
		'knobs',
		'mout',
		'faders',
		'space'
	],
	#category : 'CoypuIDE-Containers',
	#package : 'CoypuIDE',
	#tag : 'Containers'
}

{ #category : 'as yet unclassified' }
ICControlPanel >> forSyntakt [

	c := ICKnobContainer columns: 6 background: Color gray.
	f := ICKnobContainer columns: 12 background: Color black.
	knobs := (1 to: 12) collect: [ :i |
		         mout
			         createKnobForCC: 84
			         onChannel: i
			         initialValue: 0
			         withLabel: 'DelaySend ' , i asString ].
	faders := (1 to: 12) collect: [ :i |
		          mout
			          createMixerSliderForCC: 95
			          onChannel: i
			          initialValue: 100
			          withLabel: 'TrackLevel ' , i asString ].
	c addChildren: knobs.
	f addChildren: faders.
	space := BlSpace new label: 'SYNTAKT'.
	space root
		background: Color black;
		layout: BlLinearLayout vertical.
	space root addChild: c.
	space root addChild: f.
	space show
]

{ #category : 'as yet unclassified' }
ICControlPanel >> forSyntaktOn: aMIDISender [

	c := ICKnobContainer columns: 6 background: Color gray.
	f := ICKnobContainer columns: 12 background: Color black.
	knobs := (1 to: 12) collect: [ :i |
		         aMIDISender 
			         createKnobForCC: 84
			         onChannel: i
			         initialValue: 0
			         withLabel: 'DelaySend ' , i asString ].
	faders := (1 to: 12) collect: [ :i |
		          aMIDISender 
			          createMixerSliderForCC: 95
			          onChannel: i
			          initialValue: 100
			          withLabel: 'TrackLevel ' , i asString ].
	c addChildren: knobs.
	f addChildren: faders.
	space := BlSpace new title: 'SYNTAKT'.
	space root
		background: Color black;
		layout: BlLinearLayout vertical.
	space root addChild: c.
	space root addChild: f.
	space show
]
