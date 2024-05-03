Class {
	#name : #MfMixingTableExamples,
	#superclass : #Object,
	#category : #MooflodMixingTableWidget
}

{ #category : #'as yet unclassified' }
MfMixingTableExamples class >> exampleSimpleMixingTable [

	<script>
	| t |
	t := MfMixingTableElement new
		     nbButtons: 10;
		     nbButtonPerRow: 5.
	t redefineKeys: #( A S D F G H J K L ).
	t keymap.
	t openMixingTable: t
]
