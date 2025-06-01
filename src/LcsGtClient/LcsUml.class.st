Class {
	#name : #LcsUml,
	#superclass : #Object,
	#category : #LcsGtClient
}

{ #category : #'as yet unclassified' }
LcsUml >> applicationEnvironmentClassHierarchyDiagram [
	| classes |
	classes := LcsApplicationEnvironment withAllSuperclasses.
	classes addAll: LcsReadOnlyUnitOfWork withAllSuperclasses.
	classes addAll: LcsUnitsOfWork withAllSuperclasses.
	classes addAll: LcsSystems withAllSuperclasses.
	classes addAll: LcsSystem withAllSuperclasses.
	classes addAll: LcsUnitsOfWorkManager withAllSuperclasses.
	classes addAll: LcsSystemsManager withAllSuperclasses.
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ]) ifNotNil: [ :class | classes remove: class ].
	^ GtMondrianDomainExamples new classHierarchyFor:
		(classes	
			 removeDuplicates;
		 	yourself)
]

{ #category : #'as yet unclassified' }
LcsUml >> applicationEnvironmentInstanceDiagram [
	<gtExample>
	| positions associations classes m |
	classes := 
		OrderedCollection new
			add: LcsApplicationEnvironment  class;
			add: LcsApplicationEnvironment;
			add: LcsUnitOfWork;
			add: LcsUnitsOfWork;
			add: LcsSystemsManager;
			add: LcsSystems;
			add: LcsUnitsOfWorkManager;
			add: LcsSystem;
			yourself.
		
	associations := {GtTCurrencyMoney -> {{'currency'. GtTCurrency}}}.
	associations := 
		OrderedCollection new
			add: (LcsApplicationEnvironment  class) -> {{'singleton'. LcsApplicationEnvironment}};
			add: LcsApplicationEnvironment -> {{'systemsManager'. LcsSystemsManager}};
			add: LcsSystemsManager -> {{'systems'. LcsSystems}};
			add: LcsSystems -> {{'0:m'. LcsSystem}};
			add: LcsApplicationEnvironment -> {{'unitsOfWorkManager'. LcsUnitsOfWorkManager}};
			add: LcsUnitsOfWorkManager -> {{'unitsOfWork'. LcsUnitsOfWork}};
			add: LcsUnitsOfWork -> {{'0:m'. LcsUnitOfWork}};
			yourself.
	positions := 
			((Array new: 64) at: 1 put: ((33.017664591471316@257.73549397786456)); at: 2 put: ((307.7216669718424@255.33333333333331)); at: 3 put: ((906.0686670939127@344.12685139973956)); at: 4 put: ((741.1356646219889@346.5290120442708)); at: 5 put: ((375.66666666666663@177.93117268880206)); at: 6 put: ((675.0736643473307@178.52901204427081)); at: 7 put: ((363.6966654459635@352.93117268880206)); at: 8 put: ((818.3276621500651@176.12685139973956)); at: 9 put: ((239.84166971842444@270.9457229193704)); at: 10 put: ((239.84166971842444@270.9457229193704)); at: 11 put: ((239.84166971842444@270.9457229193704)); at: 12 put: ((239.84166971842444@270.9457229193704)); at: 13 put: ((239.84166971842444@270.9457229193704)); at: 14 put: ((239.84166971842444@270.9457229193704)); at: 15 put: ((239.84166971842444@270.9457229193704)); at: 16 put: ((239.84166971842444@270.9457229193704)); at: 17 put: ((404.2728261956813@207.52901204427081)); at: 18 put: ((404.2728261956813@207.52901204427081)); at: 19 put: ((404.2728261956813@207.52901204427081)); at: 20 put: ((404.2728261956813@207.52901204427081)); at: 21 put: ((404.2728261956813@207.52901204427081)); at: 22 put: ((404.2728261956813@207.52901204427081)); at: 23 put: ((404.2728261956813@207.52901204427081)); at: 24 put: ((404.2728261956813@207.52901204427081)); at: 25 put: ((507.69666544596345@192.87413019385897)); at: 26 put: ((507.69666544596345@192.87413019385897)); at: 27 put: ((507.69666544596345@192.87413019385897)); at: 28 put: ((507.69666544596345@192.87413019385897)); at: 29 put: ((507.69666544596345@192.87413019385897)); at: 30 put: ((507.69666544596345@192.87413019385897)); at: 31 put: ((507.69666544596345@192.87413019385897)); at: 32 put: ((507.69666544596345@192.87413019385897)); at: 33 put: ((756.2896677652993@191.72681372112783)); at: 34 put: ((756.2896677652993@191.72681372112783)); at: 35 put: ((756.2896677652993@191.72681372112783)); at: 36 put: ((756.2896677652993@191.72681372112783)); at: 37 put: ((756.2896677652993@191.72681372112783)); at: 38 put: ((756.2896677652993@191.72681372112783)); at: 39 put: ((756.2896677652993@191.72681372112783)); at: 40 put: ((756.2896677652993@191.72681372112783)); at: 41 put: ((402.5586282488714@284.931172688802)); at: 42 put: ((402.5586282488714@284.931172688802)); at: 43 put: ((402.5586282488714@284.931172688802)); at: 44 put: ((402.5586282488714@284.931172688802)); at: 45 put: ((402.5586282488714@284.931172688802)); at: 46 put: ((402.5586282488714@284.931172688802)); at: 47 put: ((402.5586282488714@284.931172688802)); at: 48 put: ((402.5586282488714@284.931172688802)); at: 49 put: ((521.1926676432291@362.2975135234488)); at: 50 put: ((521.1926676432291@362.2975135234488)); at: 51 put: ((521.1926676432291@362.2975135234488)); at: 52 put: ((521.1926676432291@362.2975135234488)); at: 53 put: ((521.1926676432291@362.2975135234488)); at: 54 put: ((521.1926676432291@362.2975135234488)); at: 55 put: ((521.1926676432291@362.2975135234488)); at: 56 put: ((521.1926676432291@362.2975135234488)); at: 57 put: ((847.7536684672036@359.67275406086503)); at: 58 put: ((847.7536684672036@359.67275406086503)); at: 59 put: ((847.7536684672036@359.67275406086503)); at: 60 put: ((847.7536684672036@359.67275406086503)); at: 61 put: ((847.7536684672036@359.67275406086503)); at: 62 put: ((847.7536684672036@359.67275406086503)); at: 63 put: ((847.7536684672036@359.67275406086503)); at: 64 put: ((847.7536684672036@359.67275406086503)); yourself).
	m := LcsUmlClassDiagram new
			classHierarchyFor: classes
			withAssociationsAndLabels: associations.
	m layout custom: BlBasicLayout new.
	m root children withIndexDo: [ :child :n | child relocate: (positions at: n) ].
	^ m
]

{ #category : #'as yet unclassified' }
LcsUml >> associationArrowStencilWithLabel: labelText [ 
	^ [ :class | 
		| line |
		line := BlParabollaArcElement new
			zIndex: 0;
			curvatureFraction: 0.2;
			border: (BlBorder paint: self associationColor).

		labelText notNil
			ifTrue: [ line
				clipChildren: false;
				addChild: (BrLabel new
						text: labelText;
						zIndex: 0;
						background: Color white;
						aptitude: (BrGlamorousLabelAptitude new fontSize: self labelFontSize);
						margin: (BlInsets top: 10);
						constraintsDo: [ :c | 
							c ignored vertical alignCenterAt: 0.3.
							c ignored horizontal alignCenter.
							c ignoreByLayout ]) ].

		line := line
			toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: self associationColor)).


		line ]
]

