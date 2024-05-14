as yet unclassified
exampleDefaultPiano

	<script>
	| p |
	p := MfPianoElement new
		     nOctaves: 2;
		     startNote: 'C'.
	p openPiano: p