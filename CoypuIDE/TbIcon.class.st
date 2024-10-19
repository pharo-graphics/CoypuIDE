Class {
	#name : 'TbIcon',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize'
	],
	#category : 'CoypuIDE-Acid',
	#package : 'CoypuIDE',
	#tag : 'Acid'
}

{ #category : 'examples' }
TbIcon class >> Example [ 
	<script>
	| container e1 e2 e3 e4 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 2;
		cellSpacing: 50
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: (Color r: 249 g:239  b:224  range:255).
		"background: Color white."

e1:=TbIcon_TransposeUp new.
e2:=TbIcon_TransposeDown new.
e3:=TbIcon_Accent new.
e4:=TbIcon_Selector0 new.

container addChildren: { e1. e2. e3. e4}.
container openInSpace.
	
]

{ #category : 'initialization' }
TbIcon >> initialize [

	super initialize.
	self background: (Color green alpha:0.0).
	self padding: (BlInsets all:0).
	self size: 50@40.
	self layout: BlFrameLayout new.
	self initializeIcon.

]

{ #category : 'initialization' }
TbIcon >> initializeIcon [
	
]
