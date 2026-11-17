"
I display every Sequencer of a Performance as a stack of ICSequencerDisplay lanes, sorted by key, each in its own DiceTherapy hue. The lanes scroll vertically when they outgrow maxHeight.

	Performance uniqueInstance display.
	(ICPerformanceDisplay on: Performance uniqueInstance) openInWindow.

Send #rebuild after adding or removing sequencers.
"
Class {
	#name : 'ICPerformanceDisplay',
	#superclass : 'BlElement',
	#instVars : [
		'performance',
		'lanes',
		'maxHeight',
		'shownSequencers'
	],
	#category : 'CoypuIDE-stepSequencer',
	#package : 'CoypuIDE',
	#tag : 'stepSequencer'
}

{ #category : 'instance creation' }
ICPerformanceDisplay class >> on: aPerformance [

	^ self new
		  performance: aPerformance;
		  yourself
]

{ #category : 'live refresh' }
ICPerformanceDisplay >> checkForChanges [
	"add, drop or replace lanes when the performance changed, then let each lane check its sequencer"

	performance ifNil: [ ^ self ].
	self isUpToDate ifFalse: [ self syncLanes ].
	lanes children do: [ :each | each checkForChanges ]
]

{ #category : 'opening' }
ICPerformanceDisplay >> fitWindow [
	"as wide as the widest lane, as tall as the lanes up to maxHeight: the rest scrolls"

	(lanes isNil or: [ self isAttachedToSceneGraph not ]) ifTrue: [ ^ self ].
	self space extent: lanes width @ (lanes height min: maxHeight)
]

{ #category : 'initialization' }
ICPerformanceDisplay >> initialize [

	super initialize.
	maxHeight := 800.
	self
		layout: BlFrameLayout new;
		background: Color black;
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ]
]

{ #category : 'live refresh' }
ICPerformanceDisplay >> isUpToDate [
	"same sequencers, by identity: Sequencer redefines ="

	| current |
	current := self sequencers.
	^ current size = shownSequencers size and: [
		  (1 to: current size) allSatisfy: [ :i | (current at: i) == (shownSequencers at: i) ] ]
]

{ #category : 'colors' }
ICPerformanceDisplay >> laneColors [
	"the DiceTherapy lane hues: saw orange, square blue, tri green, bell yellow, acid violet, pluck red, pad grey, organ cyan"

	^ #( 'ff9933' '4f9dff' '4fe58c' 'ffe14d' 'dc6cff' 'ff5c5c' 'b0b0b0' '3fe6e6' ) collect: [ :each | Color fromHexString: each ]
]

{ #category : 'accessing' }
ICPerformanceDisplay >> lanes [

	^ lanes
]

{ #category : 'accessing' }
ICPerformanceDisplay >> maxHeight [

	^ maxHeight
]

{ #category : 'accessing' }
ICPerformanceDisplay >> maxHeight: aNumber [

	maxHeight := aNumber.
	self fitWindow
]

{ #category : 'opening' }
ICPerformanceDisplay >> openInWindow [
	"open me in a window that refreshes when the performance or its sequencers change and shows the playhead"

	| space |
	space := BlSpace new.
	space title: 'Performance'.
	space root
		background: Color black;
		addChild: self.
	self watchEvery: self refreshDelay.
	self watchPlayheadEvery: self playheadDelay.
	space show.
	^ space
]

{ #category : 'accessing' }
ICPerformanceDisplay >> performance [

	^ performance
]

{ #category : 'accessing' }
ICPerformanceDisplay >> performance: aPerformance [

	performance := aPerformance.
	self rebuild
]

{ #category : 'playhead' }
ICPerformanceDisplay >> playheadDelay [

	^ 15 milliSeconds
]

{ #category : 'building' }
ICPerformanceDisplay >> rebuild [

	| scrollable scrollbar |
	self removeChildren.
	performance ifNil: [ ^ self ].
	lanes := BlElement new
		         layout: BlLinearLayout vertical;
		         background: Color black;
		         constraintsDo: [ :c |
				         c horizontal fitContent.
				         c vertical fitContent ];
		         yourself.
	lanes addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt | self fitWindow ].
	scrollable := lanes asScrollableElement.
	scrollable constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	scrollbar := BlVerticalScrollbarElement new.
	scrollbar constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ].
	scrollbar attachTo: scrollable.
	self addChildren: {
			scrollable.
			scrollbar }.
	self syncLanes
]

{ #category : 'live refresh' }
ICPerformanceDisplay >> refreshDelay [

	^ 200 milliSeconds
]

{ #category : 'accessing' }
ICPerformanceDisplay >> sequencers [
	"my performance's sequencers, sorted by key"

	^ ((performance associations select: [ :each | each value isKindOf: Sequencer ]) sort: [ :a :b | a key <= b key ]) collect: [
		  :each | each value ]
]

{ #category : 'live refresh' }
ICPerformanceDisplay >> syncLanes [
	"one lane per sequencer, keeping the lanes of sequencers that are still there"

	| existing colors |
	existing := IdentityDictionary new.
	lanes children do: [ :each | existing at: each sequencer put: each ].
	colors := self laneColors.
	shownSequencers := self sequencers.
	lanes removeChildren.
	shownSequencers withIndexDo: [ :each :index |
			| lane color |
			color := colors at: index - 1 \\ colors size + 1.
			lane := existing at: each ifAbsent: [ ICSequencerDisplay on: each ].
			lane triggeredColor = color ifFalse: [ lane triggeredColor: color ].
			lanes addChild: lane ]
]

{ #category : 'playhead' }
ICPerformanceDisplay >> updatePlayhead [

	lanes ifNil: [ ^ self ].
	lanes children do: [ :each | each updatePlayheadFrom: performance ]
]

{ #category : 'live refresh' }
ICPerformanceDisplay >> watchEvery: aDuration [
	"poll for changes from the UI thread; the task ends with my window"

	self enqueueTask: (BlRepeatedTaskAction new
			 delay: aDuration;
			 action: [ self checkForChanges ];
			 yourself)
]

{ #category : 'playhead' }
ICPerformanceDisplay >> watchPlayheadEvery: aDuration [
	"follow the transport from the UI thread; the task ends with my window"

	self enqueueTask: (BlRepeatedTaskAction new
			 delay: aDuration;
			 action: [ self updatePlayhead ];
			 yourself)
]
