Class {
	#name : 'LcsApplicationEnvironmentUI',
	#superclass : 'LcsObject',
	#instVars : [
		'applicationEnvironemnt'
	],
	#category : 'LcsGtClient-Core',
	#package : 'LcsGtClient',
	#tag : 'Core'
}

{ #category : 'accessing' }
LcsApplicationEnvironmentUI >> applicationEnvironemnt [
	^ applicationEnvironemnt
]

{ #category : 'accessing' }
LcsApplicationEnvironmentUI >> applicationEnvironemnt: anObject [
	applicationEnvironemnt := anObject
]

{ #category : 'gt views' }
LcsApplicationEnvironmentUI >> gtApplicationEnvironmentViewFor: aView [
	<gtView>
		^ aView forward
			title: 'Application Environment';
			priority: 10;
			object: [ self applicationEnvironemnt ];
			view: #gtApplicationEnvironmentFor:
		
]

{ #category : 'initialize' }
LcsApplicationEnvironmentUI >> initialize [
	super initialize.
	self applicationEnvironemnt: LcsApplicationEnvironment
]

{ #category : 'as yet unclassified' }
LcsApplicationEnvironmentUI >> ui [
	<gtExample>
	^ self
]
