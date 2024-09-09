Class {
	#name : #BaselineOfLcsGtClient,
	#superclass : #BaselineOf,
	#category : #BaselineOfLcsGtClient
}

{ #category : #baseline }
BaselineOfLcsGtClient >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'LcsGtClient'
		]
]
