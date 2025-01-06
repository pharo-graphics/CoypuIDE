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
	allParams := self getUIItemsLabeledDictionary.
	allKnobs := OrderedCollection new.
	allParams keysAndValuesDo: [ :k :v |
		allKnobs add: (BlElement new fromDictionary: v forDsp: self) ].
	sortedKnobs := allKnobs asSortedCollection: [ :a :b |
		               a inputText asLowercase < b inputText asLowercase ].

	containerKnobs := BlElement new
		                  geometry: BlRectangleGeometry new;
		                  extent: 1400 @ 674;
		                  layout: (BlGridLayout new
				                   columnCount: 8;
				                   cellSpacing: 0);
		                  constraintsDo: [ :c |
			                  c horizontal matchParent.
			                  c vertical fitContent
			                  "c vertical matchParent " ];
		                  background: Color black.
	container := BlElement new
		             extent: 1400 @ 800;
		             layout: BlLinearLayout new beVertical;
		             background: Color darkGray.

	containerKnobs addChildren: sortedKnobs.

	container addChild: containerKnobs.
	self requirePianoKeyboard ifTrue: [
		containerKnobs removeGateAndFreqElement.
		container addChild: (ICPianoKeyboardElement newForDsp: self) ].
	"we can later access the container if we need"
	displayedUI := container.

	space := BlSpace new extent: 1400 @ 800.
	
	space root addChild: container.
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
