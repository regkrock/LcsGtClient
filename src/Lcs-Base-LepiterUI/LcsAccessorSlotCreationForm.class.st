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
LcsAccessorSlotCreationForm class >> defaultSlotDefintionClass [
	^ LcsSlotDefinition
]

{ #category : #accessing }
LcsAccessorSlotCreationForm class >> priority [
	^ 10
]

{ #category : #callback }
LcsAccessorSlotCreationForm >> commit [
	| builder |
	builder := self slotDefinitionBuilder.
	builder
		slotName: self slotName;
		targetClass: self targetClass;
		targetClassName: self targetClass name;
		buildJobSteps.
	builder execute
]

{ #category : #callback }
LcsAccessorSlotCreationForm >> slotDefinitionBuilder [
	LcsSlotDefinitionBuilder withAllSubclasses do: [ :each |
		each slotDefinitionClass = self slotDefinitionClass 
			ifTrue: [ each slotDefinitionClass new ]].
	^ LcsSlotDefinitionBuilder new
		slotDefinitionClassName: self slotDefinitionClass  asString;
		yourself
]
