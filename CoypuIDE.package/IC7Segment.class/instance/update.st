updating
update 

	self segments with: (Digits at: digit + 1) do: [ :seg :bool |
		seg lit: bool. ]