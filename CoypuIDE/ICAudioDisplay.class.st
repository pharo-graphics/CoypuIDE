Class {
	#name : 'ICAudioDisplay',
	#superclass : 'BlElement',
	#instVars : [
		'sections',
		'inputArr',
		'callBack',
		'widgetSize',
		'dataPoints'
	],
	#category : 'CoypuIDE',
	#package : 'CoypuIDE'
}

{ #category : 'example' }
ICAudioDisplay class >> Example [
<script>
| e |
e:= self new.
e openInSpace.
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
	self initializePoints.
	self initializeWidgetSize.
	self initializeGeometry.
	self initializeMarkers.
	self initializeGraph.

]

{ #category : 'initialization' }
ICAudioDisplay >> initializeGeometry [
	self size: widgetSize.
	self background: self backColor.
	self layout: BlFrameLayout new.
	"self padding: (BlInsets all: 10)."
	self datapoints size > 1
		ifTrue: [ self sections: (self x )/ (self length -1) ]
		ifFalse: [ self sections: self x ].
	
	
]

{ #category : 'initialization' }
ICAudioDisplay >> initializeGraph [
	|mul h|
	mul:= self y/2.
	h:= self y/2.
	1 to: (self datapoints size - 1) do: [:i |
		|p1 p2 e off|
		p1:= self datapoints at: i.
		p2:= self datapoints at: i+1.
		off:= (i -1)* self sections.
		e:= (BlElement new
			geometry: (BlLineGeometry
						from: off@ (h -(p1*mul))
						to: (off+self sections)@  (h-(p2*mul)));
						outskirts: BlOutskirts centered;
						border: (BlBorder paint: Color green width: 2)).
		self addChild: e.
		
		].
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
	^400

]

{ #category : 'initialization' }
ICAudioDisplay >> y [
	^200

]
