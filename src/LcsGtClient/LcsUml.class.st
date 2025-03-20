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
