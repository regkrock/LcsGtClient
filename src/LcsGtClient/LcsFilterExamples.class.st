Class {
	#name : #LcsFilterExamples,
	#superclass : #Object,
	#category : #'LcsGtClient-Examples'
}

{ #category : #'as yet unclassified' }
LcsFilterExamples >> booleanFilterLabel: aLabel value: anInitialValue [
	| fElement subscriptions booleanModel subscriptionRegistry |

	booleanModel :=GtFilterBooleanModel new
			switchedOn: anInitialValue;
			name: aLabel.

	subscriptionRegistry := booleanModel announcer subscriptions.
	subscriptions := subscriptionRegistry subscriptions.

	self assert: subscriptions isEmpty.

	fElement := booleanModel asFilterViewModel.
	"fElement := booleanModel asFilterLabeledElement."
	
	self assert: subscriptions size equals: 2.
	self
		assert: (subscriptionRegistry subscriptionsForClass: GtFilterModelLabelChanged) isEmpty.
	self
		assert: (subscriptionRegistry
				subscriptionsForClass: GtFilterBooleanViewModelSwitchChanged) isEmpty.
	self
		assert: (subscriptions
				detect: [ :each | each announcementClass = GtFilterModelLabelChanged ]
				ifNone: [  ]) notNil.
	self
		assert: (subscriptions
				detect: [ :each | each announcementClass = GtFilterBooleanModelSwitchChanged ]
				ifNone: [  ]) notNil.
	^ booleanModel
]

{ #category : #'as yet unclassified' }
LcsFilterExamples >> completedBooleanModel [
	<gtExample>
	^ self booleanFilterLabel: 'Completed' value: true.
]

{ #category : #examples }
LcsFilterExamples >> filtersModel [
	<gtExample>
	| block startedBooleanModel completedBooleanModel fElement aModelUsingAdd |
	block := [ Transcript crShow: 'model updated' ].

	startedBooleanModel := self startedBooleanModel.
	completedBooleanModel := self completedBooleanModel.

	aModelUsingAdd := GtFilterItemsModel new.
	fElement := aModelUsingAdd asFiltersElement.
	startedBooleanModel announcer
		when: GtFilterBooleanModelSwitchChanged
			do: [ Transcript crShow: '''Not started'' toggled' ];
		when: GtFilterModelLabelChanged
			do: [ Transcript crShow: '''Not started'' toggled' ].
	completedBooleanModel announcer
		when: GtFilterBooleanModelSwitchChanged
		do: [ Transcript crShow: '''Completed'' toggled' ].

	aModelUsingAdd announcer
		when: GtFiltersModelUpdated
		send: #value
		to: block.	"do: [ Transcript crShow: 'model updated' ]."
	aModelUsingAdd weak
		when: GtFiltersModelItemAdded
		do: [ Transcript crShow: 'model added' ].
	aModelUsingAdd weak
		when: GtFiltersModelItemRemoved
		do: [ Transcript crShow: 'model removed' ].
	aModelUsingAdd weak
		when: GtFiltersModelItemsChanged
		do: [ Transcript crShow: 'model changed' ].

	aModelUsingAdd
		addFilterModel: startedBooleanModel;
		addFilterModel: completedBooleanModel.

	^ aModelUsingAdd
]

{ #category : #'as yet unclassified' }
LcsFilterExamples >> startedBooleanModel [
	<gtExample>
	^ self booleanFilterLabel: 'Started' value: true.
]

{ #category : #'as yet unclassified' }
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
