Extension { #name : 'DSP' }

{ #category : '*CoypuIDE' }
DSP >> buildUI [
	"build the panel from the Faust JSON (ICFaustUIBuilder): Faust's groups (vgroup, hgroup,
	tgroup as tabs) and annotations (style, unit, scale, tooltip, hidden), in Faust's order.
	Each run of widgets wraps in up to 8 columns, fewer until the panel fits maxKnobsWidth.
	The panel shrinks to its widgets; past maxKnobsHeight it stops growing and scrolls
	vertically. The piano keyboard (MIDI DSPs) sits below and plays freq and gate."

	| midi builder content cols scrollable vscroll knobsArea contentExtent needsScroll container |
	ICValueDisplay isUpdating: true.
	midi := self requirePianoKeyboard.
	builder := (ICFaustUIBuilder forDsp: self)
		           skipsPianoKeys: midi;
		           yourself.
	content := builder build.
	content background: Color veryVeryDarkGray.

	"natural size: drop columns until it fits maxKnobsWidth"
	content forceLayout.
	cols := builder maxColumns.
	[ content extent x > self class maxKnobsWidth and: [ cols > 1 ] ] whileTrue: [
			cols := cols - 1.
			builder maxColumns: cols.
			builder grids do: [ :each | each requestLayout ].
			content
				requestLayout;
				forceLayout ].
	contentExtent := content extent.
	needsScroll := contentExtent y > self class maxKnobsHeight.

	scrollable := content asScrollableElement.
	scrollable constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	knobsArea := BlElement new
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
				             c horizontal exact: contentExtent x + (needsScroll
								              ifTrue: [ 10 ]
								              ifFalse: [ 0 ]).
				             c vertical exact: (contentExtent y min: self class maxKnobsHeight) ];
		             addChild: scrollable;
		             yourself.

	needsScroll ifTrue: [
			vscroll := BlVerticalScrollbarElement new.
			vscroll constraintsDo: [ :c |
					c ignoreByLayout.
					c ignored horizontal alignRight.
					c ignored vertical alignBottom ].
			vscroll attachTo: scrollable.
			knobsArea addChild: vscroll ].

	"outer container: knobs area, then the keyboard, sized to its content"
	container := BlElement new
		             layout: BlLinearLayout vertical;
		             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ];
		             background: Color black lighter;
		             addChild: knobsArea;
		             yourself.

	midi ifTrue: [ container addChild: (ICPianoKeyboardElement newForDsp: self) ].

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
DSP >> closeSpaceOfDestroyedDsp: aSpace [
	"the DSP is gone: its widgets must never talk to it again. destroy may run in any process, so the closing goes through the space's own task queue"

	self announcer unsubscribe: aSpace.
	self stopValueDisplaysIn: aSpace root.
	displayedUI := nil.
	aSpace isOpened ifTrue: [
		aSpace enqueueTask: (BlTaskAction new action: [ aSpace isOpened ifTrue: [ aSpace close ] ]) ]
]

{ #category : '*CoypuIDE' }
DSP >> closeSpaceOnDestroy: aSpace [
	"aSpace shows this DSP: close it when the DSP is destroyed (or discarded, see PhDspDestroyed); when it closes, for any reason, its bargraphs stop polling and the subscription is forgotten"

	self announcer
		when: PhDspDestroyed
		do: [ :announcement | self closeSpaceOfDestroyedDsp: aSpace ]
		for: aSpace.
	aSpace
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ :event |
			self stopValueDisplaysIn: aSpace root.
			self announcer unsubscribe: aSpace ].
	^ aSpace
]

