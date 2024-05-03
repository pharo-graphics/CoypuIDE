tests
testAllKeysAreInDicts

| keyB |		
	"At creation, keyboard must have all keys as BlElement childrens, here 64 keys are registered"
keyB:= MfKeyboardElement new.
self assert: keyB children size equals: 64.
