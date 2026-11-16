"
I am a test backend that only knows the horizontal slider, so every fallback lands on it. I implement no meter and no panel: they stay subclassResponsibility, which the meter test relies on.
"
Class {
	#name : 'ICLinearOnlyFactory',
	#superclass : 'ICWidgetFactory',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'visiting' }
ICLinearOnlyFactory >> visitHorizontalSlider: aParameter [
	"visiting"

	^ #horizontalSlider
]
