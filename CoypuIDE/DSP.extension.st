Extension { #name : 'DSP' }

{ #category : '*CoypuIDE' }
DSP >> buildUI [
	"build the panel made with Bloc: grid sized to knob count, scaled to fit, top-left origin.
	Does NOT create or show a space; displayUI owns that."

	| container allParams allKnobs containerKnobs sortedKnobs
	  count cellExtent budget aspect cols rows naturalExtent scale |
	ICValueDisplay isUpdating: true.

	"collect and sort knobs"
	allParams := self getUIItemsLabeledDictionary.
	allKnobs := OrderedCollection new.
	allParams keysAndValuesDo: [ :k :v |
		allKnobs add: (BlElement new fromDictionary: v forDsp: self) ].
	sortedKnobs := allKnobs asSortedCollection: [ :a :b |
		a inputText asLowercase < b inputText asLowercase ].

	"column count and scale from knob count + budget"
	count := sortedKnobs size.
	cellExtent := 150 @ 180.   "measured knob cell: knob + label + readout"
	budget := 1400 @ 900.      "max panel size before shrinking kicks in"
	count isZero
		ifTrue: [ cols := 1. scale := 1.0 ]
		ifFalse: [
			aspect := (budget x / budget y) * (cellExtent y / cellExtent x).
			cols := (count * aspect) sqrt rounded max: 1.
			rows := (count / cols) ceiling.
			naturalExtent := (cols * cellExtent x) @ (rows * cellExtent y).
			scale := ((budget x / naturalExtent x)
				min: (budget y / naturalExtent y)) min: 1.0 ].

	"knob grid: fitContent so size flows up from the cells"
	containerKnobs := BlElement new
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
			columnCount: cols;
			cellSpacing: 0);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		background: Color veryVeryDarkGray;
		yourself.
	containerKnobs addChildren: sortedKnobs.

	"outer container, scaled from its top-left corner"
	container := BlElement new
		layout: BlLinearLayout new beVertical;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent.
			c accountTransformation ];
		background: Color black lighter;
		yourself.
	container addChild: containerKnobs.

	self requirePianoKeyboard ifTrue: [
		containerKnobs removeGateAndFreqElement.
		container addChild: (ICPianoKeyboardElement newForDsp: self) ].

	container transformDo: [ :t |
		t topLeftOrigin.
		t scaleBy: scale ].

	displayedUI := container.
	^ displayedUI
]

{ #category : '*CoypuIDE' }
DSP >> buildUIColumn: aNumberOfColumn [
	"build full UI made with Bloc"

	| container allParams allKnobs containerKnobs sortedKnobs space |
	space := BlSpace new title: self name , 'UI'.

	ICValueDisplay isUpdating: true.
	allParams := self getUIItemsLabeledDictionary.
	allKnobs := OrderedCollection new.
	allParams keysAndValuesDo: [ :k :v |
		allKnobs add: (BlElement new fromDictionary: v forDsp: self) ].
	sortedKnobs := allKnobs asSortedCollection: [ :a :b |
		               a inputText asLowercase < b inputText asLowercase ].

	containerKnobs := BlElement new
		                  geometry: BlRectangleGeometry new;
		                  layout: (BlGridLayout new
				                   columnCount: aNumberOfColumn;
				                   cellSpacing: 0);
		                  constraintsDo: [ :c |
				                  c horizontal matchParent.
				                  c vertical fitContent
				                  "c vertical matchParent " ];
		                  background: Color black.
	container := BlElement new
		             layout: BlLinearLayout new beVertical;
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             background: Color black.

	containerKnobs addChildren: sortedKnobs.

	container addChild: containerKnobs.
	self requirePianoKeyboard ifTrue: [
			containerKnobs removeGateAndFreqElement.
			self traceCr.
			container addChild: (ICPianoKeyboardElement newForDsp: self) ].
	"we can later access the container if we need"
	displayedUI := container.

	container
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].

	^ displayedUI
]

{ #category : '*CoypuIDE' }
DSP >> buildUIForLevels [
	"build full UI made with Bloc"

	| container allKnobs containerKnobs sortedKnobs space otherLabels levelParams |
	space := BlSpace new title: self name , 'TurboPhausto MIXER'.

	ICValueDisplay isUpdating: true.
	otherLabels := self allParameters reject: [ :i |
		               i includesSubstring: 'Level' ].
	levelParams := self getUIItemsLabeledDictionary.
	otherLabels do: [ :i | levelParams removeKey: i ].
	allKnobs := OrderedCollection new.
	levelParams keysAndValuesDo: [ :k :v |
		allKnobs add: (ICMixerFader new fromDictionary: v forDsp: self) ].
	sortedKnobs := allKnobs asSortedCollection: [ :a :b |
		               a name asLowercase < b name asLowercase ].

	containerKnobs := BlElement new
		                  geometry: BlRectangleGeometry new;
		                  layout: (BlGridLayout new
				                   columnCount: 16;
				                   cellSpacing: 0);
		                  constraintsDo: [ :c |
			                  c horizontal matchParent.
			                  c vertical fitContent
			                  "c vertical matchParent " ];
		                  background: Color black.
	container := BlElement new
		             layout: BlLinearLayout new beVertical;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ];
		             background: Color black.

	containerKnobs addChildren: sortedKnobs.

	container addChild: containerKnobs.
	self requirePianoKeyboard ifTrue: [
		containerKnobs removeGateAndFreqElement.
		self traceCr.
		container addChild: (ICPianoKeyboardElement newForDsp: self) ].
	"we can later access the container if we need"
	displayedUI := container.

	container
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].

	^ displayedUI
]

