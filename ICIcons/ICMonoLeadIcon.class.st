Class {
	#name : 'ICMonoLeadIcon',
	#superclass : 'ICIcon',
	#category : 'ICIcons',
	#package : 'ICIcons'
}

{ #category : 'initialization' }
ICMonoLeadIcon >> initialize [
	super initialize.
	self initializeSize.
	self initializeLineColor.
	self initializeBackColor.
	self initializeIcon.
]

{ #category : 'initialization' }
ICMonoLeadIcon >> initializeIcon [
	|container ele ele2 ele3 ele4 ele5 |
	container:= BlElement new
	size: 80 @80;
	geometry:BlRectangleGeometry new;
	background: background ;
	layout: BlFrameLayout new;
	padding:(BlInsets all: 10).

ele:= BlElement new
	geometry: BlRectangleGeometry new;
	size: 6 @ 60;
	background:color;
	constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter.
		].

ele2:= BlElement new
	geometry: BlRectangleGeometry new;
	size: 6 @ 35;
	background:color;
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignLeft.
		].

ele3:= BlElement new
	geometry: BlRectangleGeometry new;
	size: 6 @ 35;
	background:color;
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignRight.
		].

ele4:= BlElement new
	geometry: BlRectangleGeometry new;
	size: 30 @ 6;
	background:color;
	constraintsDo: [ :c |
		c frame vertical alignTop.
		c frame horizontal alignLeft.
		].

ele5:= BlElement new
	geometry: BlRectangleGeometry new;
	size: 30 @ 6;
	background:color;
	constraintsDo: [ :c |
		c frame vertical alignBottom.
		c frame horizontal alignRight.
		].

container addChildren:{ele . ele2 .ele3 .ele4 .ele5}.

self addChild: container.
]
