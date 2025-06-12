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
	| builder |
	builder := self slotTypeBuilderClass new.
	builder
		slotName: self slotName;
		targetClass: self targetClass;
		targetClassName: self targetClass name;
		buildJobSteps.
	builder execute
]

{ #category : #callback }
LcsAccessorSlotCreationForm >> slotTypeBuilderClass [
	^ LcsSlotDefinitionBuilder withAllSubclasses
		detect: [ :each | each slotDefinitionClass = self slotType ]
		ifNone: [ LcsSlotDefinitionBuilder ]
]
