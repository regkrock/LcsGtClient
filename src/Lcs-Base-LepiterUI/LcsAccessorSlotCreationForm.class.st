Class {
	#name : #LcsAccessorSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsAccessorSlotCreationForm class >> componentName [
	^ 'Accessing Slot'
]

{ #category : #accessing }
LcsAccessorSlotCreationForm class >> priority [
	^ 10
]

{ #category : #accessing }
LcsAccessorSlotCreationForm class >> slotDefintionTypeClass [
	^ LcsSlotDefinition
]

{ #category : #callback }
LcsAccessorSlotCreationForm >> commit [
	( LcsStringSlotDefinitionBuilder new
		slotName: self slotName;
		target: self targetClass;
		targetClassName: self targetClass name ) installCode
]
