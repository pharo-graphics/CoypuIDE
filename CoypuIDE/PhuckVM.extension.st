Extension { #name : 'PhuckVM' }

{ #category : '*CoypuIDE' }
PhuckVM >> allParameters [ 

"Names of the int, float and string globals declared in code compiled with compile: or run:"

	^ globals keys
]

{ #category : '*CoypuIDE' }
PhuckVM >> displayParameters [ 
	"Open a space listing all the globals known to this VM"

	self ensureRunning.
	^ self parametersSpace
		  show;
		  yourself
]

{ #category : '*CoypuIDE' }
PhuckVM >> parametersElement [


	^ CoypuParametersElement on: self allParameters
]

{ #category : '*CoypuIDE' }
PhuckVM >> parametersSpace [ 
^ BlSpace new
		  title: 'PhuckVM Parameters';
		  in: [ :space | space root addChild: self parametersElement ];
		  yourself
]