{ #category : '*CoypuIDE' }
DSP >> connectToOSCServerOnPort: aPort [
"should we check for all children???"
(self displayedUI children at: 1) connectToOSCServer listenOnPort: aPort
]

{ #category : '*CoypuIDE' }
DSP >> displayUI [
	"display the UI made with Bloc"
	| space |
	self buildUI.   "sets displayedUI to the scaled, top-left-origin panel"

	space := BlSpace new title: self name , ' UI'.
	space root
		background: Color black lighter;
		layout: BlLinearLayout horizontal alignTopLeft;
		addChild: self displayedUI.

	"window follows the panel's scaled extent"
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].

	"terminate every ICValueDisplay update process on close"
	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ ICValueDisplay isUpdating: false ].

	space show.
	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayUIForLevels [
	"display the level mixer UI made with Bloc"

	| space |
	"first we build the UI"
	self buildUIForLevels.
	space := BlSpace new title: self name , ' UI'.
	space root addChild: self displayedUI.
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].


	"ADD EVENT HANDLER TO SAFELY TERMINATE EVERY ICVISUALIZER UPDATEVALUE PROCESS"
	"space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ ICValueDisplay isUpdating: false ]."
	space show.


	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayUIForLevelsWithTitle: aString [
	"display the level mixer UI made with Bloc"

	| space |
	"first we build the UI"
	self buildUIForLevels.
	space := BlSpace new title: aString .
	space root addChild: self displayedUI.
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].


	"ADD EVENT HANDLER TO SAFELY TERMINATE EVERY ICVISUALIZER UPDATEVALUE PROCESS"
	"space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ ICValueDisplay isUpdating: false ]."
	space show.


	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayUIIMorphicHost [
	"fdisplay the IU made with Bloc"

	| space scaledUI |
	"first we build the UI"
	self buildUIColumn: 8.
	space := BlSpace new title: self name , ' UI'.
	self displayedUI transformDo: [ :d |
			d
				scaleBy: 0.8;
				translateBy: -100 @ -100 ].
	space root addChild: self displayedUI.
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].


	"ADD EVENT HANDLER TO SAFELY TERMINATE EVERY ICVISUALIZER UPDATEVALUE PROCESS"
	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ ICValueDisplay isUpdating: false ].
	space useMorphicHost.
	space show.


	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayUIScaledBy: aScaleFactor [
	"display a scaled UI made with Bloc"

	| space |
	"first we build the UI"
	self buildUI.
	displayedUI transformDo: [ :t | t scaleBy: aScaleFactor ].
	space := BlSpace new title: 'DSP UI'.
	space root addChild: self displayedUI.
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].


	"ADD EVENT HANDLER TO SAFELY TERMINATE EVERY ICVISUALIZER UPDATEVALUE PROCESS"
	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ Transcript show: 'Space closed' ].
	space show.


	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayedUI [

	^ displayedUI
]

{ #category : '*CoypuIDE' }
DSP >> displayedUI: aBlElement [

	displayedUI := aBlElement
]

{ #category : '*CoypuIDE' }
DSP >> openWidgetFor: aSymbol [

	| allParams entry widget space |
	allParams := self getUIItemsLabeledDictionary.
	entry := allParams at: aSymbol.
	widget := BlElement new fromDictionary: entry forDsp: self.
	space := BlSpace new.
	space show.
	widget
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].

	space root addChild: widget
]

{ #category : '*CoypuIDE' }
DSP >> widgetForParameter: aString [
	"creates a UI element for the Parameter, if it exists in the DSPy"

| dic |
dic := self getUIItemsLabeledDictionary .
(dic includesKey: aString) ifTrue: [^ BlElement new fromDictionary: (dic at: aString) forDsp: self] ifFalse: [ ^ Error new signal: 'Parameter ' ,  aString , ' does not exist in this DSP' ]

	
]

{ #category : '*CoypuIDE' }
DSP >> widgetForParameter: aString type: aSymbol [
	"creates a UI element for the Parameter, if it exists in the DSPy"

	| dic |
	dic := self getUIItemsLabeledDictionary.
	(dic includesKey: aString)
		ifTrue: [ ^ (BlElement  class environment at: aSymbol ) fromDictionary: (dic at: aString)  forDsp: self ]
		ifFalse: [ ^ Error new signal: 'Parameter ' , aString , ' does not exist in this DSP' ].
		
]
