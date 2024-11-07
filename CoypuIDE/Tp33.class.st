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
		'label_BassLine',
		'label_TP33',
		'knob_Tempo',
		'knob_Volume',
		'knob_PattGroup',
		'knob_Mode'
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

{ #category : 'accessing' }
Tp33 >> color4 [
	 ^(Color r: 98 g:85  b:62  range:255).
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
	|l1 l2 l3|
	self lED_MixIn: ((TbLabelledLED label:'MIX IN')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 10@0.]).
	self switch_Waveform: (TbOnOffSwitch toggleable
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 120@10.]).
	self lED_SyncIn:  ((TbLabelledLED label:'SYNC IN')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 230@0.]).
		
	self lED_Cv: ((TbLabelledLED label:'CV')
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -10@0.]).
	self lED_Gate:((TbLabelledLED label:'GATE')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -70@0.]).
	self lED_Headphone:((TbLabelledLED label:'HEADPHONE')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -130@0.]).
	self lED_Output: ((TbLabelledLED label:'OUTPUT')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -220@0.]).
	self lED_Dc:((TbLabelledLED label:'DC 9V')
	constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -290@0.]).
	
	
	self label_Phausto: (TbLabel_Phausto new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 10@60.]).
	self label_BassLine: (TbLabel_BassLine new
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -40@60.]).

	
	self knob_Tuning: ((TbKnob label:'TUNING')
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -325@0.]).
	self knob_CutoffFreq: ((TbKnob label:'CUTOFF  FREQ')
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -195@0.]).
	self knob_Resonance: ((TbKnob label:'RESONANCE')
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -65@0.]).
 	self knob_EnvMod: ((TbKnob label:'ENV MOD')
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 65@0.]).
	self knob_Decay: ((TbKnob label:'DECAY')
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 195@0.]).
	self knob_Accent: ((TbKnob label:'ACCENT')
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 325@0.]).
	
	l1:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 2);
		size:3@120;background: Color veryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 360@5.].
		
	l2:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 2);
		size:3@120;background: Color veryDarkGray;
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -360@5.].
	
	l3:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 2);
		size:1520@4;background: (self color4 alpha:0.5);
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop.];
		transformDo:[:t| t translateBy: 0@145.].
	
	self label_TP33: (TbLabel_TP33 new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 280@180.]).
	self knob_Tempo:((TbKnob1 label:'TEMPO')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 80@160.]).
	self knob_Volume:((TbKnob1 label:'VOLUME')
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -90@160.]).
	self knob_PattGroup:((TbKnob2 label:'.          PATT  GROUP')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 320@160.]). 
	self knob_Mode:((TbKnob2 label:'MODE')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 560@160.]).
	
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
		self label_BassLine.
		
		self knob_Tuning.
		self knob_CutoffFreq. 
		self knob_Resonance. 
		self knob_EnvMod. 
		self knob_Decay.
		self knob_Accent.
		
		l1.l2.l3.
		
		self label_TP33.
		self knob_Tempo.
		self knob_Volume.
		self knob_PattGroup.
		self knob_Mode.
		
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
Tp33 >> knob_Mode [

	^ knob_Mode
]

{ #category : 'accessing' }
Tp33 >> knob_Mode: anObject [

	knob_Mode := anObject
]

{ #category : 'accessing' }
Tp33 >> knob_PattGroup [

	^ knob_PattGroup
]

{ #category : 'accessing' }
Tp33 >> knob_PattGroup: anObject [

	knob_PattGroup := anObject
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
Tp33 >> knob_Tempo [

	^ knob_Tempo
]

{ #category : 'accessing' }
Tp33 >> knob_Tempo: anObject [

	knob_Tempo := anObject
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
Tp33 >> knob_Volume [

	^ knob_Volume
]

{ #category : 'accessing' }
Tp33 >> knob_Volume: anObject [

	knob_Volume := anObject
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
Tp33 >> label_BassLine [

	^ label_BassLine
]

{ #category : 'accessing' }
Tp33 >> label_BassLine: anObject [

	label_BassLine := anObject
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
Tp33 >> label_TP33 [

	^ label_TP33
]

{ #category : 'accessing' }
Tp33 >> label_TP33: anObject [

	label_TP33 := anObject
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
