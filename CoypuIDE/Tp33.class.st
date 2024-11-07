Class {
	#name : 'Tp33',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'LED_MixIn',
		'LED_SyncIn',
		'LED_Cv',
		'LED_Gate',
		'LED_Headphone',
		'LED_Output',
		'LED_Dc',
		'switch_Waveform',
		'knob_Tuning',
		'knob_CutoffFreq',
		'knob_Resonance',
		'knob_EnvMod',
		'knob_Decay',
		'knob_Accent',
		'label_Phausto',
		'lable_BassLine'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'demos' }
Tp33 class >> layoutViewExample_1560_800 [
	<script>
	|e space|
	e:= self new.

	space := BlSpace new.
	space root addChild: e.
	space root whenLayoutedDoOnce: [ space extent: e size ].
	space show.
		
		
	
]

{ #category : 'accessing' }
Tp33 >> color1 [
	 ^(Color r: 233 g:224  b:208  range:255).
]

{ #category : 'accessing' }
Tp33 >> color2 [
	 ^(Color r: 249 g:239  b:224  range:255).
]

{ #category : 'accessing' }
Tp33 >> color3 [
	 ^(Color r: 252 g:243  b:242  range:255).
]

{ #category : 'initialization' }
Tp33 >> initialize [

	super initialize.
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
]

{ #category : 'initialization' }
Tp33 >> initializeBackground [
	|l h|
	self border: (BlBorder builder paint: self color3; width: 10; build).
	l:= BlElement new
	 	geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: self color2;
		size:1540@390;
		constraintsDo: [ :c| 
			c frame horizontal alignCenter.
			c frame vertical alignBottom.
			 ].
		
	self addChildren:{l}
]

{ #category : 'initialization' }
Tp33 >> initializeLayout [
	self initializeBackground.
	self initializeUpperhalf.
	"self initializeLowerhalf."
]

{ #category : 'initialization' }
Tp33 >> initializeUpperhalf [
	|r1 r2 R3|
	self lED_MixIn: ((TbLabelledLED label:'MIX IN')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 30@0.]).
	self switch_Waveform: (TbOnOffSwitch toggleable
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 130@20.]).
	self lED_SyncIn:  ((TbLabelledLED label:'SYNC IN')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 250@0.]).
		
	self lED_Cv: ((TbLabelledLED label:'CV')
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -30@0.]).
	self lED_Gate:((TbLabelledLED label:'GATE')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -90@0.]).
	self lED_Headphone:((TbLabelledLED label:'HEADPHONE')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -150@0.]).
	self lED_Output: ((TbLabelledLED label:'OUTPUT')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -240@0.]).
	self lED_Dc:((TbLabelledLED label:'DC 9V')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -310@0.]).
	
	
	self label_Phausto: (TbLabel_Phausto new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 20@60.]).
	self lable_BassLine: (TbLabel_BassLine new
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -50@60.]).

	
	self knob_Tuning: (TbKnob label:'TUNING').
	self knob_CutoffFreq: (TbKnob label:'CUTOFF  FREQ').
	self knob_Resonance: (TbKnob label:'RESONANCE').
 	self knob_EnvMod: (TbKnob label:'ENV MOD').
	self knob_Decay: (TbKnob label:'DECAY').
	self knob_Accent: (TbKnob label:'ACCENT').
	
	
	
	self addChildren: { 
		self lED_MixIn.
		self switch_Waveform.
		self lED_SyncIn.
		
		
		self lED_Cv .
		self lED_Gate .
		self lED_Headphone .
		self lED_Output .
		self lED_Dc .
		
		self label_Phausto.
		self lable_BassLine.
	
	}.


]

{ #category : 'initialization' }
Tp33 >> initializeWidget [
	self size: self widgetSize.
	self padding: (BlInsets all:10).
	self background: self color1.
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
Tp33 >> initializeWidgetSize [
	self widgetSize: 1560@800.
]

{ #category : 'accessing' }
Tp33 >> knob_Accent [

	^ knob_Accent
]

{ #category : 'accessing' }
Tp33 >> knob_Accent: anObject [

	knob_Accent := anObject
]

{ #category : 'accessing' }
Tp33 >> knob_CutoffFreq [

	^ knob_CutoffFreq
]

{ #category : 'accessing' }
Tp33 >> knob_CutoffFreq: anObject [

	knob_CutoffFreq := anObject
]

{ #category : 'accessing' }
Tp33 >> knob_Decay [

	^ knob_Decay
]

{ #category : 'accessing' }
Tp33 >> knob_Decay: anObject [

	knob_Decay := anObject
]

{ #category : 'accessing' }
Tp33 >> knob_EnvMod [

	^ knob_EnvMod
]

{ #category : 'accessing' }
Tp33 >> knob_EnvMod: anObject [

	knob_EnvMod := anObject
]

{ #category : 'accessing' }
Tp33 >> knob_Resonance [

	^ knob_Resonance
]

{ #category : 'accessing' }
Tp33 >> knob_Resonance: anObject [

	knob_Resonance := anObject
]

{ #category : 'accessing' }
Tp33 >> knob_Tuning [

	^ knob_Tuning
]

{ #category : 'accessing' }
Tp33 >> knob_Tuning: anObject [

	knob_Tuning := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_Cv [

	^ LED_Cv
]

{ #category : 'accessing' }
Tp33 >> lED_Cv: anObject [

	LED_Cv := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_Dc [

	^ LED_Dc
]

{ #category : 'accessing' }
Tp33 >> lED_Dc: anObject [

	LED_Dc := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_Gate [

	^ LED_Gate
]

{ #category : 'accessing' }
Tp33 >> lED_Gate: anObject [

	LED_Gate := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_Headphone [

	^ LED_Headphone
]

{ #category : 'accessing' }
Tp33 >> lED_Headphone: anObject [

	LED_Headphone := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_MixIn [

	^ LED_MixIn
]

{ #category : 'accessing' }
Tp33 >> lED_MixIn: anObject [

	LED_MixIn := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_Output [

	^ LED_Output
]

{ #category : 'accessing' }
Tp33 >> lED_Output: anObject [

	LED_Output := anObject
]

{ #category : 'accessing' }
Tp33 >> lED_SyncIn [

	^ LED_SyncIn
]

{ #category : 'accessing' }
Tp33 >> lED_SyncIn: anObject [

	LED_SyncIn := anObject
]

{ #category : 'accessing' }
Tp33 >> label_Phausto [

	^ label_Phausto
]

{ #category : 'accessing' }
Tp33 >> label_Phausto: anObject [

	label_Phausto := anObject
]

{ #category : 'accessing' }
Tp33 >> lable_BassLine [

	^ lable_BassLine
]

{ #category : 'accessing' }
Tp33 >> lable_BassLine: anObject [

	lable_BassLine := anObject
]

{ #category : 'accessing' }
Tp33 >> switch_Waveform [

	^ switch_Waveform
]

{ #category : 'accessing' }
Tp33 >> switch_Waveform: anObject [

	switch_Waveform := anObject
]

{ #category : 'accessing' }
Tp33 >> widgetSize [

	^ widgetSize
]

{ #category : 'accessing' }
Tp33 >> widgetSize: anObject [

	widgetSize := anObject
]
