Class {
	#name : #LcsVirtualSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsVirtualSlotCreationForm class >> componentName [
	^ 'Virtual'
]

{ #category : #'as yet unclassified' }
LcsVirtualSlotCreationForm class >> priority [
	^ 30
]

{ #category : #accessing }
LcsVirtualSlotCreationForm class >> slotDefintionTypeClass [
	^ LcsVirtualSlotDefinition
]

{ #category : #callbacks }
LcsVirtualSlotCreationForm >> commit [
	self halt: 'Need to create slot definition, etc'
]
