Extension { #name : 'DSP' }

{ #category : '*CoypuIDE' }
DSP >> buildUI [
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
				                   columnCount: 8;
				                   cellSpacing: 0);
		                  constraintsDo: [ :c |
				                  c horizontal matchParent.
				                  c vertical fitContent
				                  "c vertical matchParent " ];
		                  background: Color veryVeryDarkGray.
	container := BlElement new
		             layout: BlLinearLayout new beVertical;
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             background: Color black lighter.

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
	"display the IU made with Bloc"

	| space |
	"first we build the UI"
	self buildUI.
	space := BlSpace new title: self name , ' UI'.
	space root background: Color black lighter.
	space root addChild: self displayedUI.
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].


	"ADD EVENT HANDLER TO SAFELY TERMINATE EVERY ICVISUALIZER UPDATEVALUE PROCESS"
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
