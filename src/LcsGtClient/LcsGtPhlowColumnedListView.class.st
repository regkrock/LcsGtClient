Class {
	#name : 'LcsGtPhlowColumnedListView',
	#superclass : 'GtPhlowColumnedListView',
	#traits : 'LtSlotFilter',
	#classTraits : 'LtSlotFilter classTrait',
	#category : 'LcsGtClient-Views',
	#package : 'LcsGtClient',
	#tag : 'Views'
}

{ #category : 'api - converting' }
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
	self filterItemsModel addFilterModel: self newSlotKindFilter.
	self filterItemsModel addFilterModel: self newSuperclassesFilter.
	self filterItemsModel addFilterModel: self newSlotClassFilter.
	self filterItemsModel addFilterModel: self newDomainClassFilter.
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

{ #category : 'filters' }
LcsGtPhlowColumnedListView >> baseClass [
	| contextObject contextClass |
	contextObject := self buildContext object.
	contextClass := contextObject isClass ifTrue: [ contextObject ] ifFalse: [ contextObject class ].
	^ contextClass = LcsSlotModel
		ifTrue: [ self buildContext object domainClass ]
		ifFalse: [ contextClass ]
]

{ #category : 'api - converting' }
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
