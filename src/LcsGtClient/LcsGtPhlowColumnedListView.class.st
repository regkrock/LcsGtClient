Class {
	#name : #LcsGtPhlowColumnedListView,
	#superclass : #GtPhlowColumnedListView,
	#instVars : [
		'filterItemsModel'
	],
	#category : #'LcsGtClient-! Views'
}

{ #category : #filters }
LcsGtPhlowColumnedListView >> _superclassesFilter: baseClass [
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :anUpToClass | self classesForm: baseClass to: anUpToClass ]
				ifNone: [ baseClass asOrderedCollection ] ];
		items: [ self classesForm: baseClass to: LcsBaseDomainObject ];
		"selectedItem: baseClass;"
		displayAllItems;
		name: 'Slots up to';
		order: 16
]

{ #category : #'api - converting' }
LcsGtPhlowColumnedListView >> asElementDo: aBlock [
	"it evaluates aBlock if the view should have content"

	| aContainer aHeader anItemsProvider aBrList filtersItemsElement |
	
	aBrList := self columnedListClass new.
	
	self filterItemsModel: GtFilterItemsModel new.
	filtersItemsElement := self filterItemsModel asFiltersElement.
	self filterItemsModel
		when: GtFiltersModelUpdated
		do: [ 
			aBrList itemsProvider: (self itemsProviderOnExceptionErrorElement:[ :anElement |  ^ aBlock value: anElement ]).
			"aBrList invalidate" ]. 
	self filterItemsModel addFilterModel: self domainClassFilter.
	self filterItemsModel addFilterModel: self slotClassFilter.
	self filterItemsModel addFilterModel: self superclassesFilter.
	self filterItemsModel addFilterModel: self slotKindFilter.
	self assert: self filterItemsModel items size equals: 4.


	anItemsProvider := self itemsProviderOnExceptionErrorElement: [ :anElement | ^ aBlock value: anElement ].

	aBrList := self columnedListClass new.
	aContainer := self buildContainerWithList: aBrList itemsProvider: anItemsProvider.

	aHeader := self buildHeaderForItems: aBrList columns.
	
	aContainer addChildren: {filtersItemsElement. aHeader. aBrList}.

	"Trying to set this when creating the filter causes walkbacks. This is the place to do it."
	(self filterItemLabelled: 'Slots up to') selectedItem: self baseClass.
	
	horizontalScrollingEnabled
		ifTrue: [ | aScrollableElement |
			aContainer constraintsDo: [ :c | c horizontal fitContent ].
			aBrList hFitContent.
			aHeader constraintsDo: [ :c | c horizontal fitContent ].
			aScrollableElement := BrScrollPane new
					aptitude: BrScrollPaneAptitude + BrGlamorousWithHorizontalScrollbarAptitude;
					matchParent;
					content: aContainer;
					margin: (BlInsets bottom: 2).
			aContainer := aScrollableElement ].
			
	aContainer
		addAptitude: (BrLayoutResizerAptitude new
				hMatchParentToMatchParent: aHeader;
				hExactToMatchParent: aHeader;
				hFitContentToFitContent: aHeader;
				hFitContentLimitedToFitContentLimited: aHeader;
				vAnyToFitContent: aHeader;
				matchParentToMatchParent: aBrList;
				exactToMatchParent: aBrList;
				fitContentToFitContent: aBrList;
				fitContentLimitedToFitContentLimited: aBrList).
				
	self beViewElement: aContainer.
	^ aBlock value: aContainer
]

{ #category : #filters }
LcsGtPhlowColumnedListView >> baseClass [
	^ self buildContext object class = LcsSlotModel
		ifTrue: [ self buildContext object domainClass ]
		ifFalse: [ self buildContext object ]
]

{ #category : #'api - converting' }
LcsGtPhlowColumnedListView >> buildContainerWithList: aBrList itemsProvider: anItemsProvider [
	| aContainer |
	aContainer := self elementClass new.
	aContainer
		id: GtPhlowColumnedListContainerId;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	aContainer layout: BlLinearLayout vertical.
	self hasMultipleSelection
		ifTrue: [ aBrList aptitude: BrColumnedMultiListAptitude ].
	aBrList
		id: GtPhlowColumnedListId;
		itemsProvider: anItemsProvider;
		addEventHandler: (GtPhlowListToSelectHandler new transformation: self transformation);
		rowStencil: self newDecoratedItemStencil.
	rowDataBinder ifNotNil: [ aBrList rowDataBinder: rowDataBinder ].
	self buildColumnsInList: aBrList.
	^ aContainer
]

{ #category : #filters }
LcsGtPhlowColumnedListView >> classesForm: baseClass to: anUpToClass [ 
	^ (ReadStream on: baseClass withAllSuperclasses) upTo: anUpToClass superclass
]

{ #category : #filters }
LcsGtPhlowColumnedListView >> domainClassFilter [
	^ GtFilterTextModel new
		creator: [ :value | value ];
		named: 'Class';
		order: 15;
		completion: [ GtStringsCompletionStrategy new
				completions: [ LcsDomainObject classNamesPrefixTree ] ]
]

{ #category : #filtering }
LcsGtPhlowColumnedListView >> filter: filteredItems byKind: aValue [
	aValue isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | each slotKind = aValue ]
]

{ #category : #filtering }
LcsGtPhlowColumnedListView >> filter: filteredItems bySelectedDomainClass: aClassName [
	aClassName isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | each domainClass name = aClassName ]
]

{ #category : #filtering }
LcsGtPhlowColumnedListView >> filter: filteredItems bySelectedDomainClasses: aCollectionOfClasses [
	aCollectionOfClasses isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | (aCollectionOfClasses includes: each domainClass name) ]
]

{ #category : #filtering }
LcsGtPhlowColumnedListView >> filter: filteredItems bySelectedSlotClass: aValue [
	aValue isEmptyOrNil ifTrue: [ ^ filteredItems ].
	^ filteredItems select: [ :each | each class name = aValue ]
]

{ #category : #'as yet unclassified' }
LcsGtPhlowColumnedListView >> filterItemLabelled: aString [
	^ self filterItemsModel items
		detect: [ :each | each label = aString ]
		ifNone: [ nil ]
]

{ #category : #accessing }
LcsGtPhlowColumnedListView >> filterItemsModel [
	^ filterItemsModel
]

{ #category : #accessing }
LcsGtPhlowColumnedListView >> filterItemsModel: anObject [
	filterItemsModel := anObject
]

{ #category : #filtering }
LcsGtPhlowColumnedListView >> filteredItems [
	| filteredItems |
	filteredItems := itemsProviderComputation value.
	filteredItems := self filter: filteredItems byKind: (self valueOfFilterNamed: 'Kind').
	filteredItems := self filter: filteredItems bySelectedSlotClass: (self valueOfFilterNamed: 'Slot Class').
	filteredItems := self filter: filteredItems bySelectedDomainClass: (self valueOfFilterNamed: 'Class').
	"filteredItems := self filter: filteredItems bySelectedDomainClasses: (self valueOfFilterNamed: 'Slots up to')."
	^ filteredItems
]

{ #category : #'api - converting' }
LcsGtPhlowColumnedListView >> itemsProviderOnExceptionErrorElement: aBlock [
	^ self
		performBlock: [ self filteredItems asBrItemsProvider ]
		onExceptionErrorElement: [ :anElement | 
			aBlock value: anElement ]
]

{ #category : #filters }
LcsGtPhlowColumnedListView >> slotClassFilter [
	^ GtFilterTextModel new
		creator: [ :value | value ];
		named: 'Slot Class';
		order: 14;
		completion: [ GtStringsCompletionStrategy new
				completions: [ LcsBaseSlot classNamesPrefixTree ] ]
]

{ #category : #filters }
LcsGtPhlowColumnedListView >> slotKindFilter [
	^ GtFilterShortListModel new
		name: 'Kind';
		creator: [ :selectedValue | selectedValue itemValue = 'all' ifTrue: [nil] ifFalse: [selectedValue itemValue ] ];
		items: {'all'.
				'accessor'.
				'virtual'.
				'facade'};
		selectedItem: 'all';
		order: 13;
		yourself
]

{ #category : #filters }
LcsGtPhlowColumnedListView >> superclassesFilter [
	<gtExample>
	<return: #GtFilterShortListModel>
	| baseClass |
	baseClass := self baseClass.
	^ self _superclassesFilter: baseClass
]

{ #category : #filtering }
LcsGtPhlowColumnedListView >> valueOfFilterNamed: aString [
	^ (self filterItemLabelled: aString) asSearchFilter
]
