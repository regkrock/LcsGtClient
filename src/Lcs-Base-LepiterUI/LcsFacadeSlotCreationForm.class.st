Class {
	#name : #LcsFacadeSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsFacadeSlotCreationForm class >> componentName [
	^ 'Facade'
]

{ #category : #'as yet unclassified' }
LcsFacadeSlotCreationForm class >> priority [
	^ 20
]

{ #category : #accessing }
LcsFacadeSlotCreationForm class >> slotDefintionTypeClass [
	^ LcsFacadeSlot
]

{ #category : #callbacks }
LcsFacadeSlotCreationForm >> commit [
	self halt: 'Need to create slot definition, etc'
]
