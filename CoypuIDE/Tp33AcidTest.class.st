Class {
	#name : 'Tp33AcidTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
Tp33AcidTest >> testMachineIsInIdleState [

	| machine |
	machine := Tp33 new.
	self assert: machine mode class equals: TpIdleMode
]
