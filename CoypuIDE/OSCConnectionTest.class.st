Class {
	#name : 'OSCConnectionTest',
	#superclass : 'TestCase',
	#category : 'CoypuIDE-tests',
	#package : 'CoypuIDE',
	#tag : 'tests'
}

{ #category : 'tests' }
OSCConnectionTest >> testConnectBlEmenentToOSCServer [

	| container knob button server localAddress |
	localAddress := '127.0.0.1'.
	knob := ICDarkKnob2 new
		        inputText: 'ModIndex';
		        setValue: 99.
	button := ICLabelButton new
		          inputText: 'Pitch';
		          setValue: 0.
	container := BlElement new.
	container
		addChild: knob;
		addChild: button.

	server := container connectToOSCServer.
	server listenOnPort: 8000.

	(OSCMessage for: { '/osc/ModIndex'. 11.0 asFloat})
		sendToAddressString: localAddress
		port: 8000.
   (Delay forSeconds: 1) wait.
	self assert: knob currentValue equals: 11.0.
	self assert: button currentValue equals: 1.0
]
