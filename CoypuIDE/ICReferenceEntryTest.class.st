Class {
	#name : 'ICReferenceEntryTest',
	#superclass : 'TestCase',
	#instVars : [
		'entry'
	],
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'running' }
ICReferenceEntryTest >> setUp [

	super setUp.
	entry := (ICReferenceEntry name: 'repeatingFullRamp' category: 'Time')
		         range: '(-1,1)';
		         summary: 'Shortcut for !Gate repeatingFullRamp: 1 s.';
		         examples: #( '!Gate repeatingFullRamp: !Dur s' );
		         yourself
]

{ #category : 'tests' }
ICReferenceEntryTest >> testDefaultsAreNotNil [

	| empty |
	empty := ICReferenceEntry new.
	self assert: empty name equals: ''.
	self assert: empty summary equals: ''.
	self assert: empty category equals: 'Uncategorized'.
	self assert: empty examples isEmpty
]

{ #category : 'tests' }
ICReferenceEntryTest >> testEmptyPatternMatchesEverything [

	self assert: (entry matches: '').
	self assert: (entry matches: nil)
]

{ #category : 'tests' }
ICReferenceEntryTest >> testMatchesIsCaseInsensitive [

	self assert: (entry matches: 'REPEATING').
	self assert: (entry matches: 'fullramp')
]

{ #category : 'tests' }
ICReferenceEntryTest >> testMatchesOnName [

	self assert: (entry matches: 'repeating').
	self deny: (entry matches: 'zzz')
]

{ #category : 'tests' }
ICReferenceEntryTest >> testMatchesOnSummary [

	"The pattern is looked up in the summary too, not only in the name."

	self assert: (entry matches: 'Shortcut')
]

{ #category : 'tests' }
ICReferenceEntryTest >> testRangeIsNilWhenUnset [

	"Unlike the other getters, range stays nil so the browser can skip the line."

	self assert: ICReferenceEntry new range isNil
]
