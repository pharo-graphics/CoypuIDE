factory
verticalSegment

	| elt paint |

	paint := BlLinearGradientPaint horizontal
		         from: Color lightGreen
		         to: Color lightGreen muchDarker.

	elt := self new beVertical frontPaint: paint.


	^ elt