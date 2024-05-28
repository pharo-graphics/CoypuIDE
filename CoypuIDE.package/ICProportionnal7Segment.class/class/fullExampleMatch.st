as yet unclassified
fullExampleMatch

	<script>
	| container |
	container := BlElement new
		             layout: BlLinearLayout horizontal;
		             constraintsDo: [ :c |
			             c vertical matchParent.
			             c horizontal matchParent ].

	container addChild: (self new constraintsDo: [:c | c horizontal matchParent. c vertical matchParent]).
	0 to: 10 do: [ :i | 
		|child|
		child := self new digit: i; constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ].
		container addChild: child ].

	container openInSpace