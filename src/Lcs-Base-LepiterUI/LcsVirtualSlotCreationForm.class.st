Class {
	#name : #LcsVirtualSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsVirtualSlotCreationForm class >> componentName [
	^ 'Virtual'
]

{ #category : #accessing }
LcsVirtualSlotCreationForm class >> defaultSlotDefintionClass [
	^ LcsVirtualSlotDefinition
]

{ #category : #'as yet unclassified' }
LcsVirtualSlotCreationForm class >> priority [
	^ 30
]

{ #category : #callbacks }
LcsVirtualSlotCreationForm >> commit [
	self halt: 'Need to create slot definition, etc'
]
