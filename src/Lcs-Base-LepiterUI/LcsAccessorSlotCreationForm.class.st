Class {
	#name : #LcsAccessorSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> defaultSlotDefintionClass [
	^ LcsSlotDefinition
]

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> priority [
	^ 10
]

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> slotComponentName [
	^ 'Accessor'
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> allowNilDescription [
	<magritteDescription>
	^ (self slotModelBuilder respondsTo: #allowNilDescription)
		ifTrue: [ self slotModelBuilder allowNilDescription ]
		ifFalse: [ nil ]
]

{ #category : #callback }
LcsAccessorSlotCreationForm >> commit [
	self slotModelBuilder commit
]

{ #category : #'gt views' }
LcsAccessorSlotCreationForm >> gtConstructionTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps Tree';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtConstructionTreeFor:
]

{ #category : #'gt views' }
LcsAccessorSlotCreationForm >> gtMagritteFor: aView [
	^ (super gtMagritteFor: aView)
		actionUpdateButton;
		yourself
]

{ #category : #'gt views' }
LcsAccessorSlotCreationForm >> gtRefactoringChangeOn: aView [
	<gtView>
	^ aView forward
		title: 'Refactoring';
		priority: 99.2;
		object: [  self slotModelBuilder ];
		view: #gtRefactoringChangeOn: 
]

{ #category : #'gt views' }
LcsAccessorSlotCreationForm >> gtSlotBuilderFor: aView [
	<gtView>
	^ aView forward
		title: 'Slot Builder';
		priority: 98;
		object: [  self slotModelBuilder ];
		view: #gtRawFor:
]

{ #category : #'gt views' }
LcsAccessorSlotCreationForm >> gtUMLFor: aView [
	<gtView>
	[ self slotModelBuilder ] value isNil ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'UML';
		priority: 99;
		object: [  self slotModelBuilder ];
		view: #gtUMLFor:
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> initialValueBlockDescription [
	<magritteDescription>
	self traceCr: 'LcsAccessorSlotCreationForm>>#initialValueBlockDescription slotModelBuilder: ' , self slotModelBuilder printString.
	^ (self slotModelBuilder respondsTo: #initialValueBlockDescription)
		ifTrue: [ self slotModelBuilder initialValueBlockDescription ]
		ifFalse: [ nil ]
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> requiredDescription [
	<magritteDescription>
	^ (self slotModelBuilder respondsTo: #requiredDescription)
		ifTrue: [ self slotModelBuilder requiredDescription ]
		ifFalse: [ nil ]
]

{ #category : #callback }
LcsAccessorSlotCreationForm >> slotDefinitionClassChangedTo: aClassName [
	self slotDefinitionClass: aClassName.
	self slotModelBuilder: (
		(self slotDefinitionBuilderClass new)
			targetClass: self targetClass;
			targetClassName: self targetClass name asString;
			populateFrom: self slotDefinitionClass;
			yourself)
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> slotNameDescription [
	<magritteDescription>
	^ (self slotModelBuilder respondsTo: #slotName)
		ifTrue: [ self slotModelBuilder slotNameDescription ]
		ifFalse: [ nil ]
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> slotTypesDescription [
	<magritteDescription>
	^ (self slotModelBuilder respondsTo: #slotTypesDescription)
		ifTrue: [ self slotModelBuilder slotTypesDescription ]
		ifFalse: [ nil ]
]
