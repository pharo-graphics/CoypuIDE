instance creation
newButton: anExtent
	"creates an instance of button and give its graphical properties"

	^ BlElement new
		  size: anExtent;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  border: (BlBorder paint: (Color gray alpha: 0.2) width: 1);
		  layout: BlFrameLayout new;
		  effect: (BlGaussianShadowEffect
				   color: (Color black alpha: 0.1)
				   width: 2
				   offset: 0 @ 1);
		  margin: (BlInsets all: self spacing);
		  background: Color black