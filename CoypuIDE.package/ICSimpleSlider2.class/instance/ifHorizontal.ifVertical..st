as yet unclassified
ifHorizontal: horizontalBlock ifVertical: verticalBlock

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock