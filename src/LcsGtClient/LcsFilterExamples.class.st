Class {
	#name : #LcsFilterExamples,
	#superclass : #Object,
	#instVars : [
		'subscriptionRegistry',
		'subscriptions',
		'gtFilterItemsElement',
		'currentFilterModel'
	],
	#category : #'LcsGtClient-Examples'
}

{ #category : #examples }
LcsFilterExamples >> booleanFilterLabel: aLabel value: anInitialValue [
	| fElement |
	"fElement := booleanModel asFilterLabeledElement."
	self currentFilterModel: (GtFilterBooleanModel new
			switchedOn: anInitialValue;
			name: aLabel).
	self assert: self subscriptions isEmpty.
	fElement := self currentFilterModel asFilterViewModel.
	self assert: self subscriptions size equals: 2.
	self assert: (self subscriptionRegistry subscriptionsForClass: GtFilterModelLabelChanged) isEmpty.
	self assert: (self subscriptionRegistry subscriptionsForClass: GtFilterBooleanViewModelSwitchChanged) isEmpty.
	self
		assert: (self subscriptions
				detect: [ :each | each announcementClass = GtFilterModelLabelChanged ]
				ifNone: [  ]) notNil.
	self
		assert: (self subscriptions
				detect: [ :each | each announcementClass = GtFilterBooleanModelSwitchChanged ]
				ifNone: [  ]) notNil.
	^ self currentFilterModel
]

{ #category : #examples }
LcsFilterExamples >> classInstanceShortListModel [
	<gtExample>
	<return: #GtFilterShortListModel>
	
	self currentFilterModel: (GtFilterShortListModel new
			items: self instanceAndClassItems;
			selectedItem: 'class';
			name: 'Side').
	self assert: self subscriptions isEmpty.
	self
		assert: self currentFilterModel itemsFuture wait
		equals: (self instanceAndClassItems collect: #asFilterModelItem).
	self assert: self currentFilterModel selectedItem equals: 'class' asFilterModelItem.

	self currentFilterModel asFilterLabeledElement.

	self subscriptions.
	self currentFilterModel weak
		when: GtFiltersModelItemsChanged
		do: [ Transcript crShow: 'class/instance selection changed1' ].

	^ self currentFilterModel
]

{ #category : #examples }
LcsFilterExamples >> completedBooleanModel [
	<gtExample>
	^ self booleanFilterLabel: 'Completed' value: true.
]

{ #category : #accessing }
LcsFilterExamples >> currentFilterModel [
	^ currentFilterModel
]

{ #category : #accessing }
LcsFilterExamples >> currentFilterModel: anObject [
	currentFilterModel := anObject.
	self subscriptionRegistry: self currentFilterModel announcer subscriptions.
	self subscriptions: self subscriptionRegistry subscriptions.

]

{ #category : #transcript }
LcsFilterExamples >> filterItemRemoved: anAnouncement [
	Transcript crShow: 'filter model removed:' , anAnouncement item printString , ' from model: ' , anAnouncement model printString.
]

{ #category : #transcript }
LcsFilterExamples >> filterItemsChanged: anAnouncement [
	Transcript crShow: 'filter model items changed:' , anAnouncement printString.
]

{ #category : #examples }
LcsFilterExamples >> filterItemsModel [
	" self new filterItemsModel "

	<gtExample>
	| block startedBooleanModel completedBooleanModel aModelUsingAdd classInstanceShortListModel slotKindFilter slotClassFilter |
	block := [ Transcript crShow: 'model updated' ].
	startedBooleanModel := self startedBooleanModel.
	completedBooleanModel := self completedBooleanModel.
	classInstanceShortListModel := self classInstanceShortListModel.
	slotKindFilter := self slotKindFilter.
	slotClassFilter := self slotClassFilter.
	aModelUsingAdd := GtFilterItemsModel new.
	gtFilterItemsElement := aModelUsingAdd asFiltersElement.
	aModelUsingAdd announcer
		when: GtFiltersModelUpdated
		send: #filterModelUpdated:
		to: self.
	aModelUsingAdd weak
		when: GtFiltersModelItemAdded
		send: #filterModelItemAdded:
		to: self.
	aModelUsingAdd weak
		when: GtFiltersModelItemRemoved
		send: #filterItemRemoved:
		to: self.
	aModelUsingAdd weak
		when: GtFiltersViewModelItemsChanged
		send: #filterItemsChanged:
		to: self.
	aModelUsingAdd
		addFilterModel: startedBooleanModel;
		addFilterModel: completedBooleanModel;
		addFilterModel: classInstanceShortListModel;
		addFilterModel: GtFilterModelExamples new toggleModelWithIcons;
		addFilterModel: slotKindFilter;
		addFilterModel: slotClassFilter.
	^ aModelUsingAdd
]

{ #category : #transcript }
LcsFilterExamples >> filterModelItemAdded: anAnouncement [
	Transcript crShow: 'filter model added:' , anAnouncement item printString , ' to model: ' , anAnouncement model printString..
]

{ #category : #transcript }
LcsFilterExamples >> filterModelUpdated: anAnouncement [
	Transcript crShow: 'filter model updated:' , anAnouncement model printString.
	"anAnouncement model items do: [ :each |
		Transcript cr; tab; show: each printString ]"
]

{ #category : #examples }
LcsFilterExamples >> filtersItemsElement [
	<gtExample>
	self filterItemsModel.
	^ self gtFilterItemsElement
]

{ #category : #examples }
LcsFilterExamples >> filtersItemsElement_FiltersViewModel [
	<gtExample>
	self filterItemsModel.
	^ self gtFilterItemsElement filtersViewModel
]

{ #category : #examples }
LcsFilterExamples >> filtersItemsElement_FiltersViewModel_FilterItemsModel [
	<gtExample>
	self filterItemsModel.
	^ self gtFilterItemsElement filtersViewModel filtersModel
]

{ #category : #examples }
LcsFilterExamples >> filtersItemsElement_FiltersViewModel_FilterViewModels [
	<gtExample>
	self filterItemsModel.
	^ self gtFilterItemsElement filtersViewModel  instVarNamed: 'filterViewModels'
]

{ #category : #accessing }
LcsFilterExamples >> gtFilterItemsElement [
	^ gtFilterItemsElement
]

{ #category : #accessing }
LcsFilterExamples >> gtFilterItemsElement: anObject [
	gtFilterItemsElement := anObject
]

{ #category : #private }
LcsFilterExamples >> instanceAndClassItems [
	^ {'instance'.
		'class'}
]

{ #category : #transcript }
LcsFilterExamples >> onFeedbackUpdate [
	Transcript crShow: 'Hello'
]

{ #category : #examples }
LcsFilterExamples >> slotClassFilter [
	<gtExample>
	<return: #GtFilterShortListModel>
	
	self currentFilterModel: (
		GtFilterTextModel new
			creator: [ :value | GtSearchMethodsWithClassPatternFilter new pattern: value ];
			named: 'Slot Class';
			order: 14;
			completion: [ GtStringsCompletionStrategy new
					completions: [ LcsBaseSlot classNamesPrefixTree ] ]).
	self assert: self subscriptions isEmpty.
	"self
		assert: self currentFilterModel itemsFuture wait
		equals: (self instanceAndClassItems collect: #asFilterModelItem).
	self assert: self currentFilterModel selectedItem equals: 'class' asFilterModelItem."

	self currentFilterModel asFilterLabeledElement.

	self subscriptions.
	self currentFilterModel weak
		when: GtFiltersModelItemsChanged
		do: [ Transcript crShow: 'class/instance selection changed1' ].

	^ self currentFilterModel
]

{ #category : #examples }
LcsFilterExamples >> slotKindFilter [
	<gtExample>
	<return: #GtFilterShortListModel>
	
	self currentFilterModel: (
		GtFilterShortListModel new
			name: 'Kind';
			items: {'all'.
					'accessor'.
					'virtual'.
					'facade'};
			selectedItem: 'all';
			order: 13;
			yourself).
	self assert: self subscriptions isEmpty.
	"self
		assert: self currentFilterModel itemsFuture wait
		equals: (self instanceAndClassItems collect: #asFilterModelItem).
	self assert: self currentFilterModel selectedItem equals: 'class' asFilterModelItem."

	self currentFilterModel asFilterLabeledElement.

	self subscriptions.
	self currentFilterModel weak
		when: GtFiltersModelItemsChanged
		do: [ Transcript crShow: 'class/instance selection changed1' ].

	^ self currentFilterModel
]

{ #category : #examples }
LcsFilterExamples >> startedBooleanModel [
	<gtExample>
	^ self booleanFilterLabel: 'Started' value: true.
]

{ #category : #examples }
LcsFilterExamples >> subscriptionExample [
	<gtExample>
	| startedBooleanModel |
	startedBooleanModel := self startedBooleanModel.
	
	startedBooleanModel weak
		when: GtFilterBooleanModelSwitchChanged
		send: #value
		to: [ Transcript crShow: startedBooleanModel switchedOn asString ].

	^ startedBooleanModel
]

{ #category : #accessing }
LcsFilterExamples >> subscriptionRegistry [
	^ subscriptionRegistry
]

{ #category : #accessing }
LcsFilterExamples >> subscriptionRegistry: anObject [
	subscriptionRegistry := anObject
]

{ #category : #accessing }
LcsFilterExamples >> subscriptions [
	^ subscriptions
]

{ #category : #accessing }
LcsFilterExamples >> subscriptions: anObject [
	subscriptions := anObject
]
