"
I am a Faust hslider. JUCE: Slider::LinearHorizontal.
"
Class {
	#name : 'ICHorizontalSliderKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'instance creation' }
ICHorizontalSliderKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitHorizontalSlider: aParameter

]
