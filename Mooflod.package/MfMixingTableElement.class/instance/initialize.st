initialization
initialize

	super initialize.
	self geometry: self defaultGeometry.
	self size: self tableExtent.
	keymap := Dictionary new.
	self background: Color black.
	self border: (BlBorder paint: Color blue width: 2).
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ]