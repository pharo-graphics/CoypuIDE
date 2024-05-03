initialization
initializeInputText
	"get the input text"
| inputtext |

inputtext := MfInputTextElement new.
self addChild: inputtext.

^inputtext 