{ #category : '*CoypuIDE' }
DSP >> connectToOSCServerOnPort: aPort [
"should we check for all children???"
(self displayedUI children at: 1) connectToOSCServer listenOnPort: aPort
]

{ #category : '*CoypuIDE' }
DSP >> displayParameters [
	"Open a space listing all available parameters of this DSP; it closes when the DSP is destroyed"

	self isInitialized ifFalse: [ ^ self error: 'This DSP is not initialized' ].
	^ (self closeSpaceOnDestroy: self parametersSpace)
		show;
		yourself
]

{ #category : '*CoypuIDE' }
DSP >> displayUI [
	"display the UI made with Bloc; the window fits the widgets (knob area scrolls
	when taller than maxKnobsHeight); it closes when the DSP is destroyed, and its
	bargraphs stop polling when it closes (those of other windows keep going)"

	| space |
	self buildUI.
	"measure before attaching: Bloc refuses forceLayout inside a space"
	self displayedUI forceLayout.

	space := BlSpace new title: self name , ' UI'.
	space root
		background: Color black lighter;
		layout: BlLinearLayout horizontal alignTopLeft;
		addChild: self displayedUI.
	space extent: self displayedUI extent.
	self closeSpaceOnDestroy: space.

	space show.
	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayUIForLevels [
	"display the level mixer UI made with Bloc: only the instruments in the Performance, following it"

	^ self displayUIForLevelsWithTitle: self name , ' Levels'
]

{ #category : '*CoypuIDE' }
DSP >> displayUIForLevelsWithTitle: aString [
	"display the level mixer UI made with Bloc: only the instruments in the Performance, following it; it closes when the DSP is destroyed"

	| mixer |
	mixer := self levelMixerTitled: aString.
	displayedUI := mixer element.
	^ self closeSpaceOnDestroy: mixer open
]

{ #category : '*CoypuIDE' }
DSP >> displayUIIMorphicHost [
	"fdisplay the IU made with Bloc; it closes when the DSP is destroyed, and its bargraphs stop when it closes"

	| space |
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
	self closeSpaceOnDestroy: space.
	space useMorphicHost.
	space show.
	^ space
]

{ #category : '*CoypuIDE' }
DSP >> displayUIScaledBy: aScaleFactor [
	"display a scaled UI made with Bloc; it closes when the DSP is destroyed"

	| space |
	"first we build the UI"
	self buildUI.
	displayedUI transformDo: [ :t | t scaleBy: aScaleFactor ].
	space := BlSpace new title: 'DSP UI'.
	space root addChild: self displayedUI.
	self displayedUI
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].
	self closeSpaceOnDestroy: space.
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
DSP >> instrumentNameForLevel: aParameterName [
	"kickuLevel and kickLevel are the levels of kick"

	(aParameterName endsWith: 'uLevel') ifTrue: [ ^ aParameterName allButLast: 6 ].
	(aParameterName endsWith: 'Level') ifTrue: [ ^ aParameterName allButLast: 5 ].
	^ aParameterName
]

{ #category : '*CoypuIDE' }
DSP >> levelMixerTitled: aString [
	"one ICTurboGainFader per Level parameter, alphabetically, each shown while its instrument is in the Performance"

	| levels mixer |
	levels := self getUIItemsLabeledDictionary associations select: [ :each | each key includesSubstring: 'Level' ].
	levels := levels sorted: [ :a :b | a key asLowercase <= b key asLowercase ].
	mixer := ICPerformanceMixer title: aString.
	levels do: [ :each |
			| item parameter name |
			item := each value.
			parameter := item at: #shortname.
			name := self instrumentNameForLevel: parameter.
			mixer
				add: (ICTurboGainFader
						 label: name
						 min: (item at: #min)
						 max: (item at: #max)
						 value: (item at: #init)
						 step: (item at: #step)
						 callBack: [ :value | self setValue: value parameter: parameter ])
				for: name ].
	^ mixer
]

{ #category : '*CoypuIDE' }
DSP class >> maxKnobsHeight [
	"tallest the knob area of a DSP UI grows before it scrolls (4 rows of knobs)"

	^ 640
]

{ #category : '*CoypuIDE' }
DSP class >> maxKnobsWidth [
	"widest the knob area of a DSP UI may be: buildUI uses the most columns (up to 8) that fit"

	^ 1000
]

{ #category : '*CoypuIDE' }
DSP >> openWidgetFor: aSymbol [
	"open a window with the widget of one parameter; it closes when the DSP is destroyed"

	| allParams entry widget space |
	allParams := self getUIItemsLabeledDictionary.
	entry := allParams at: aSymbol.
	widget := BlElement new fromDictionary: entry forDsp: self.
	space := BlSpace new.
	self closeSpaceOnDestroy: space.
	space show.
	widget
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :evt | space extent: evt target extent ].

	space root addChild: widget.
	^ space
]

{ #category : '*CoypuIDE' }
DSP >> parametersColumn: aCollection [
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: (aCollection collect: [ :each | ToLabel text: each asString ]);
		yourself
]

{ #category : '*CoypuIDE' }
DSP >> parametersElement [
	^ CoypuParametersElement on: self allParameters
]

{ #category : '*CoypuIDE' }
DSP >> parametersSpace [
	^ BlSpace new
		title: 'DSP Parameters';
		in: [ :space | space root addChild: self parametersElement ];
		yourself
]

{ #category : '*CoypuIDE' }
DSP >> setValue: aFloat ofItem: aDictionary [
	"aDictionary is a leaf of the Faust JSON ui: use its full address when it has one, else its short name"

	^ (aDictionary at: #address ifAbsent: [ nil ])
		  ifNil: [ self setValue: aFloat parameter: (aDictionary at: #shortname) ]
		  ifNotNil: [ :address | self setValue: aFloat address: address ]
]

{ #category : '*CoypuIDE' }
DSP >> stopValueDisplaysIn: anElement [
	"the bargraphs shown in anElement stop polling this DSP; those of other windows keep going"

	anElement withAllChildrenBreadthFirstDo: [ :each |
		(each isKindOf: ICValueDisplay) ifTrue: [ each stopUpdating ] ]
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
