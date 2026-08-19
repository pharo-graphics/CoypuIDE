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
