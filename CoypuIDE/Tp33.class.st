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
		'knob_Mode',
		'widget_PatternClear',
		'widget_PitchMode',
		'widget_TimeMode',
		'widget_Back',
		'widget_RunStop',
		'widget_Function',
		'widget_WriteNext',
		'note_C1',
		'note_CSharp',
		'note_D',
		'note_DSharp',
		'note_E',
		'note_F',
		'note_FSharp',
		'note_G',
		'note_GSharp',
		'note_A',
		'note_ASharp',
		'note_B',
		'note_C',
		'note_9',
		'note_0',
		'note_100',
		'note_200'
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

{ #category : 'setting' }
Tp33 >> configuredString2: aString size: anInteger color:aColor back:bColor [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute paint: aColor). (BlTextBackgroundAttribute paint: bColor) .  (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'setting' }
Tp33 >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'setting' }
Tp33 >> configuredString: aString size: anInteger color:aColor [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: aColor) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'setting' }
Tp33 >> configuredString: aString size: anInteger color:aColor back:bColor [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute paint: aColor). (BlTextBackgroundAttribute paint: bColor) . (BlFontWeightAttribute bold) .  (BlFontSizeAttribute size:anInteger) }
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
	|l |
	"self border: (BlBorder builder paint: self color3; width: 10; build)."
	l:= BlElement new
	 	geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: self color2;
		size:1540@390;
		"effect: (BlGaussianShadowEffect color: (Color orange)   offset: 0@0  width: 30);"
		constraintsDo: [ :c| 
			c frame horizontal alignCenter.
			c frame vertical alignBottom.
			 ].
		
	self addChildren:{l}
]

