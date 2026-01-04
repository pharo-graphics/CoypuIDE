"
Superclass for faders, knobs and any UI element that  adjusts a continuous value by moving something along a range
"
Class {
	#name : 'ICSlider',
	#superclass : 'BlElement',
	#category : 'CoypuIDE-slider',
	#package : 'CoypuIDE',
	#tag : 'slider'
}

{ #category : 'parameters' }
ICSlider >> forMidi [
	self minValue: 0 ; maxValue: 127; stepValue:  1.
]
