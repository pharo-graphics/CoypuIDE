accessing
currentValue: aNumber

	currentValue := aNumber.
	self callBack ifNotNil: [ :c | c value: currentValue  ]