initialization
initializeAnimation

	| started |
	anim := BlAnimation new
		        duration: 1 seconds;
		        loops: value.
	started := false.
	
	self addEventHandlerOn: BlMouseDownEvent do: [ :a |
		started ifFalse: [ 
			started := true.
		anim addEventHandler: (BlEventHandler
				 on: BlAnimationLoopDoneEvent
				 do: [ :e |
					 currentAngle := currentAngle - decreasingAngleStep.
					 self updateAnnulusAngle: currentAngle.
					 self updateValue.
					 self background: Color random ]) ]] .

	self addAnimation: anim