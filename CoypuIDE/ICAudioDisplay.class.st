"
I display the value of an array in range [-1.0 1.0], as an Oscilloscope.
My main use is to diplay audio waveforms
"
Class {
	#name : 'ICAudioDisplay',
	#superclass : 'BlElement',
	#instVars : [
		'screen',
		'sections',
		'inputArr',
		'callBack',
		'widgetSize',
		'dataPoints'
	],
	#category : 'CoypuIDE-oscilloscope',
	#package : 'CoypuIDE',
	#tag : 'oscilloscope'
}

{ #category : 'example' }
ICAudioDisplay class >> Example [
<script>
| e |
e:= ICAudioDisplay new.
e openInSpace.
]

{ #category : 'creation' }
ICAudioDisplay class >> fromAiffFileName: anAiffFileName [ 

| f channel normalizedData bitDepthNormalization step downsampledData visualizer|

f := AiffFileReader new readFromFile: anAiffFileName .

channel := f channelData at: 1.
 
bitDepthNormalization  := 2 raisedTo: (f bitsPerSample - 1).

normalizedData := channel collect: [ :s | s / 32768.0 ].


step := (normalizedData size // self new y) max: 1.

"SIMPLE DOWNSAMPLING"
"downsampled := (1 to: normal size by: step) collect: [ :i | normal at: i ]"

"AVERAGE DOWNSAMPLING : SMOOTHER LOOK"
"downsampled := (1 to: normal size by: step) collect: [ :i |
    (normal copyFrom: i to: (i + step - 1 min: normal size)) average.
]."

"MIN-MAX SAMPLING : preserves the peaks of the waveform."
downsampledData := (1 to: normalizedData size by: step) flatCollect: [ :i |
    | segment minVal maxVal |
    segment := normalizedData  copyFrom: i to: (i + step - 1 min: normalizedData size).  "Extract the segment"
    minVal := segment inject: segment first into: [ :min :val | val < min ifTrue: [val] ifFalse: [min] ].
    maxVal := segment inject: segment first into: [ :max :val | val > max ifTrue: [val] ifFalse: [max] ].
    Array with: minVal with: maxVal  "Store min and max values for the segment"
].

visualizer := self fromArray:  downsampledData.  
^ visualizer
]

{ #category : 'creation' }
ICAudioDisplay class >> fromArray: anArr [
	 |ele|
	ele:= self new.
	ele inputValue: anArr.
	ele removeScreen.
	ele initializeSections.
	ele initializeGraph.
	^ele.
]

{ #category : 'as yet unclassified' }
ICAudioDisplay class >> openAsOscilloscope [

self shouldBeImplemented 
]

{ #category : 'example' }
ICAudioDisplay class >> readArrayExamples [
"fromArray is a class method used to initialize graph from an array of given input values."
<script>
|e|
e:= ICAudioDisplay fromArray: #(0.1 -0.5 0.3).

e datapoints.
e openInSpace.

"readArray is an instance method to change the graph from an array of new input values."
e readArray: #(0 -0.9 -0.2 0.6 -0.8 0.1 0.7 0.5 0.8 0.9 0.7 0.8).
"e readArray: #(0 0.9 0.2 0.6 0.8 -0.1 -0.7 0.5 -0.8 0.9 -0.7 -0.8)."
"e readArray: #(0 -0.9 0.2 -0.6 0.8 -0.1 -0.7 0.5 0.8 -0.9 0.7 -0.8)."






]

{ #category : 'initialization' }
ICAudioDisplay >> backColor [
	^ Color veryVeryDarkGray.

]

{ #category : 'initialization' }
ICAudioDisplay >> datapoints [
	^ dataPoints.

]

{ #category : 'initialization' }
ICAudioDisplay >> initialize [
	super initialize.
	self initializeWidgetSize.
	self initializeGeometry.
	self initializePoints.
	self initializeSections.
	self initializeGraph.

]

{ #category : 'initialization' }
ICAudioDisplay >> initializeGeometry [

	self extent: widgetSize.
	self background: self backColor.
	self layout: BlFrameLayout new
]

{ #category : 'initialization' }
ICAudioDisplay >> initializeGraph [

	| mul h |
	self initializeMarkers.
	mul := self y / 2.
	h := self y / 2.
	self screen: (BlElement new
			 extent: self x @ self y;
			 background: (Color red alpha: 0.0)).

	1 to: self datapoints size - 1 do: [ :i |
			| p1 p2 e off |
			p1 := self datapoints at: i.
			p2 := self datapoints at: i + 1.
			off := i - 1 * self sections.
			e := BlElement new
				     geometry: (BlLineGeometry
						      from: off @ (h - (p1 * mul))
						      to: off + self sections @ (h - (p2 * mul)));
				     outskirts: BlOutskirts centered;
				     border: (BlBorder paint: Color green width: 2).
			screen addChild: e ].

	self addChild: self screen
]

{ #category : 'initialization' }
ICAudioDisplay >> initializeMarkers [
	| m1 m2 m3 m4 m5 m6|
	m1:= (BlElement new
			geometry: (BlLineGeometry
						from: 10@10
						to: self x-10 @ 10);
						outskirts: BlOutskirts centered;
						border: (BlBorder paint:self markerColor width: 4)).
	m2:= (BlElement new
			geometry: (BlLineGeometry
						from: 10@10
						to: 10@(self y -10));
						outskirts: BlOutskirts centered;
						border: (BlBorder paint:self markerColor width: 4)).
	m3:= (BlElement new
			geometry: (BlLineGeometry
						from: 10 @ (self y -10)
						to: (self x - 10)@ (self y -10));
						outskirts: BlOutskirts centered;
						border: (BlBorder paint:self markerColor width: 4)).
	m4:= (BlElement new
			geometry: (BlLineGeometry
						from:( self x - 10) @10
						to: (self x -10)@ (self y -10));
						outskirts: BlOutskirts centered;
						border: (BlBorder paint: self markerColor width: 4)).
	m5:= (BlElement new
			geometry: (BlLineGeometry
						from:( self x /2) @10
						to: (self x /2)@ (self y -10));
						outskirts: BlOutskirts centered;
						border: (BlBorder paint: self markerColor width: 4)).
	m6:= (BlElement new
			geometry: (BlLineGeometry
						from:10 @(self y /2)
						to: (self x -10)@ (self y /2));
						outskirts: BlOutskirts centered;
						border: (BlBorder paint: self markerColor width: 4)).
	self addChildren: {m1. m2. m3. m4. m5. m6}.
	
]

{ #category : 'initialization' }
ICAudioDisplay >> initializePoints [
	self inputValue: #(0 0.3 -0.4 0.6 -1 0.7 0.5 0.9 -0.5 0.3 -1 0 0.4).


]

{ #category : 'initialization' }
ICAudioDisplay >> initializeSections [
		self datapoints size > 1
		ifTrue: [ self sections: (self x )/ (self length -1) ]
		ifFalse: [ self sections: self x ].

]

{ #category : 'initialization' }
ICAudioDisplay >> initializeWidgetSize [
	widgetSize:= self x@self y.

]

{ #category : 'initialization' }
ICAudioDisplay >> inputValue: anArray [
	dataPoints:= anArray.

]

{ #category : 'initialization' }
ICAudioDisplay >> length [
	^self datapoints size.

]

{ #category : 'initialization' }
ICAudioDisplay >> markerColor [
	^ Color veryDarkGray.

]

{ #category : 'as yet unclassified' }
ICAudioDisplay >> readArray: anArr [

	self inputValue: anArr.
	self removeScreen.
	self initializeSections.
	self initializeGraph.
	^self.
]

{ #category : 'initialization' }
ICAudioDisplay >> removeScreen [
	self removeChildren.
]

{ #category : 'initialization' }
ICAudioDisplay >> screen [
	^screen.
	


	
	
]

{ #category : 'initialization' }
ICAudioDisplay >> screen: anElement [
	screen:= anElement.


	
	
]

{ #category : 'initialization' }
ICAudioDisplay >> sections [
	^ sections

]

{ #category : 'initialization' }
ICAudioDisplay >> sections: anInteger [
	sections:= anInteger

]

{ #category : 'initialization' }
ICAudioDisplay >> x [

	^ 1200
]

{ #category : 'initialization' }
ICAudioDisplay >> y [
	^200

]