{ #category : 'initialization' }
Tp33 >> initializeDialTexts [
	|l1 l2 l3 l4 l5 l6 l7 l8 t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17|
	
	l1:= BlElement new
	geometry: (BlPolylineGeometry vertices: {(70 @ 10). (10 @
 10). (10 @ 45).(40 @ 45) });
	border:(BlBorder paint: (Color veryVeryDarkGray) width: 1.5);
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -435@ -175.].
		
	l2:= BlElement new
	geometry: (BlPolylineGeometry vertices: {(40 @ 10). (5 @
 10). ( 5@ 50).(40 @ 50) });
	border:(BlBorder paint: (Color veryVeryDarkGray) width: 1.5);
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -445@ -115.].
	l3:= BlElement new
	geometry: (BlPolylineGeometry vertices: {(20 @ 10). (70 @
 10). (70 @ 45).(50 @ 45) });
	border:(BlBorder paint: (Color veryVeryDarkGray) width: 1.5);
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -315@ -175.].
	l4:= BlElement new
	geometry: (BlPolylineGeometry vertices: {(5 @ 10). (40 @
 10). ( 40@ 40) });
	border:(BlBorder paint: (Color veryVeryDarkGray) width: 1.5);
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -265@ -115.].
	
	l5:= BlElement new
	geometry: (BlPolylineGeometry vertices: {(10 @ 10). (85 @
 10). (85 @ 45).(40 @ 45) });
	border:(BlBorder paint: (Color veryVeryDarkGray) width: 1.5);
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -50@ -160.].
		
	l6:= BlElement new
	geometry: (BlPolylineGeometry vertices: {(75 @ 10). (85 @
 10). (85 @ 45).(65 @ 45) });
	border:(BlBorder paint: (Color veryVeryDarkGray) width: 1.5);
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -50@ -90.].
	l7:= BlElement new
	geometry: BlRectangleGeometry new;
	size:40@1.5;
	background:Color veryVeryDarkGray;
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 30@ -157.].
	l8:= BlElement new
	geometry: BlRectangleGeometry new;
	size:10@1.5;
	background:Color veryVeryDarkGray;
	constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 15@ -87.].
	
	t1:=BlTextElement new
		text: (self configuredString: 'WRITE' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -40@ -175.].
	t2:=BlTextElement new
		text: (self configuredString: 'PLAY' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -20@ -140.].
	
	t3:=BlTextElement new
		text: (self configuredString: 'PLAY' size: 16 color:(Color veryVeryDarkGray ));
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -20@ -105.].
	t4:=BlTextElement new
		text: (self configuredString: 'WRITE' size: 16 color:(Color veryVeryDarkGray ));
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -37@ -72.].
	
	t5:=BlTextElement new
		text: (self configuredString: 'TRACK' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: 50@ -158.].
		
	t6:=BlTextElement new
		text: (self configuredString: 'PATTERN' size: 16 color:(Color veryVeryDarkGray ));
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: 55@ -88.].
		
	t7:=BlTextElement new
		text: (self configuredString: ' 4 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -398@ -189.].
	t8:=BlTextElement new
		text: (self configuredString: '3 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -427@ -158.].
	t9:=BlTextElement new
		text: (self configuredString: '2 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -437@ -127.].
	t10:=BlTextElement new
		text: (self configuredString: '1 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -437@ -95.].
		
	
	t11:=BlTextElement new
		text: (self configuredString: ' 5 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -315@ -189.].
	t12:=BlTextElement new
		text: (self configuredString: '6 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -289@ -158.].
	t13:=BlTextElement new
		text: (self configuredString: '7 ' size: 16 color:(Color white ) back:Color veryVeryDarkGray);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -278@ -127.].
		
		
	"t14:=BlTextElement new
		text: (self configuredString: 'Ⅳ' size: 16 color:(Color veryVeryDarkGray ) back:self color1);
		border:(BlBorder paint: (self color1) width: 7);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter.  ];
		transformDo:[:t| t translateBy: -428@ -189.]."
		
	self addChildren: { 
		l1.l2.l3.l4.l5.l6.l7.l8.
		
		t1.t2.t3.t4.t5.t6.
		
		t7.t8.t9.t10.t11.t12.t13.
		
	 }
]

{ #category : 'initialization' }
Tp33 >> initializeGridlines [
	|l1 l2 l3 l4 l5 l6 l7 l8 l9 l10 l11 l12 l13|
	l1:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -340@180.].
	l2:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -255@180.].
	l3:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -170@180.].
	l4:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -85@180.].
	l5:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 0@180.].
	l6:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 85@180.].
	l7:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 170@180.].
	l8:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@230;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 255@180.].
	l9:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@166;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 338@242.].
	l10:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@150;background: Color darkGray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 420@234.].
	l11:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@150;background: Color gray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 502@234.].
	l12:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:2@206;background: Color gray;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 583.5@262.].
		
	l13:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 1);
		size:1010@2;background: Color gray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 343@ -25.].
	self addChildren:{
		l1.l2.l3.l4.l5.l6.l7.l8.
		
		l9.l10.l11.l12.l13.
	}
]

{ #category : 'initialization' }
Tp33 >> initializeKnobs [
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
	
	
	
		
	self knob_Tempo:((TbKnob1 label:'TEMPO')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 80@160.]).
	self knob_Volume:((TbKnob1 label:'VOLUME')
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -90@160.]).
	self knob_PattGroup:((TbKnob2 label:'.                   PATT  GROUP')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 320@160.]). 
	self knob_Mode:((TbKnob2 label:'MODE')
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 560@160.]).
	
	self addChildren: { 
		
		self knob_Tuning.
		self knob_CutoffFreq. 
		self knob_Resonance. 
		self knob_EnvMod. 
		self knob_Decay.
		self knob_Accent.
		self knob_Tempo.
		self knob_Volume.
		self knob_PattGroup.
		self knob_Mode.
		
	}.
]

{ #category : 'initialization' }
Tp33 >> initializeLEDs [

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
		
	self addChildren: { 
		self lED_MixIn.
		self switch_Waveform.
		self lED_SyncIn.
		
		self lED_Cv .
		self lED_Gate .
		self lED_Headphone .
		self lED_Output .
		self lED_Dc .
		
	}.
]

{ #category : 'initialization' }
Tp33 >> initializeLabels [
	|l1 l2 l3 t1 t2 t3|.
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
	self label_Phausto: (TbLabel_Phausto new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 10@60.]).
	self label_BassLine: (TbLabel_BassLine new
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: -40@60.]).
	self label_TP33: (TbLabel_TP33 new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 280@180.]).
	
	t1:=  BlTextElement new  
		text: (self configuredString: 'SLOW                                FAST' 
		size: 16 
		color:Color veryVeryDarkGray );  
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 80@ -48.]. 
	t2:=  BlTextElement new  
		text: (self configuredString: 'POWER SW  OFF                               MAX' 
		size: 16 
		color:Color veryVeryDarkGray );
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -100@ -48.]. 
	t3:=  BlTextElement new  
		text: (self configuredString: 'TRACK' 
		size: 20
		color:(Color white)
		back: Color veryVeryDarkGray
		);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 8);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignTop. ];
		transformDo:[:t| t translateBy: 315@ 165.]. 
	self addChildren:{
		l1.l2.l3.
		self label_Phausto.
		self label_BassLine.
		self label_TP33.
		t1.t2.t3.
	}.
]