{ #category : #'as yet unclassified' }
LcsUml >> associationColor [
	^ Color orange alpha: 0.4
]

{ #category : #'as yet unclassified' }
LcsUml >> fromObjectFor: aClassOrAProposedClass in: umlModelClasses [
	aClassOrAProposedClass isClass ifTrue: [ ^ aClassOrAProposedClass superclass ].
	aClassOrAProposedClass superclass ifNotNil: [ :class | ^ class ].
	^ (umlModelClasses reject: [:each | each isClass ]) detect: [ :e | 
		e classname = aClassOrAProposedClass superclassName ] 
]

{ #category : #'as yet unclassified' }
LcsUml >> labelFontSize [
	^ 12
]

{ #category : #'as yet unclassified' }
LcsUml >> proposedUmlModelFor: umlModelClasses [
	"<example>"
	| m |
	m := GtMondrian new.
	m nodes
		stencil: [ :c | 
			BrLabel new
				border: (BlBorder paint: (c isClass ifTrue: [ Color gray ] ifFalse: [ Color blue ]));
				text: (c isClass
						ifTrue: [ c name ]
						ifFalse: [ c classname asRopedText foreground: Color blue ]);
				aptitude: BrGlamorousLabelAptitude new
						+ (BrStyleCommonAptitude new
								hovered: [ :aStyle | aStyle background: (Color blue alpha: 0.5) ]);
				when: BlClickEvent
					do: [ :e | 
						c isClass
							ifTrue: [ e target phlow spawnTool: (GtClassCoderTool forClass: c).
								e consumed: true ] ];
				padding: (BlInsets all: 5) ];
		with: umlModelClasses.
	m edges
		stencil: [ :c | 
			BlLineElement new
				border: (BlBorder paint: (c isClass ifTrue: [ Color gray ] ifFalse: [ Color blue ]));
				fromHead: (BlArrowheadTriangle new
						scale: 4;
						border: (BlBorder paint: (c isClass ifTrue: [ Color gray ] ifFalse: [ Color blue ]))) ];
		connectFrom: [ :each | self fromObjectFor: each in: umlModelClasses ].
	m layout tree levelDistance: 20.
	^ m
]

{ #category : #'as yet unclassified' }
LcsUml >> proposedUmlModelFor: umlModelClasses associations: associationsWithLabels [ 
	| m |
	m := self proposedUmlModelFor: umlModelClasses.
	
	associationsWithLabels
		do: [ :assoc | 
			assoc value
				do: [ :labelClassPair | 
					m edges
						stencil: (self associationArrowStencilWithLabel: labelClassPair first);
						connectFrom: [ :each | self umlClassFor: assoc key in: umlModelClasses ] 
							to: [ :each | self umlClassFor: labelClassPair second in: umlModelClasses] ] ]..
							
	^ m

]

{ #category : #'as yet unclassified' }
LcsUml >> umlClassFor: aClassOrAProposedClassName in: umlModelClasses [
	aClassOrAProposedClassName isClass ifTrue: [ ^ aClassOrAProposedClassName ].
	^ (umlModelClasses reject: [:each | each isClass ]) detect: [ :e | 
		e classname = aClassOrAProposedClassName ] 
]

{ #category : #'as yet unclassified' }
LcsUml >> umlForExistingAndProposedClasses [
	<example>
	^ self proposedUmlModelFor: 
		{	
			SequenceableCollection.
			ArrayedCollection.
			LcsProposedClass new
				classname: 'LxxSample';
				superclassName: #SequenceableCollection.
			LcsProposedClass new
				classname: 'LxxSample2';
				superclassName: 'LxxSample'
		}
]

{ #category : #'as yet unclassified' }
LcsUml >> umlForExistingAndProposedClassesWithAssociations [
	<example>
	| classes associations |
	classes := 
		{	
			SequenceableCollection.
			ArrayedCollection.
			LcsProposedClass new
				classname: 'LxxSample';
				superclassName: #SequenceableCollection.
			LcsProposedClass new
				classname: 'LxxSample2';
				superclassName: 'LxxSample'
		}.
	associations := 
		{ 'LxxSample2' -> { { 'xxxx'. ArrayedCollection } } }.
	^ self proposedUmlModelFor: classes associations: associations
]
