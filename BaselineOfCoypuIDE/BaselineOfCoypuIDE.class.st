Class {
	#name : #BaselineOfCoypuIDE,
	#superclass : #BaselineOf,
	#category : #BaselineOfCoypuIDE
}

{ #category : #baselines }
BaselineOfCoypuIDE >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Toplo'
			with: [
			spec repository: 'github://pharo-graphics/Toplo:master/src' ].
		spec
			baseline: 'Phausto'
			with: [ spec repository: 'github://lucretiomsp/Phausto:main/' ].

		spec
			package: 'CoypuIDE' with: [ spec requires: 'Toplo' ];
			package: 'Mooflod' with: [ spec requires: 'Toplo' ];
			package: 'ICIcons' with: [ spec requires: 'Toplo' ].
		spec
			group: 'core' with: #( 'CoypuIDE' 'Mooflod' 'ICIcons' 'Phausto' );
			group: 'default' with: #( 'core' ) ]
]
