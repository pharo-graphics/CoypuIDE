Class {
	#name : 'BaselineOfCoypuIDE',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCoypuIDE',
	#package : 'BaselineOfCoypuIDE'
}

{ #category : 'baselines' }
BaselineOfCoypuIDE >> baseline: spec [

    <baseline>
    spec for: #common do: [
        "Declaring application packages"
        spec package: 'CoypuIDE'.
        spec package: 'ICIcons'.

         "External Dependencies"
        spec
            baseline: 'Toplo'
            with: [ spec repository: 'github://pharo-graphics/Toplo:dev/src' ].
        spec
            baseline: 'Phausto'
            with: [ spec repository: 'github://lucretiomsp/phausto:main/' ].
        spec
            baseline: 'Coypu'
            with: [ spec repository: 'github://lucretiomsp/coypu:master/' ].
        spec
            baseline: 'Mooflod'
            with: [ spec repository: 'github://lucretiomsp/MoofLODforPharo:master/' ].

        "Linkink external dependencies"
        spec
            package: 'CoypuIDE' with: [ spec requires: #( 'Toplo' 'Mooflod' 'Phausto' ) ];
            package: 'ICIcons' with: [ spec requires: #( 'Toplo' ) ].

        "Baseline groups"
        spec
            group: 'core' with: #( 'CoypuIDE' 'ICIcons' );
            group: 'default' with: #( 'core' ) ]
]
