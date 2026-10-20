"
I am a Faust _button_, momentary. JUCE has no momentary parameter, so the plugin latches me.
"
Class {
	#name : 'ICButtonKind',
	#superclass : 'ICControlKind',
	#category : 'CoypuIDE-Panel',
	#package : 'CoypuIDE',
	#tag : 'Panel'
}

{ #category : 'visiting' }
ICButtonKind >> acceptVisitor: aVisitor for: aParameter [

	^ aVisitor visitButton: aParameter
]
