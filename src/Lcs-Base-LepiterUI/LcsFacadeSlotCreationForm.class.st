Class {
	#name : #LcsFacadeSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsFacadeSlotCreationForm class >> componentName [
	^ 'Facade'
]

{ #category : #accessing }
LcsFacadeSlotCreationForm class >> defaultSlotDefintionClass [
	^ LcsFacadeSlot
]

{ #category : #'as yet unclassified' }
LcsFacadeSlotCreationForm class >> priority [
	^ 20
]

{ #category : #callbacks }
LcsFacadeSlotCreationForm >> commit [
	self halt: 'Need to create slot definition, etc'
]
