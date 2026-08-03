Class {
	#name : 'ICMixerFaderTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'accessing' }
ICMixerFaderTest >> testDefaultValues [
    | fader |
    fader := ICMixerFader new.
    self assert: fader minValue equals: 0.
    self assert: fader maxValue equals: 100.
    self assert: fader value equals: 0
]

{ #category : 'tests' }
ICMixerFaderTest >> testSetValueClampsAboveMaximum [
    | fader |
    fader := ICMixerFader new.
    fader setValue: 150.
    self assert: fader value closeTo: fader maxValue
]

{ #category : 'tests' }
ICMixerFaderTest >> testSetValueClampsBelowMinimum [
    | fader |
    fader := ICMixerFader new.
    fader setValue: -20.
    self assert: fader value closeTo: fader minValue
]

{ #category : 'tests' }
ICMixerFaderTest >> testSetValueFiresCallBack [
    | fader fired |
    fired := OrderedCollection new.
    fader := ICMixerFader new.
    fader callBack: [ :v | fired add: v ].
    fader setValue: 42.
    self assert: fired size equals: 1.
    self assert: fired first closeTo: 42
]

{ #category : 'tests' }
ICMixerFaderTest >> testSetValueRoundTripHorizontal [
    | fader |
    fader := ICMixerFader beHorizontal.
    #( 0 25 50 75 100 ) do: [ :each |
        fader setValue: each.
        self assert: fader value closeTo: each ]
]

{ #category : 'tests' }
ICMixerFaderTest >> testSetValueRoundTripVertical [
    | fader |
    fader := ICMixerFader new.
    #( 0 25 50 75 100 ) do: [ :each |
        fader setValue: each.
        self assert: fader value closeTo: each ]
]

{ #category : 'tests' }
ICMixerFaderTest >> testSetValueVertical [
    | fader |
    fader := ICMixerFader new.
    fader setValue: 42.
    self assert: fader value closeTo: 42
]

{ #category : 'tests' }
ICMixerFaderTest >> testValueToCoordIsInverseOfValueAtCoord [
    | fader |
    fader := ICMixerFader new.
    #( 0 25 50 75 100 ) do: [ :each |
        self
            assert: (fader valueAtCoord: (fader valueToCoord: each))
            closeTo: each ]
]
