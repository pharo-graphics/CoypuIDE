Extension { #name : 'PhuckVM' }

{ #category : '*CoypuIDE' }
PhuckVM >> displayParameters [
	"Open a space listing all ChucK globals registered in this VM"

	self isRunning ifFalse: [ ^ self error: 'This PhuckVM is not running' ].
	^ self parametersSpace
		show;
		yourself
]

{ #category : '*CoypuIDE' }
PhuckVM >> parametersElement [
	^ CoypuParametersElement on: self globals keys
]

{ #category : '*CoypuIDE' }
PhuckVM >> parametersSpace [
	^ BlSpace new
		title: 'PhuckVM Parameters';
		in: [ :space | space root addChild: self parametersElement ];
		yourself
]
