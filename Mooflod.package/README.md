# Skin and Theme Explanation

Skins are a good way to customize widgets created with Bloc, here I will explain how to implement skins/theme basically for your widgets.

## Installation

First of all, you need to install the versions of Toplo and Bloc, here is how to :

- https://github.com/pharo-graphics/Toplo
- https://github.com/pharo-graphics/Bloc

## Implement Skins

Now that you have loaded the packages, here's the things you need to do :

- Firstly, if your widget is a BlElement, you must change it to a ToElement (subclasses BlElement).
- You'll need to implement/override the methods newRawSkin and installRawStyle, for example newRawSkin will return an instance of the skin of your widget. ( It can be newBeeSkin and installBeeStyle ).
- By subclassing ToRawSkin, now you have to create the skin of your widget, that will implement methods related to events.
The common one is installLookEvent that will apply the changes you give to your skin when you'll install it.
For example you can use pressedLookEvent that will apply the changes you want when you click on the widget.

## Token properties explanation
 A token property is a key/value pair. Those pairs are all defined in the defaultTokenProperties method of ToTheme class.
So if you want to customize the graphical properties, you can call those Token properties to use them for widget.
And if you want to change the values of those properties to make your skin more customizable, you'll need to define the appareance of your theme..

## Implement Theme

To create your own theme with your own values, you'll have to subclass ToRawTheme ( or ToBeeTheme ) and implement its class-sided method defaultTokenProperties to define the values of your properties.
For example : 
``` 
defaultTokenProperties 
^ super defaultTokenProperties , 
{   (ToTokenProperty    name: #'background-color'    value: (Color lightGreen)). }
```
This will set the token property "background-color" to value "lightGreen"

## Little example

In this case : Imagine you've not defined the border and the background of your widget, well you can configurate it in the installLookEvent: 

```
installLookEvent: anEvent
	"when installing the skin, changes the properties of widget mentionned down here"

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')).
		e background: e backgroundPaint ]
```
Those tokens can be defined in your theme as I explained right before.

## Last things to do

Now that you have your own skin/theme, you need to link them to your widget.
So in a class of your ToElement, you have to set the defaultSkin attribute to a new instance of your skin.
And for your theme, you need to link it to the space you're using like this : ```	space toTheme: (name of your theme) new.```
