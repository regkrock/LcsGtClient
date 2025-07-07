Class {
	#name : #LcsAccessorSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> defaultSlotClass [
	^ LcsAccessorSlot
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
	^ self magritteDescriptionFor: #allowNil
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> collectionSlotName [
	<magritteDescription>
	^ self magritteDescriptionFor: #collectionSlotName
]

{ #category : #callbacks }
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
	^ self magritteDescriptionFor: #initialValueBlock
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> magritteDescriptionFor: aSlotNameSymbol [
	^ (self slotModelBuilder respondsTo: aSlotNameSymbol)
		ifTrue: [ self slotModelBuilder perform: ( aSlotNameSymbol , 'Description') asSymbol]
		ifFalse: [ nil ]
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> numberOfDecimalsDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #numberOfDecimals
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #prevalidationTransformBlock
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> requiredDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #required
]

{ #category : #callbacks }
LcsAccessorSlotCreationForm >> slotClassChangedTo: aClassName [
	self slotClassName: aClassName.
	self slotModelBuilder: (
		(self slotBuilderClass new)
			targetClass: self targetClass;
			targetClassName: self targetClass name asString;
			populateFrom: self slotClassName;
			buildJobSteps;
			yourself)
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> slotNameDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #slotName
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> slotTypesDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #slotTypes
]
