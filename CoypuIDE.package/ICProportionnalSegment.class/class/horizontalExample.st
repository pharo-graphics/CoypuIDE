factory
horizontalExample

	<script>
	| elt |
	elt := self horizontalSegment size: 80@20.
	
	elt position: 50 asPoint.
	elt
		addEventHandlerOn: BlClickEvent
		do: [ :e | elt lit: elt isLit not ].
		
	elt openInSpace