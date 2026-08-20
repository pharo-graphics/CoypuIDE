"
I am an ICFader drawn as an outline: a transparent bar with a green border and
square corners, instead of my parent's filled rounded bar. I am bigger by default
too - 150 x 40 with 10pt margins.

I add no behaviour. Everything - sizing, dragging, value mapping, labels - comes
from ICFader; I only override colours, the bar's look, and the default sizes.
```language=Pharo
	ICFader2 beVertical.
	ICFader2 label: 'Cutoff'.
	(ICFader2 label: 'Cutoff') barLength: 240 thickness: 56.
```
Because I exist only to restyle my parent, I am a good candidate to become a style object rather than a subclass once ICFader supports one.

"
Class {
	#name : 'ICFader2',
	#superclass : 'ICFader',
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'defaults' }
ICFader2 class >> defaultBarLength [

 ^ 150 

]

{ #category : 'defaults' }
ICFader2 class >> defaultBarThickness [ 
^ 40 
]

{ #category : 'defaults' }
ICFader2 class >> defaultMarginLength [ 
 ^ 10 
]

{ #category : 'defaults' }
ICFader2 class >> defaultMarginThickness [ 
 ^ 10 
]

{ #category : 'examples' }
ICFader2 class >> example [ 
	<script>
	| faders row space |
	faders := #( #( 120 24 ) #( 180 40 ) #( 240 56 ) ) collect: [ :pair |
		          ((self label:
			            pair first printString , 'x' , pair second printString)
			           beVertical;
			           yourself)
			          barLength: pair first
			          thickness: pair second;
			          yourself ].

	row := BlElement new
		       layout: BlLinearLayout horizontal alignCenter;
		       constraintsDo: [ :c |
			       c horizontal matchParent.
			       c vertical matchParent ];
		       background: Color black;
		       addChildren: faders;
		       yourself.

	space := BlSpace new.
	space extent: 700 @ 480.
	space title: 'ICFader2'.
	space root
		background: Color black;
		addChild: row.
	space show

]

{ #category : 'api - bounds' }
ICFader2 >> barDefaultColor [ 

	^ (Color lightGray alpha:0.0).
]

{ #category : 'api - bounds' }
ICFader2 >> defaultBar [ 

^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 0);
		  background: self barDefaultColor;
		  border: (BlBorder paint: Color green width: 2);
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : 'accessing' }
ICFader2 >> defaultBarLength [
	
	^150
]

{ #category : 'accessing' }
ICFader2 >> defaultBarThickness [ 
	^40
]

{ #category : 'api - bounds' }
ICFader2 >> defaultColor [

	^ Color veryVeryDarkGray

]

{ #category : 'api - bounds' }
ICFader2 >> defaultMarginLength [

	^ 10
]

{ #category : 'api - bounds' }
ICFader2 >> defaultMarginThickness [

	^ 10
]
