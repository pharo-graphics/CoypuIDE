Class {
	#name : 'ICFaustUINode',
	#superclass : 'Object',
	#instVars : [
		'dictionary',
		'meta'
	],
	#category : 'CoypuIDE-FaustUI',
	#package : 'CoypuIDE',
	#tag : 'FaustUI'
}

{ #category : 'instance creation' }
ICFaustUINode class >> on: aDictionary [
	"a node of the Faust JSON ui tree (a group or a widget) with its annotations"

	^ self new
		  dictionary: aDictionary;
		  yourself
]

{ #category : 'accessing' }
ICFaustUINode >> address [

	^ dictionary at: #address ifAbsent: [ nil ]
]

{ #category : 'accessing' }
ICFaustUINode >> choices [
	"the name -> value pairs of a [style:menu{'sine':0;'saw':1}] or [style:radio{...}], in their order"

	| s body |
	s := self style ifNil: [ ^ #(  ) ].
	(s includes: ${) ifFalse: [ ^ #(  ) ].
	body := (s copyAfter: ${) copyUpTo: $}.
	^ ((body splitOn: $;) reject: [ :each | each trimBoth isEmpty ]) collect: [ :each |
			  | name value |
			  name := (each copyUpToLast: $:) trimBoth.
			  name := name trimBoth: [ :c | c = $' or: [ c = $" or: [ c isSeparator ] ] ].
			  value := (each copyAfterLast: $:) trimBoth asNumber.
			  name -> value ]
]

{ #category : 'accessing' }
ICFaustUINode >> dictionary [
	"the node of the Faust JSON ui tree, as parsed by STONJSON"

	^ dictionary
]

{ #category : 'accessing' }
ICFaustUINode >> dictionary: aDictionary [

	dictionary := aDictionary.
	meta := nil
]

{ #category : 'accessing' }
ICFaustUINode >> init [

	^ dictionary at: #init ifAbsent: [ self min ]
]

{ #category : 'accessing' }
ICFaustUINode >> isBargraph [

	^ self type endsWith: 'bargraph'
]

{ #category : 'accessing' }
ICFaustUINode >> isContinuous [
	"a slider or a number entry: what menu, radio, knob, slider and numerical styles apply to"

	^ #( 'hslider' 'vslider' 'nentry' ) includes: self type
]

{ #category : 'accessing' }
ICFaustUINode >> isGroup [

	^ self type endsWith: 'group'
]

{ #category : 'accessing' }
ICFaustUINode >> isHidden [
	"[hidden:1]: Faust UIs do not show it"

	^ (self metaAt: 'hidden') = '1'
]

{ #category : 'accessing' }
ICFaustUINode >> isSoundfile [

	^ self type = 'soundfile'
]

{ #category : 'accessing' }
ICFaustUINode >> items [
	"the children of a group, as nodes, in Faust's order (Faust already sorts by the [0] [1] ... annotations)"

	^ (dictionary at: #items ifAbsent: [ #(  ) ]) collect: [ :each | self class on: each ]
]

{ #category : 'accessing' }
ICFaustUINode >> label [

	^ dictionary at: #label ifAbsent: [ '' ]
]

{ #category : 'accessing' }
ICFaustUINode >> max [

	^ dictionary at: #max ifAbsent: [ 1 ]
]

{ #category : 'accessing' }
ICFaustUINode >> meta [
	"the annotations, as a Dictionary: Faust writes them as an Array of one-pair dictionaries, e.g. [ {style: knob}, {unit: Hz}, {0: ''} ]"

	^ meta ifNil: [
			  meta := Dictionary new.
			  (dictionary at: #meta ifAbsent: [ #(  ) ]) do: [ :pair |
				  pair keysAndValuesDo: [ :k :v | meta at: k asString put: v asString ] ].
			  meta ]
]

{ #category : 'accessing' }
ICFaustUINode >> metaAt: aString [
	"the value of the [aString:...] annotation, nil when absent"

	^ self meta at: aString ifAbsent: [ nil ]
]

{ #category : 'accessing' }
ICFaustUINode >> min [

	^ dictionary at: #min ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
ICFaustUINode >> printOn: aStream [

	aStream << self type << ' ' << self label
]

{ #category : 'accessing' }
ICFaustUINode >> scale [
	"#log, #exp or #linear, from [scale:log] / [scale:exp]"

	| s |
	s := self metaAt: 'scale'.
	s = 'log' ifTrue: [ ^ #log ].
	s = 'exp' ifTrue: [ ^ #exp ].
	^ #linear
]

{ #category : 'accessing' }
ICFaustUINode >> step [

	^ dictionary at: #step ifAbsent: [ 1 ]
]

{ #category : 'accessing' }
ICFaustUINode >> style [
	"the whole [style:...] annotation, e.g. 'knob' or 'menu{''sine'':0;''saw'':1}', nil when absent"

	^ self metaAt: 'style'
]

{ #category : 'accessing' }
ICFaustUINode >> styleKind [
	"the style without its choices: #knob #slider #menu #radio #led #numerical, nil when absent"

	^ self style ifNotNil: [ :s | (s copyUpTo: ${) trimBoth asSymbol ]
]

{ #category : 'accessing' }
ICFaustUINode >> tooltip [

	^ self metaAt: 'tooltip'
]

{ #category : 'accessing' }
ICFaustUINode >> type [
	"'vgroup' 'hgroup' 'tgroup' 'hslider' 'vslider' 'nentry' 'button' 'checkbox' 'hbargraph' 'vbargraph' 'soundfile'"

	^ dictionary at: #type
]

{ #category : 'accessing' }
ICFaustUINode >> unit [

	^ self metaAt: 'unit'
]
