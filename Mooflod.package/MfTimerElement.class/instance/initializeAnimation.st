initialization
initializeAnimation

	anim := BlAnimation new
		        duration: 1 seconds;
		        loops: value.
	self addEventHandlerOn: BlMouseDownEvent do: [ :a |
		anim addEventHandler: (BlEventHandler
				 on: BlAnimationLoopDoneEvent
				 do: [ :e |
					 value traceCr.
					 currentAngle := currentAngle - decreasingAngleStep.
					 self updateAnnulusAngle: currentAngle.
					 self updateValue.
					 self background: Color random ]) ].

	self addAnimation: anim