as yet unclassified
basicCurrentValue: aNumber

	currentValue := aNumber.
	self callBack ifNotNil: [ :e | e value: currentValue ]