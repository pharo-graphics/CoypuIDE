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
		'maxHeight'
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

	| space |
	space := BlSpace new.
	space title: 'Performance'.
	space root
		background: Color black;
		addChild: self.
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

{ #category : 'building' }
ICPerformanceDisplay >> rebuild [

	| colors scrollable scrollbar |
	self removeChildren.
	performance ifNil: [ ^ self ].
	colors := self laneColors.
	lanes := BlElement new
		         layout: BlLinearLayout vertical;
		         constraintsDo: [ :c |
				         c horizontal fitContent.
				         c vertical fitContent ];
		         addChildren: (self sequencers withIndexCollect: [ :each :index |
					          (ICSequencerDisplay on: each) triggeredColor: (colors at: index - 1 \\ colors size + 1) ]);
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
			scrollbar }
]

{ #category : 'accessing' }
ICPerformanceDisplay >> sequencers [
	"my performance's sequencers, sorted by key"

	^ ((performance associations select: [ :each | each value isKindOf: Sequencer ]) sort: [ :a :b | a key <= b key ]) collect: [
		  :each | each value ]
]