{ #category : 'initialization' }
Tp33 >> initializeLayout [
	self initializeBackground.
	self initializeUpperhalf.
	self initializeLowerhalf.
]

{ #category : 'initialization' }
Tp33 >> initializeLowerhalf [

	self initializeGridlines.
	self initializeNotes.
	self initializeWidgets.
	self initializeSymbols.
	self initializeTexts.
]

{ #category : 'initialization' }
Tp33 >> initializeNotes [
	self note_C1: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -382@230.]).
	self note_D: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -297@230.]).
	self note_E: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -212@230.]).
	self note_F: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -127@230.]).
	self note_G: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -42@230.]).
	self note_A: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 43@230.]).
	self note_B: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 128@230.]).
	self note_C: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 213@230.]).
		
		
		
	self note_CSharp: (TbLEDDarkButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -340@125.]).
	self note_DSharp: (TbLEDDarkButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -255@125.]).
	self note_FSharp: (TbLEDDarkButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -85@125.]).
	self note_GSharp: (TbLEDDarkButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -0@125.]).
	self note_ASharp: (TbLEDDarkButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 85@125.]).
		
		
	self note_9: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 298@230.]).
	self note_0: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 380@230.]).
	self note_100: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 462@230.]).
	self note_200: (TbLEDButton new
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 543@230.]).
		
	
	self addChildren:{
		self note_C1.
		self note_D.
		self note_E.
		self note_F.
		self note_G.
		self note_A.
		self note_B.
		self note_C.
		
		
		self note_CSharp.
		self note_DSharp.
		self note_FSharp.
		self note_GSharp.
		self note_ASharp.
		
		self note_9.
		self note_0.
		self note_100.
		self note_200.
	}. 
]

{ #category : 'initialization' }
Tp33 >> initializeSymbols [
	|r1 r2 r3 s1 s2 s3 b1 t1 t2 t3 t4|
	r1:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 2);
		size:700@28;background: Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -510@54.].
	r2:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 8);
		size:745@35;background: Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -515@ -65.].
	r3:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius: 8);
		size:165@35;background: Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -186@ -65.].
	b1:= BlElement new
	 	geometry:(BlRoundedRectangleGeometry cornerRadius:0);
		size:64@40;background: Color veryVeryDarkGray ;
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -458@ -95.].
	s1:=  BlTextElement new
		text: (self configuredString: 'C      C#      D      D#      E                 F       F#      G       G#       A       A#       B                 C' size: 20);
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -90@52.].
	s2:=  BlTextElement new
		text: (self configuredString: '1               2               3               4               5               6               7               8' size: 24 color:(Color orange));
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -85@ -75.].
	s3:=  BlTextElement new
		text: (self configuredString: 'PATTERN' size: 18 color:(Color orange));
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -445@ -75.].
	t1:=  BlTextElement new
		text: (self configuredString: 'A                       B' size: 14 color:(Color orange));
		constraintsDo: [:c| c frame horizontal alignRight . c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -230@ -87.].
	t2:=  BlTextElement new
		text: (self configuredString: 'PATT.   SECTION' size: 14 color:(Color orange));
		constraintsDo: [:c| c frame horizontal alignRight . c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -220@ -70.].
	t3:=  BlTextElement new
		text: (self configuredString: 'STEP' size: 18 color:(Color veryVeryDarkGray));
		constraintsDo: [:c| c frame horizontal alignCenter . c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 295@ -75.].
	t4:=  TbIcon_Selector0 new
		constraintsDo: [:c| c frame horizontal alignCenter . c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 375@ -60.].


	self addChildren: { 
		
		r1.r2.r3.b1.s1.s2.s3.t1.t2.t3.t4.
		
	
	 }
]

