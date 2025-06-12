Class {
	#name : #LcsSlotCreationForm,
	#superclass : #Object,
	#instVars : [
		'onAccept',
		'packageAndTagName',
		'onElementCreated',
		'onReset',
		'slotClassName',
		'slotName',
		'targetClass',
		'allowNil',
		'required',
		'slotType'
	],
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsSlotCreationForm class >> componentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
LcsSlotCreationForm class >> isAdditionForm [
	^ true
]

{ #category : #'instance creation' }
LcsSlotCreationForm class >> newOn: aTargetClass [
	| instance |
	instance := self new 
		targetClass: aTargetClass;
		yourself.
	self assert: instance targetClass equals: aTargetClass.
	^ instance
]

{ #category : #accessing }
LcsSlotCreationForm class >> priority [
	^ self subclassResponsibility
]

{ #category : #accessing }
LcsSlotCreationForm class >> slotDefintionTypeClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
LcsSlotCreationForm >> allowNil [
	^ allowNil
]

{ #category : #accessing }
LcsSlotCreationForm >> allowNil: anObject [
	allowNil := anObject
]

{ #category : #magritte }
LcsSlotCreationForm >> allowNilDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Nil';
		priority: 8;
		accessor: #allowNil;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: GtPharoIndex current classNameTree ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #converting }
LcsSlotCreationForm >> asElement [
	| viewModel |
	viewModel := self asGtMagritteViewModel focusFirstInputField.
	self onElementCreated
		ifNotNil: [ :aCallback | viewModel onElementCreated: aCallback ].
	^ viewModel asElement
]

{ #category : #accessing }
LcsSlotCreationForm >> classNamed: aValue [
	^ Smalltalk classNamed: aValue trim
]

{ #category : #callbacks }
LcsSlotCreationForm >> commit [
	^ self subclassResponsibility
]

{ #category : #callbacks }
LcsSlotCreationForm >> commitPackage [
	| aPackage |
	(RPackageOrganizer default includesPackageNamed: packageAndTagName packageName)
		ifTrue: [ aPackage := RPackageOrganizer default
					packageNamed: packageAndTagName packageName.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage classTagNamed: aTagName ifAbsent: [ aPackage addClassTag: aTagName ] ] ]
		ifFalse: [ aPackage := (RPackage named: packageAndTagName packageName)
					register.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage addClassTag: aTagName ] ]
]

{ #category : #accessing }
LcsSlotCreationForm >> contextMenuItemsForSuperclass [
	^ {'Browse references'
			-> [ :aBrEditor | aBrEditor phlow spawnObject: aBrEditor text asString asClass gtReferences ]}
]

{ #category : #accessing }
LcsSlotCreationForm >> ghostTextFor: aString [
	^ BrGhostTextAttribute
		for: (aString asRopedText glamorousFormEditorCodeFontAndSize foreground: Color lightGray)
]

{ #category : #accessing }
LcsSlotCreationForm >> hasPackageAndTag [
	^ true
]

{ #category : #initialization }
LcsSlotCreationForm >> initialize [
	packageAndTagName := GtPackageAndTagName new.
	slotName := ''.
	slotClassName := ''.
	allowNil := false.
	required := false.
	slotType := ''
]

{ #category : #accessing }
LcsSlotCreationForm >> isInstanceSideClass: aValue [
	| aClass |
	aClass := self classNamed: aValue.
	^ aClass isNil or: [ aClass isInstanceSide ]
]

{ #category : #accessing }
LcsSlotCreationForm >> isSlotClass: aValue [ 
	| class |
	class := self classNamed: aValue.
	class isNil ifTrue: [ ^ false ].
	class = self slotDefintionTypeClass ifTrue: [ ^ true ]. 
	^ class inheritsFrom: self slotDefintionTypeClass
]

{ #category : #magritte }
LcsSlotCreationForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Create';
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ | aClass |
					aClass := self commit.
					onAccept ifNotNil: [ onAccept value: aClass ] ] 
						on: Error do: #debug ]);
		beEnabledOnValidOverallStatus
]

{ #category : #magritte }
LcsSlotCreationForm >> magritteCancelAction [
	<magritteActionDescription>
	^ super magritteCancelAction
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ onReset ifNotNil: [ onReset value ] ] 
						on: Error do: #debug ]);
		beAlwaysEnabled
]

{ #category : #accessing }
LcsSlotCreationForm >> onAccept [

	^ onAccept
]

{ #category : #accessing }
LcsSlotCreationForm >> onAccept: aBlock [

	onAccept := aBlock
]

{ #category : #accessing }
LcsSlotCreationForm >> onElementCreated [
	^ onElementCreated
]

{ #category : #accessing }
LcsSlotCreationForm >> onElementCreated: aBlock [
	onElementCreated := aBlock
]

{ #category : #accessing }
LcsSlotCreationForm >> onReset [
	^ onReset
]

{ #category : #accessing }
LcsSlotCreationForm >> onReset: aBlock [
	onReset := aBlock
]

{ #category : #accessing }
LcsSlotCreationForm >> packageAndTagDescription [
	"<magritteDescription>"
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTagName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #accessing }
LcsSlotCreationForm >> packageAndTagName [

	^ packageAndTagName
]

{ #category : #accessing }
LcsSlotCreationForm >> packageAndTagName: anObject [

	packageAndTagName := anObject
]

{ #category : #accessing }
LcsSlotCreationForm >> required [
	^ required
]

{ #category : #accessing }
LcsSlotCreationForm >> required: anObject [
	required := anObject
]

{ #category : #magritte }
LcsSlotCreationForm >> requiredDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Required';
		priority: 9;
		accessor: #required;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: GtPharoIndex current classNameTree ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #accessing }
LcsSlotCreationForm >> selectInNavigationModel: aNavigationModel anInstance: anInstance [
	aNavigationModel selectPackage: anInstance package.

	anInstance tags
		ifNotEmpty: [ aNavigationModel
				selectPackageTag: (anInstance package classTagNamed: anInstance tags first) ].

	aNavigationModel selectClass: anInstance
]

{ #category : #accessing }
LcsSlotCreationForm >> slotClassName [
	^ slotClassName
]

{ #category : #accessing }
LcsSlotCreationForm >> slotClassName: anObject [
	slotClassName := anObject
]

{ #category : #magritte }
LcsSlotCreationForm >> slotClassNameDescription [
	"<magritteDescription>"
	^ MAStringDescription new
		label: 'Slot Class';
		priority: 2;
		accessor: #slotClassName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: GtPharoIndex current classNameTree ];
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | (self classNamed: aValue) notNil ] labelled: 'Unknown class';
		addCondition: [ :aValue | self isInstanceSideClass: aValue ] labelled: 'Must be an instance-side class';
		addCondition: [ :aValue | self isSlotClass: aValue ] labelled: 'Must be or a subclass of ' , self slotDefintionTypeClass name;
		beRequired
]

{ #category : #accessing }
LcsSlotCreationForm >> slotDefintionTypeClass [	
	^ self class slotDefintionTypeClass
]

{ #category : #accessing }
LcsSlotCreationForm >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotCreationForm >> slotName: anObject [
	slotName := anObject
]

{ #category : #magritte }
LcsSlotCreationForm >> slotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Slot Name';
		priority: 1;
		accessor: #slotName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: GtPharoIndex current classNameTree ];
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue trim notEmpty  ] labelled: 'Enter slot name';
		addCondition: [ :aValue | aValue trim size >= 2 ] labelled: 'Slot name must be at least 2 characters';
		beRequired
]

{ #category : #accessing }
LcsSlotCreationForm >> slotType [
	^ slotType
]

{ #category : #accessing }
LcsSlotCreationForm >> slotType: anObject [
	slotType := anObject
]

{ #category : #magritte }
LcsSlotCreationForm >> slotTypeDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		"reference: MAClassDescription new;"
		options: LcsSlotDefinition allSubclasses;
		selectorAccessor: 'slotType';
		"groupBy: #grouping;"
		label: 'Slot Type';
		priority: 2;
		yourself
]

{ #category : #accessing }
LcsSlotCreationForm >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
	^ [ :aMemento :aDescription :aForm | 
	| aTagger aTaggerAptitude |
	aTagger := BrTagger new hFitContentLimited.
	aForm hMatchParent.
	aTagger
		padding: (BlInsets top: -2 bottom: 5);
		clipChildren: false;
		aptitude: (aTaggerAptitude := GtCreationEditableTaggerAptitude new
					margin: (BlInsets
							top: 0
							bottom: 3
							left: 0
							right: 5);
					tagLabel: [ :aTag | 
						| aLabel |
						aLabel := BrEditor new fitContent
								text: (aDescription displayStringFor: aTag name);
								aptitude: (BrGlamorousEditableLabelAptitude new glamorousFormEditorCodeFontAndSize
										defaultForeground: Color black);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to previous form item';
										description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
										combination: BlKeyCombination shiftTab;
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionBackward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to next form item';
										description: 'Moves to the next form item. If none is found, we cycle back to the first.';
										combination: (BlKeyCombination tab or: BlKeyCombination enter);
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionForward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]).

						aDescription blocShortcuts
							ifNotNil: [ :aBlockReturningCollection | 
								aBlockReturningCollection value
									do: [ :aShortcut | aLabel addShortcut: aShortcut ] ].

						aCompletionStrategy
							ifNotNil: [ (GtCompletionController on: aLabel strategy: aCompletionStrategy) install ].
						aContextMenuBlock
							ifNotNil: [ aLabel
									addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
											content: [ aContextMenuBlock
													value: aTag name
													value: aLabel
													value: aMemento ]) ].
						aLabel ]).
	aTagger
		when: BrTaggerAddTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget addTag: aRequest tag.
			aValue := aTagger tags collect: #name thenSelect: #isNotEmpty.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		when: BrTaggerRenameTagRequest
		do: [ :aRequest | 
			(aRequest tag name = aRequest newName) not
				ifTrue: [ | aValue |
					aRequest currentTarget renameTag: aRequest tag to: aRequest newName.
					aValue := aTagger tags collect: #name.

					GtMagritteBuilderUtility
						write: aValue asArray
						using: aDescription
						memento: aMemento
						element: aTagger ] ].
	aTagger
		when: BrTaggerRemoveTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget removeTag: aRequest tag.
			aValue := aTagger tags collect: #name.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theTagger :aSink | 
					| theValues |
					(theTagger tags isEmpty or: [ aSink value isChanged not ])
						ifTrue: [ theValues := aSink value currentValue.
							theTagger namedTags: theValues ] ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].
	GtMagritteBuilderUtility
		newValidationContainerWith: aTagger
		memento: aMemento
		using: aDescription ]
]

{ #category : #accessing }
LcsSlotCreationForm >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsSlotCreationForm >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #accessing }
LcsSlotCreationForm >> toolFor: anInstance [
	^ GtClassCoderTool forClass: anInstance
]
