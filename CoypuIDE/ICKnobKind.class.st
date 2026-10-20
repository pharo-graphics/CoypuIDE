"
I am an _hslider_, _vslider_ or _nentry_ declared with **[style:knob]**. JUCE: Slider::RotaryHorizontalVerticalDrag.'.

"
Class {
	#name : 'ICKnobKind',
	#superclass : 'ICSliderKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICKnobKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitKnob: aParameter

]