{ #category : 'initialization' }
Tp33 >> initializeTexts [
   |t1 t2 t3 t4 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 tf |.
	t1:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:10@38;
		background:self color2;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 340@ -27.].
	t2:=  BlTextElement new  
		text: (self configuredString: 'SELECTOR' 
		size: 18
		color:(Color veryVeryDarkGray )
		);
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 270@ -40.].  
	t3:=  BlTextElement new  
		text: (self configuredString: 'DEL' 
		size: 16
		color:(Color white)
		back: Color veryVeryDarkGray
		);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 2);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 417@ 180.].
	t4:=  BlTextElement new  
		text: (self configuredString: 'INS' 
		size: 16
		color:(Color white)
		back: Color veryVeryDarkGray
		);
		border:(BlBorder paint: (Color veryVeryDarkGray) width: 2);
		outskirts: BlOutskirts centered;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 505@ 180.].
	
	b1:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 368@ -32.].
	b2:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 453@ -32.].
	b3:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 538@ -32.].
	b4:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 623@ -32.].
	b5:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 708@ -32.].
	b6:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 793@ -32.].
	b7:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 878@ -32.].
	b8:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 960@ -32.].
	b9:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 1045@ -32.].
	b10:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:40@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 1124@ -32.].
	b11:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:50@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 1207@ -32.].
	b12:=  BlElement new
		geometry: BlRectangleGeometry new;
		size:50@24;
		background:Color veryVeryDarkGray;
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 1282@ -32.].
		
	tf:=  BlTextElement new
		text: (self configuredString: '1               2               3               4               5               6               7               8               9              0             100        200' size: 24 color:(Color white ));
		constraintsDo: [:c| c frame horizontal alignCenter. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 85@ -37.].
	self addChildren:{
		t1.t2.
		b1.b2.b3. b4.b5.b6.b7.b8.b9.b10.b11.b12.
		t3.t4.
		tf.
	}.
	
	
]

{ #category : 'initialization' }
Tp33 >> initializeUpperhalf [
	
	self initializeLEDs.
	self initializeKnobs.
	self initializeLabels.
	self initializeDialTexts.

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

{ #category : 'initialization' }
Tp33 >> initializeWidgets [
	self widget_PatternClear:  (TbWidget_PatternClear new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 20@100.]).
	self widget_RunStop: (TbWidget_RunStop new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 20@ -25.]).
	
	self widget_PitchMode: (TbWidget_PitchMode new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: 185@100.]).
	self widget_Function: (TbWidget_Function new
		constraintsDo: [:c| c frame horizontal alignLeft. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: 185@ -25.]).
		
	self widget_Back: (TbWidget_Back new
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -20@100.]).
	self widget_WriteNext: (TbWidget_WriteNext new
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignBottom. ];
		transformDo:[:t| t translateBy: -20@ -25.]).
	self widget_TimeMode: (TbWidget_TimeMode new
		constraintsDo: [:c| c frame horizontal alignRight. c frame vertical alignCenter. ];
		transformDo:[:t| t translateBy: -185@ 100.]).
	
	self addChildren: { 
		self widget_PatternClear.
		self widget_RunStop.
		self widget_PitchMode.
		self widget_Function.
		self widget_Back.
		self widget_WriteNext.
		self widget_TimeMode.	
	 }.
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
Tp33 >> note_0 [

	^ note_0
]

