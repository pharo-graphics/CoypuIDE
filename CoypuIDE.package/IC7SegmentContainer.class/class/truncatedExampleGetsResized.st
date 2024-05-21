as yet unclassified
truncatedExampleGetsResized

	<script>
	| elt |
	elt := self new
		       value: 12345678;
		       openInSpace;
		       yourself.

	1 seconds wait.
	elt nbDigits: 8