Class {
	#name : #LcsSlotCreationForm,
	#superclass : #Object,
	#instVars : [
		'onAccept',
		'packageAndTagName',
		'onElementCreated',
		'onReset',
		'targetClass',
		'slotDefinitionClass',
		'slotModelBuilder',
		'mode'
	],
	#category : #'Lcs-Base-LepiterUI-Forms - Models'
}

{ #category : #accessing }
LcsSlotCreationForm class >> defaultSlotDefintionClass [
	^ LcsSlotDefinition
]

{ #category : #accessing }
LcsSlotCreationForm class >> isAdditionForm [
	^ true
]

{ #category : #'instance creation' }
LcsSlotCreationForm class >> newEditOn: aTargetClass [
	^ self new 
		initializeEditOn: aTargetClass;
		yourself
]

{ #category : #'instance creation' }
LcsSlotCreationForm class >> newOn: aTargetClass [
	^ self new 
		initializeOn: aTargetClass;
		yourself
]

{ #category : #accessing }
LcsSlotCreationForm class >> priority [
	^ self subclassResponsibility
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

{ #category : #private }
LcsSlotCreationForm >> classesOrNilsFor: aCollectionOfClassNames [ 
	"Return collection of Class. If a Class does not exist, `nil` value is used."

	<return: #Collection of: #Class>
	^ aCollectionOfClassNames
		collect: [ :eachClasstName | Smalltalk classOrTraitNamed: eachClasstName asString trimBoth ]
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

{ #category : #configuration }
LcsSlotCreationForm >> defaultSlotDefintionClass [	
	^ self class defaultSlotDefintionClass
]

{ #category : #accessing }
LcsSlotCreationForm >> ghostTextFor: aString [
	^ BrGhostTextAttribute
		for: (aString asRopedText glamorousFormEditorCodeFontAndSize foreground: Color lightGray)
]

{ #category : #'gt view' }
LcsSlotCreationForm >> gtInspectView: view [
	"<gtView>"
	^ view
		title: 'Test';
		priority: 49;
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :aButton | aButton phlow spawnObject: self ] ]
]

{ #category : #testing }
LcsSlotCreationForm >> hasPackageAndTag [
	^ true
]

{ #category : #initialization }
LcsSlotCreationForm >> initialize [ 
	super initialize.
	self slotDefinitionClass: ''
	
]

{ #category : #testing }
LcsSlotCreationForm >> isEditMode [
	self mode = #edit
]

{ #category : #testing }
LcsSlotCreationForm >> isInstanceSideClass: aValue [
	| aClass |
	aClass := self classNamed: aValue.
	^ aClass isNil or: [ aClass isInstanceSide ]
]

{ #category : #testing }
LcsSlotCreationForm >> isSlotClass: aValue [ 
	| class |
	class := self classNamed: aValue.
	class isNil ifTrue: [ ^ false ].
	class = self defaultSlotDefintionClass ifTrue: [ ^ true ]. 
	^ class inheritsFrom: self defaultSlotDefintionClass
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
LcsSlotCreationForm >> mode [
	^ mode
]

{ #category : #accessing }
LcsSlotCreationForm >> mode: aString [ 
	mode := aString
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

{ #category : #accessing }
LcsSlotCreationForm >> selectInNavigationModel: aNavigationModel anInstance: anInstance [
	aNavigationModel selectPackage: anInstance package.

	anInstance tags
		ifNotEmpty: [ aNavigationModel
				selectPackageTag: (anInstance package classTagNamed: anInstance tags first) ].

	aNavigationModel selectClass: anInstance
]

{ #category : #private }
LcsSlotCreationForm >> slotDefinitionBuilderClass [
	LcsSlotDefinitionBuilder withAllSubclasses do: [ :each |
		each slotDefinitionClass = self slotDefinitionClass asClass 
			ifTrue: [ ^ each ]].
	^ LcsSlotDefinitionBuilder
]

{ #category : #accessing }
LcsSlotCreationForm >> slotDefinitionClass [
	^ slotDefinitionClass
]

{ #category : #accessing }
LcsSlotCreationForm >> slotDefinitionClass: anObject [
	slotDefinitionClass := anObject
]

{ #category : #accessing }
LcsSlotCreationForm >> slotDefinitionClassChangedTo: aClassName [

]

{ #category : #magritte }
LcsSlotCreationForm >> slotDefinitionClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Slot Definition Class';
		autoAccept: true;
		priority: 2;
		accessor: (MASelectorAccessor read: #slotDefinitionClass write: #slotDefinitionClassChangedTo:) ;
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
		addCondition: [ :aValue | self isSlotClass: aValue ] labelled: 'Must be or a subclass of ' , self defaultSlotDefintionClass name;
		beRequired
]

{ #category : #accessing }
LcsSlotCreationForm >> slotModelBuilder [
	^ slotModelBuilder
]

{ #category : #accessing }
LcsSlotCreationForm >> slotModelBuilder: anObject [
	slotModelBuilder := anObject
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
