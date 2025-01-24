Extension { #name : 'DSP' }

{ #category : '*CoypuIDE' }
DSP >> connectToOSCServerOnPort: aPort [
"should we check for all children???"
(self displayedUI children at: 1) connectToOSCServer listenOnPort: aPort
]

{ #category : '*CoypuIDE' }
DSP >> displayUI [
	"full UI made with Toplo"

	| container allParams allKnobs containerKnobs sortedKnobs space |
	space := BlSpace new title: 'DSP UI'.
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

	space root addChild: container.

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
