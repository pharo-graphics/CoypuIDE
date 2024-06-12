api - bounds
defaultHandle

	| size elt offset |
	size := self
		        ifHorizontal: [ 5 @ barThickness ]
		        ifVertical: [ barThickness @ 5 ].
	
	elt := BlElement new
		       background: self handleDefaultColor;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		       size: size;
				"effect: (BlGaussianShadowEffect color: (Color green alpha: 0.7) offset:2@2 width: 10);"
				 transformDo: [ :t | "so the position is now the center"
			       t translateBy: size negated / 2 ];
		       yourself.

	elt addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		offset := event position - elt position ].

	elt
		addEventHandlerOn: BlDragEvent
		do: [ :event | self moveHandleTo: event position - offset ].

	^ elt