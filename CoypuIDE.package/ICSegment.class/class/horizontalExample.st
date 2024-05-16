factory
horizontalExample

	<script>
	| elt |
	elt := self new.
	elt position: 50 asPoint.

	elt addEventHandlerOn: BlClickEvent do: [ :e | elt lit: elt isLit not ].
	elt openInSpace