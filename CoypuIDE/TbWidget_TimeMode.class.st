Class {
	#name : 'TbWidget_TimeMode',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'switch',
		'indicator',
		'value'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbWidget_TimeMode class >> Example [ 
	<script>
	| container e1 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 10;
		cellSpacing: 10
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 249 g:239  b:224  range:255).
		"background: Color white."

e1:=TbWidget_TimeMode new.



container addChildren: { e1}.
container openInSpace.
	
]

{ #category : 'setting' }
TbWidget_TimeMode >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }
]

{ #category : 'setting' }
TbWidget_TimeMode >> configuredString: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color veryDarkGray) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger)}. 
]

{ #category : 'setting' }
TbWidget_TimeMode >> configuredStringDark: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:15) }
]

{ #category : 'setting' }
TbWidget_TimeMode >> configuredStringDark: aString size: anInteger [
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color white) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:anInteger) }
]

{ #category : 'accessing' }
TbWidget_TimeMode >> indicator [
	^indicator.
]

{ #category : 'setting' }
TbWidget_TimeMode >> indicator: aBlock [
	indicator:= aBlock.
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initialize [

	super initialize.
	self value: 0.
	self padding: (BlInsets all:0).
	self initializeWidgetSize.
	self initializeWidget.
	self initializeLayout.
	self initializeEvents.
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initializeEvents [
	"Mouse Up Event is chosen instead of down to make a smooth transition when the user unclicks the switch."
	switch
		childrenDo: [ :i|   
				i addEventHandler: (BlEventHandler
				 	on: BlMouseUpEvent
				 	do: [ :anEvent |
						self toggle.
					]).
	].
		
	
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initializeLayout [
	"gi are the background shades."
	|label g1 g2 |
	
	self border: (BlBorder paint: (Color gray) width: 2).

	label := BlTextElement new.
	label text: (self configuredString: 'TIME MODE' size:18).
	label constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop.
		].
	label transformDo: [ :t|
		t translateBy:0@ 6. 
		].
	
	self switch: (TbHorizontalSwitch toggleable ).
	switch constraintsDo: [ :c |
					c frame horizontal alignRight.
					c frame vertical alignCenter.
	];
	transformDo: [ :t|
		t translateBy:-10@ 0. 
		].
	
	self indicator: (TbLED new).
	indicator constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:0@ 14. 
		].
	
	g1:= BlElement new
		geometry: BlRectangleGeometry new;
		size:14@120;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignTop.
				];
				transformDo: [ :t|
			t translateBy:0@ 0. 
		].
		g2:= BlElement new
		geometry: BlRectangleGeometry new;
		size:330@40;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:0@ 0. 
		].
		
		
	
	self addChildren: {label.self indicator. g2. self switch. g1}.
	self initializeLines.
		self initializeTexts.
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initializeLines [
	"li are the lines."
	|l1 l2 l3 l4 l5 l6 l7|
	l1:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@40;
		background:Color white;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:0@ 0. 
		].
	l2:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@40;
		background:Color white;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:82@ 0. 
		].
	l3:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@20;
		background:Color white;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:-82@ 0. 
		].
	l4:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@35;
		background:Color veryVeryDarkGray;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				];
				transformDo: [ :t|
			t translateBy:0@ 5. 
		].
	l5:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@35;
		background:Color veryVeryDarkGray ;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				];
				transformDo: [ :t|
			t translateBy:82@ 5. 
		].
	l6:= BlElement new
		geometry: BlRectangleGeometry new;
		size:2@35;
		background:Color veryVeryDarkGray ;
		constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter.
				];
				transformDo: [ :t|
			t translateBy:-82@ 5. 
		].
	l7:= BlElement new
		geometry: BlRectangleGeometry new;
		size:145@1;
		background:Color white;
		constraintsDo: [ :c |
					c frame horizontal alignLeft.
					c frame vertical alignBottom.
				];
				transformDo: [ :t|
			t translateBy:10@ -20. 
		].
	
	
	self addChildren:{l1. l2. l3. l4. l5. l6. l7}. 
	
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initializeTexts [
	"ti are the texts written."
	|t1 t2 t3 t4 t5|
	t1 := BlTextElement new.
	t1 text: (self configuredStringDark: 'DOWN' size:16);
	 constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
		];
	 transformDo: [ :t|
		t translateBy:25 @ -6. 
		].
	
	t2 := BlTextElement new.
	t2 text: (self configuredStringDark: 'UP' size:16);
	 constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
		];
	 transformDo: [ :t|
		t translateBy:-45 @ -6. 
		].
	t3 := BlTextElement new.
	t3 text: (self configuredStringDark: 'ACCENT' size:18);
	 constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
		];
	 transformDo: [ :t|
		t translateBy:42 @ -15. 
		].
	
	t4 := BlTextElement new.
	t4 text: (self configuredStringDark: 'SLIDE' size:18);
	 constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignBottom.
		];
	 transformDo: [ :t|
		t translateBy:-20 @ -15. 
		].
	t5 := BlTextElement new.
	t5 text: (self configuredStringDark: 'TRANSPOSE' size:16);
	 constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
		];
	 transformDo: [ :t|
		t translateBy:45 @ -25. 
		].
	self addChildren:{t1. t2. t3. t4. t5}.
	
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initializeWidget [
	self size: widgetSize.
	self background: (Color veryVeryDarkGray alpha:0.0).
	self layout: BlFrameLayout new.
]

{ #category : 'initialization' }
TbWidget_TimeMode >> initializeWidgetSize [
		widgetSize:= 330@120.
]

{ #category : 'setting' }
TbWidget_TimeMode >> setValue: req [
	self value = req 
		ifFalse: [ 
			self toggle.
			].
]

{ #category : 'accessing' }
TbWidget_TimeMode >> shadowColor [
	^ (Color orange alpha:1.0)
	"^ (Color darkGray alpha:1.0)"
]

{ #category : 'accessing' }
TbWidget_TimeMode >> switch [
	^switch
]

{ #category : 'setting' }
TbWidget_TimeMode >> switch: aBlock [
	switch:= aBlock.
]

{ #category : 'api - operations' }
TbWidget_TimeMode >> toggle [
	"Toggles the value of indicator and the widget (The switch is toggled automatically due to its own toggle nature)"
	self toggleValue.
	self indicator toggle.
	
]

{ #category : 'api - operations' }
TbWidget_TimeMode >> toggleValue [
	"Toggles the value of widget (not the value of inner elements)"
	self value = 0 
		ifTrue: [ 
			self value: 1.
			] 
		ifFalse: [ 
			self value: 0. 
			].
]

{ #category : 'accessing' }
TbWidget_TimeMode >> value [
	^value
]

{ #category : 'setting' }
TbWidget_TimeMode >> value: anInteger [
	value:= anInteger.
]
