private
proportionOf: aValue
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)