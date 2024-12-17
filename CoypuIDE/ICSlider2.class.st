Class {
	#name : 'ICSlider2',
	#superclass : 'ICSlider',
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'examples' }
ICSlider2 class >> example [
	"The values of the slider are also written in the transcript"

	<script>
	| slider  container |
	slider := self beVertical.
	container := BlElement new clipChildren: false.
	container addChild: slider.
	container openInSpace.
]

{ #category : 'api - bounds' }
ICSlider2 >> barDefaultColor [ 

	^ (Color lightGray alpha:0.0).
]

{ #category : 'api - bounds' }
ICSlider2 >> defaultBar [

	| size |
	size := self
		        ifHorizontal: [
		        self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [
		        self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 0);
		  background: self barDefaultColor;
		border: (BlBorder paint: Color green width: 2);
		  size: size;
		constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : 'accessing' }
ICSlider2 >> defaultBarLength [
	
	^150
]

{ #category : 'accessing' }
ICSlider2 >> defaultBarThickness [ 
	^40
]

{ #category : 'api - bounds' }
ICSlider2 >> defaultColor [

	^ Color veryVeryDarkGray

]

{ #category : 'api - bounds' }
ICSlider2 >> defaultMarginLength [

	^ 10
]

{ #category : 'api - bounds' }
ICSlider2 >> defaultMarginThickness [

	^ 10
]
