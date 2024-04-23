api - bounds
defaultHandle

	| size elt offset |
	size := self isHorizontal ifTrue: [ 5 @ barThickness  ] ifFalse: [ barThickness @ 5 ].
	elt := BlElement new
		       background: self handleDefaultColor;
		       size: size;
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