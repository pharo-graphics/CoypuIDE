as yet unclassified
exampleSimplePattern

	<script>
	| patternelem |
	patternelem := MfPatternElement new
		               min: 4;
		               max: 16;
		               nbsteps: 12.
	patternelem openPattern: patternelem