{ #category : 'accessing' }
Tp33 >> note_0: anObject [

	note_0 := anObject
]

{ #category : 'accessing' }
Tp33 >> note_100 [

	^ note_100
]

{ #category : 'accessing' }
Tp33 >> note_100: anObject [

	note_100 := anObject
]

{ #category : 'accessing' }
Tp33 >> note_200 [

	^ note_200
]

{ #category : 'accessing' }
Tp33 >> note_200: anObject [

	note_200 := anObject
]

{ #category : 'accessing' }
Tp33 >> note_9 [

	^ note_9
]

{ #category : 'accessing' }
Tp33 >> note_9: anObject [

	note_9 := anObject
]

{ #category : 'accessing' }
Tp33 >> note_A [

	^ note_A
]

{ #category : 'accessing' }
Tp33 >> note_A: anObject [

	note_A := anObject
]

{ #category : 'accessing' }
Tp33 >> note_ASharp [

	^ note_ASharp
]

{ #category : 'accessing' }
Tp33 >> note_ASharp: anObject [

	note_ASharp := anObject
]

{ #category : 'accessing' }
Tp33 >> note_B [

	^ note_B
]

{ #category : 'accessing' }
Tp33 >> note_B: anObject [

	note_B := anObject
]

{ #category : 'accessing' }
Tp33 >> note_C [

	^ note_C
]

{ #category : 'accessing' }
Tp33 >> note_C1 [

	^ note_C1
]

{ #category : 'accessing' }
Tp33 >> note_C1: anObject [

	note_C1 := anObject
]

{ #category : 'accessing' }
Tp33 >> note_C: anObject [

	note_C := anObject
]

{ #category : 'accessing' }
Tp33 >> note_CSharp [

	^ note_CSharp
]

{ #category : 'accessing' }
Tp33 >> note_CSharp: anObject [

	note_CSharp := anObject
]

{ #category : 'accessing' }
Tp33 >> note_D [

	^ note_D
]

{ #category : 'accessing' }
Tp33 >> note_D: anObject [

	note_D := anObject
]

{ #category : 'accessing' }
Tp33 >> note_DSharp [

	^ note_DSharp
]

{ #category : 'accessing' }
Tp33 >> note_DSharp: anObject [

	note_DSharp := anObject
]

{ #category : 'accessing' }
Tp33 >> note_E [

	^ note_E
]

{ #category : 'accessing' }
Tp33 >> note_E: anObject [

	note_E := anObject
]

{ #category : 'accessing' }
Tp33 >> note_F [

	^ note_F
]

{ #category : 'accessing' }
Tp33 >> note_F: anObject [

	note_F := anObject
]

{ #category : 'accessing' }
Tp33 >> note_FSharp [

	^ note_FSharp
]

{ #category : 'accessing' }
Tp33 >> note_FSharp: anObject [

	note_FSharp := anObject
]

{ #category : 'accessing' }
Tp33 >> note_G [

	^ note_G
]

{ #category : 'accessing' }
Tp33 >> note_G: anObject [

	note_G := anObject
]

{ #category : 'accessing' }
Tp33 >> note_GSharp [

	^ note_GSharp
]

{ #category : 'accessing' }
Tp33 >> note_GSharp: anObject [

	note_GSharp := anObject
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

{ #category : 'accessing' }
Tp33 >> widget_Back [

	^ widget_Back
]

{ #category : 'accessing' }
Tp33 >> widget_Back: anObject [

	widget_Back := anObject
]

{ #category : 'accessing' }
Tp33 >> widget_Function [

	^ widget_Function
]

{ #category : 'accessing' }
Tp33 >> widget_Function: anObject [

	widget_Function := anObject
]

{ #category : 'accessing' }
Tp33 >> widget_PatternClear [

	^ widget_PatternClear
]

{ #category : 'accessing' }
Tp33 >> widget_PatternClear: anObject [

	widget_PatternClear := anObject
]

{ #category : 'accessing' }
Tp33 >> widget_PitchMode [

	^ widget_PitchMode
]

{ #category : 'accessing' }
Tp33 >> widget_PitchMode: anObject [

	widget_PitchMode := anObject
]

{ #category : 'accessing' }
Tp33 >> widget_RunStop [

	^ widget_RunStop
]

{ #category : 'accessing' }
Tp33 >> widget_RunStop: anObject [

	widget_RunStop := anObject
]

{ #category : 'accessing' }
Tp33 >> widget_TimeMode [

	^ widget_TimeMode
]

{ #category : 'accessing' }
Tp33 >> widget_TimeMode: anObject [

	widget_TimeMode := anObject
]

{ #category : 'accessing' }
Tp33 >> widget_WriteNext [

	^ widget_WriteNext
]

{ #category : 'accessing' }
Tp33 >> widget_WriteNext: anObject [

	widget_WriteNext := anObject
]
