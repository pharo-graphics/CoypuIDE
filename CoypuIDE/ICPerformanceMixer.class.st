"
I am a mixer that shows only the faders of the instruments that are in the Performance (plus the ones I always show, like master). TurboPhuck>>displayUIForGains and DSP>>displayUIForLevels are built on me. Tests give me performedNames: a block instead of reading the Performance.
"
Class {
	#name : 'ICPerformanceMixer',
	#superclass : 'Object',
	#instVars : [
		'emptyElement',
		'faders',
		'alwaysShown',
		'performedNames',
		'title',
		'grid',
		'space',
		'columns',
		'pollDelay'
	],
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'instance creation' }
ICPerformanceMixer class >> title: aString [

	^ self new
		  title: aString;
		  yourself
]

{ #category : 'adding' }
ICPerformanceMixer >> add: aFader for: anInstrumentName [

	faders at: anInstrumentName asString put: aFader.
	^ aFader
]

{ #category : 'adding' }
ICPerformanceMixer >> alwaysShow: anInstrumentName [

	alwaysShown add: anInstrumentName asString
]

{ #category : 'accessing' }
ICPerformanceMixer >> columns [
	"faders per row"

	^ columns ifNil: [ 16 ]
]

{ #category : 'accessing' }
ICPerformanceMixer >> columns: anInteger [

	columns := anInteger
]

{ #category : 'building' }
ICPerformanceMixer >> element [
	"the grid of the faders to show, polling the Performance while it is in a space"

	grid ifNotNil: [ ^ grid ].
	grid := self newGrid.
	self refresh.
	grid enqueueTask: (BlRepeatedTaskAction new
			 delay: self pollDelay;
			 action: [ self refresh ];
			 yourself).
	^ grid
]

{ #category : 'building' }
ICPerformanceMixer >> emptyElement [
	"shown instead of the faders when there is none to show, so the window does not collapse"

	^ emptyElement ifNil: [
			  | text |
			  text := 'No instrument of the Performance yet' asRopedText.
			  text
				  fontSize: 12;
				  foreground: Color gray.
			  emptyElement := BlTextElement new
				                  text: text;
				                  padding: (BlInsets all: 20);
				                  yourself ]
]

{ #category : 'accessing' }
ICPerformanceMixer >> faders [
	"instrument name -> fader, every fader, shown or not"

	^ faders
]

{ #category : 'initialization' }
ICPerformanceMixer >> initialize [

	super initialize.
	faders := OrderedDictionary new.
	alwaysShown := Set new
]

{ #category : 'building' }
ICPerformanceMixer >> newGrid [

	^ BlElement new
		  geometry: BlRectangleGeometry new;
		  layout: (BlGridLayout new
				   columnCount: self columns;
				   cellSpacing: 0);
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  background: Color black;
		  yourself
]

{ #category : 'opening' }
ICPerformanceMixer >> open [
	"a window following the faders shown, scrolling when they are too many"

	| ui scroller |
	ui := self element.
	ui forceLayout.
	scroller := ui asScrollableElement.
	scroller constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	space := BlSpace new
		         title: self title;
		         extent: (self windowExtentFor: ui extent);
		         yourself.
	space root
		background: Color black;
		addChild: scroller.
	ui addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt | space extent: (self windowExtentFor: evt target extent) ].
	space show.
	^ space
]

{ #category : 'polling' }
ICPerformanceMixer >> performedNames [
	"the instrument names in the Performance, as strings"

	^ ((performedNames ifNil: [ [ Performance uniqueInstance keys ] ]) value collect: [ :each | each asString ]) asSet
]

{ #category : 'accessing' }
ICPerformanceMixer >> performedNames: aBlock [
	"answers the instrument names instead of the Performance; for tests"

	performedNames := aBlock
]

{ #category : 'accessing' }
ICPerformanceMixer >> pollDelay [

	^ pollDelay ifNil: [ 500 milliSeconds ]
]

{ #category : 'accessing' }
ICPerformanceMixer >> pollDelay: aDuration [

	pollDelay := aDuration
]

{ #category : 'polling' }
ICPerformanceMixer >> refresh [
	"show the faders to show, touching the grid only when they changed"

	| shown |
	grid ifNil: [ ^ self ].
	shown := self shownFaders ifEmpty: [ { self emptyElement } ].
	grid children asArray = shown ifTrue: [ ^ self ].
	grid
		removeChildren;
		addChildren: shown
]

{ #category : 'polling' }
ICPerformanceMixer >> shownFaders [
	"the faders always shown and those of the instruments in the Performance, in my order"

	| performed |
	performed := self performedNames.
	^ (faders associations
		   select: [ :each | (alwaysShown includes: each key) or: [ performed includes: each key ] ]
		   thenCollect: [ :each | each value ]) asArray
]

{ #category : 'accessing' }
ICPerformanceMixer >> space [

	^ space
]

{ #category : 'accessing' }
ICPerformanceMixer >> title [

	^ title ifNil: [ 'Mixer' ]
]

{ #category : 'accessing' }
ICPerformanceMixer >> title: aString [

	title := aString
]

{ #category : 'opening' }
ICPerformanceMixer >> windowExtentFor: aPoint [

	^ (aPoint x max: 240) @ (aPoint y min: 900)
]
