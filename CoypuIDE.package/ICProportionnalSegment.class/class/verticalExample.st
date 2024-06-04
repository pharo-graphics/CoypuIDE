factory
verticalExample

	<script>
	| elt |
	elt := self verticalSegment size: 20 @ 80.

	elt position: 50 asPoint.

	elt
		addEventHandlerOn: BlClickEvent
		do: [ :e | elt lit: elt isLit not ].

	elt openInSpace