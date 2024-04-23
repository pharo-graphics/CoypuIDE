private
colorForValue: aValue

	| i |
	self enumeratedColors
		ifNil: [
			^  endColor
				  mixed: (self proportionOf: aValue)
				  with: self initColor ]
		ifNotNil: [ :list |
			i := self enumeratedValues indexOf: aValue.
			i = 0 ifTrue: [ ^ self initColor ].
			(i > list size) ifTrue: [ ^  endColor ].
			^list at: i ]