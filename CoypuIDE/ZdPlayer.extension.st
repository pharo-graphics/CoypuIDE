Extension { #name : 'ZdPlayer' }

{ #category : '*CoypuIDE' }
ZdPlayer >> uiRanges [
	"index goes through the files of my folder"

	^ super uiRanges
		  at: 'Index' put: {
				  0.
				  (self audioFiles size - 1 max: 0).
				  1 };
		  yourself
]
