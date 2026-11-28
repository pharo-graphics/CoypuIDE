"
I am a Bloc oscilloscope for the output of a PhuckVM (ChucK running in libphuck).

Every refreshDelay I ask my source for its latest output samples with scopeInto: (PhuckVM answers a mono mix of all output channels, copied by the audio callback into a lock-free ring buffer). I find the latest rising zero crossing, so a periodic wave stands still, and draw span samples as a single polyline.

Like the other CoypuIDE displays I poll from the UI thread: the audio thread never waits for me, I redraw only when new audio arrived, and my task ends with my window.

```language=Pharo
	PhuckVM uniqueInstance openScope.
	(ICPhuckScope on: PhuckVM uniqueInstance) span: 256; openInWindow.
```

openInWindow opens a 200 x 100 Morphic-hosted window in the bottom right corner of the Pharo world, above the taskbar.
My colors come from the Pharo theme in use (Smalltalk ui theme): its background, its border color for the center line and its success color for the trace.

span: is the zoom: how many samples go across my width (2 to half my buffer).
My source can be any object answering scopeInto: aFloatArray (fill it, answer a frame counter or nil).
"
Class {
	#name : 'ICPhuckScope',
	#superclass : 'BlElement',
	#instVars : [
		'source',
		'samples',
		'span',
		'trace',
		'centerLine',
		'lastPosition'
	],
	#category : 'CoypuIDE-oscilloscope',
	#package : 'CoypuIDE',
	#tag : 'oscilloscope'
}

{ #category : 'instance creation' }
ICPhuckScope class >> on: aSource [

	^ self new
		  source: aSource;
		  yourself
]

{ #category : 'accessing' }
ICPhuckScope >> backColor [

	^ self theme backgroundColor
]

{ #category : 'accessing' }
ICPhuckScope >> defaultExtent [
	"the size of my screen, without the window frame: a quarter of the world's width and a fifth of its height"

	| world |
	world := self currentWorld extent.
	^ (world x / 4) rounded @ (world y / 5) rounded
]

{ #category : 'drawing' }
ICPhuckScope >> drawTrace [
	"rebuild the geometry of my two layers for my current size"

	| w h |
	w := self width.
	h := self height.
	(w < 2 or: [ h < 2 ]) ifTrue: [ ^ self ].
	centerLine geometry: (BlPolylineGeometry vertices: {
				 (0 @ (h / 2)).
				 (w @ (h / 2)) }).
	trace geometry: (BlPolylineGeometry vertices: (self verticesFor: w @ h))
]

{ #category : 'initialization' }
ICPhuckScope >> initialize [

	super initialize.
	samples := Float32Array new: 2048.
	span := 1024.
	self
		extent: self defaultExtent;
		background: self backColor;
		layout: BlFrameLayout new.
	centerLine := self newLayerColored: self markerColor width: 1.
	trace := self newLayerColored: self traceColor width: 1.5.
	self addChildren: {
			centerLine.
			trace }.
	self addEventHandlerOn: BlElementExtentChangedEvent do: [ :evt | self drawTrace ]
]

{ #category : 'accessing' }
ICPhuckScope >> markerColor [

	^ self theme borderColor
]

{ #category : 'opening' }
ICPhuckScope >> moveToBottomRightOf: aSpace [
	"place the Morphic window hosting aSpace in the bottom right corner of the world, inside its clear area (above the taskbar, below the menu bar)"

	aSpace hostSpaceDo: [ :host |
			| window |
			window := host morphicWindow.
			window position: self currentWorld clearArea bottomRight - window extent ]
]

{ #category : 'initialization' }
ICPhuckScope >> newLayerColored: aColor width: aNumber [
	"a transparent child filling me, whose polyline geometry is stroked by its border"

	^ BlElement new
		  geometry: (BlPolylineGeometry vertices: {
						   (0 @ 0).
						   (1 @ 0) });
		  background: Color transparent;
		  outskirts: BlOutskirts centered;
		  border: (BlBorder paint: aColor width: aNumber);
		  constraintsDo: [ :c |
				  c horizontal matchParent.
				  c vertical matchParent ];
		  yourself
]

{ #category : 'opening' }
ICPhuckScope >> openInWindow [
	"open me in a resizable Morphic-hosted window in the bottom right corner, polling my source until it closes"

	| space |
	space := BlSpace new.
	space useMorphicHost.
	space title: 'Phuck scope'.
	space extent: self defaultExtent.
	self constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	space root
		background: self backColor;
		addChild: self.
	self watchEvery: self refreshDelay.
	space show.
	"the Morphic window exists only once the space is shown in the UI thread: move it from there"
	space enqueueTask: (BlTaskAction new
			 action: [ self moveToBottomRightOf: space ];
			 yourself).
	^ space
]

{ #category : 'live refresh' }
ICPhuckScope >> refresh [
	"poll my source; redraw only when new audio arrived"

	| position |
	source ifNil: [ ^ self ].
	position := source scopeInto: samples.
	(position isNil or: [ position = lastPosition ]) ifTrue: [ ^ self ].
	lastPosition := position.
	self drawTrace
]

{ #category : 'live refresh' }
ICPhuckScope >> refreshDelay [

	^ 33 milliSeconds
]

{ #category : 'accessing' }
ICPhuckScope >> samples [

	^ samples
]

{ #category : 'accessing' }
ICPhuckScope >> source [

	^ source
]

{ #category : 'accessing' }
ICPhuckScope >> source: anObject [

	source := anObject
]

{ #category : 'accessing' }
ICPhuckScope >> span [

	^ span
]

{ #category : 'accessing' }
ICPhuckScope >> span: anInteger [
	"how many samples go across my width; at most half my buffer, so a trigger point always leaves span samples after it"

	span := (anInteger max: 2) min: samples size // 2.
	self drawTrace
]

{ #category : 'accessing' }
ICPhuckScope >> theme [

	^ Smalltalk ui theme
]

{ #category : 'accessing' }
ICPhuckScope >> traceColor [

	^ self theme successTextColor
]

{ #category : 'drawing' }
ICPhuckScope >> triggerIndex [
	"the latest rising zero crossing that still leaves span samples after it; 1 when there is none (silence, DC)"

	samples size - span + 1 to: 2 by: -1 do: [ :i | ((samples at: i - 1) < 0.0 and: [ (samples at: i) >= 0.0 ]) ifTrue: [ ^ i ] ].
	^ 1
]

{ #category : 'drawing' }
ICPhuckScope >> verticesFor: anExtent [
	"one vertex per pixel column, from the trigger point; samples clamped to [-1, 1], +1 at the top"

	| start columns midY halfH |
	start := self triggerIndex.
	columns := anExtent x rounded max: 2.
	midY := anExtent y / 2.
	halfH := midY * 0.9.
	^ (0 to: columns - 1) collect: [ :x |
			  | s |
			  s := samples at: start + (x * (span - 1) // (columns - 1)).
			  x @ (midY - (((s max: -1.0) min: 1.0) * halfH)) ]
]

{ #category : 'live refresh' }
ICPhuckScope >> watchEvery: aDuration [
	"poll my source from the UI thread; the task ends with my window"

	self enqueueTask: (BlRepeatedTaskAction new
			 delay: aDuration;
			 action: [ self refresh ];
			 yourself)
]
