Trait {
	#name : 'LtSlotFilter',
	#instVars : [
		'filterItemsModel'
	],
	#category : 'LcsGtClient-Traits',
	#package : 'LcsGtClient',
	#tag : 'Traits'
}

{ #category : 'filters' }
LtSlotFilter >> _superclassesFilter: baseClass [
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :anUpToClass | self classesForm: baseClass to: anUpToClass ]
				ifNone: [ baseClass asOrderedCollection ] ];
		items: [ self classesForm: baseClass to: LcsBaseDomainObject ];
		displayAllItems;
		name: self superclassesFilterName;
		order: 16
]

{ #category : 'filters' }
LtSlotFilter >> classesForm: baseClass to: anUpToClass [ 
	^ (ReadStream on: baseClass withAllSuperclasses) upTo: anUpToClass superclass
]

{ #category : 'filters' }
LtSlotFilter >> domainClassFilter [
	^ self filterItemLabelled: self domainClassFilterName
]

{ #category : 'filters' }
LtSlotFilter >> domainClassFilterItemLabel [
	^ self domainClassFilter selectedValue
]

{ #category : 'filters' }
LtSlotFilter >> domainClassFilterName [
	^ 'Class'
]

{ #category : 'filters' }
LtSlotFilter >> domainClassFilterValue [
	^ self valueOfFilterNamed: self domainClassFilterName
]

{ #category : 'filtering' }
LtSlotFilter >> filter: filteredItems byKind: aValue [
	aValue isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | each slotKind = aValue ]
]

{ #category : 'filtering' }
LtSlotFilter >> filter: filteredItems bySelectedDomainClass: aClassName [
	aClassName isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | each domainClass name = aClassName ]
]

{ #category : 'filtering' }
LtSlotFilter >> filter: filteredItems bySelectedSlotClass: aValue [
	aValue isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | each slotClass name asString = aValue ]
]

{ #category : 'filtering' }
LtSlotFilter >> filter: filteredItems bySelectedSuperclasses: aCollectionOfClasses [
	aCollectionOfClasses isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | (aCollectionOfClasses includes: each domainClass) ]
]

{ #category : 'as yet unclassified' }
LtSlotFilter >> filterItemLabelled: aString [
	^ self filterItemsModel items
		detect: [ :each | each label = aString ]
		ifNone: [ nil ]
]

{ #category : 'accessing' }
LtSlotFilter >> filterItemsModel [
	^ filterItemsModel
]

{ #category : 'accessing' }
LtSlotFilter >> filterItemsModel: anObject [
	filterItemsModel := anObject
]

{ #category : 'filtering' }
LtSlotFilter >> filteredItems [
	| filteredItems unfilteredItems |
	unfilteredItems := [ self unfilteredItems ]
			on: LcsSlotModelNotInitializedError
			do: [ :s | s return: OrderedCollection new ].
	filteredItems := self
			filter: unfilteredItems
			bySelectedSuperclasses: self superclassesFilterValue.
	filteredItems := self
			filter: filteredItems
			byKind: (self valueOfFilterNamed: self slotKindFilterName).
	filteredItems := self
			filter: filteredItems
			bySelectedSlotClass: self slotClassFilterValue.
	filteredItems := self
			filter: filteredItems
			bySelectedDomainClass: self domainClassFilterValue.
	^ filteredItems
]

{ #category : 'api - converting' }
LtSlotFilter >> itemsProviderOnExceptionErrorElement: aBlock [
	^ self
		performBlock: [ self filteredItems asBrItemsProvider ]
		onExceptionErrorElement: [ :anElement | 
			aBlock value: anElement ]
]

{ #category : 'filters' }
LtSlotFilter >> newDomainClassFilter [
	^ GtFilterTextModel new
		creator: [ :value | value ];
		named: self domainClassFilterName;
		order: 15;
		completion: [ GtStringsCompletionStrategy new
				completions: [ LcsDomainObject classNamesPrefixTree ] ]
]

{ #category : 'filters' }
LtSlotFilter >> newSlotClassFilter [
	^ GtFilterTextModel new
		creator: [ :value | value ];
		named: self slotClassFilterName;
		order: 14;
		completion: [ GtStringsCompletionStrategy new
				completions: [ LcsBaseSlot classNamesPrefixTree ] ]
]

{ #category : 'filters' }
LtSlotFilter >> newSlotKindFilter [
	^ GtFilterShortListModel new
		name: self slotKindFilterName;
		creator: [ :selectedValue | selectedValue itemValue = 'all' ifTrue: [nil] ifFalse: [selectedValue itemValue ] ];
		items: {'all'.
				'accessor'.
				'collectionItem'.
				'facade'.
				'virtual'};
		selectedItem: 'all';
		order: 13;
		yourself
]

{ #category : 'filters' }
LtSlotFilter >> newSuperclassesFilter [
	<return: #GtFilterShortListModel>
	| baseClass |
	baseClass := self baseClass.
	^ self _superclassesFilter: baseClass
]

{ #category : 'filters' }
LtSlotFilter >> slotClassFilter [
	^ self filterItemLabelled: self slotClassFilterName
]

{ #category : 'filters' }
LtSlotFilter >> slotClassFilterItemLabel [
	^ self slotClassFilter selectedValue
]

{ #category : 'filters' }
LtSlotFilter >> slotClassFilterName [
	^ 'Slot Class'
]

{ #category : 'filters' }
LtSlotFilter >> slotClassFilterValue [
	^ self valueOfFilterNamed: self slotClassFilterName
]

{ #category : 'filters' }
LtSlotFilter >> slotKindFilter [
	^ self filterItemLabelled: self slotKindFilterName
]

{ #category : 'filters' }
LtSlotFilter >> slotKindFilterItemLabel [
	^ self slotKindFilter selectedItem itemValue
]

{ #category : 'filters' }
LtSlotFilter >> slotKindFilterName [
	^ 'Kind'
]

{ #category : 'filters' }
LtSlotFilter >> slotKindFilterValue [
	^ self valueOfFilterNamed: self slotKindFilterName
]

{ #category : 'filters' }
LtSlotFilter >> superclassesFilter [
	^ self filterItemLabelled: self superclassesFilterName
]

{ #category : 'filters' }
LtSlotFilter >> superclassesFilterItemLabel [
	^ self superclassesFilter selectedItem itemValue
]

{ #category : 'filters' }
LtSlotFilter >> superclassesFilterName [
	^ 'Slots up to'
]

{ #category : 'filters' }
LtSlotFilter >> superclassesFilterValue [
	^ self valueOfFilterNamed: self superclassesFilterName
]

{ #category : 'filtering' }
LtSlotFilter >> unfilteredItems [
	^ itemsProviderComputation value
]

{ #category : 'filtering' }
LtSlotFilter >> valueOfFilterNamed: aString [
	^ ((self filterItemLabelled: aString) ifNil: [ ^nil ]) asSearchFilter
]
