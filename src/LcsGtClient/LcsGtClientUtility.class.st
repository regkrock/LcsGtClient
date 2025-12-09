Class {
	#name : 'LcsGtClientUtility',
	#superclass : 'Object',
	#category : 'LcsGtClient-Core',
	#package : 'LcsGtClient',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsGtClientUtility class >> openDashboard [
	^ self openLcsBasePage: 'Dashboard'
]

{ #category : 'instance creation' }
LcsGtClientUtility class >> openLcsBasePage: aPageName [
	self new
		openPage: aPageName in: 'regkrock/lcs-base/lepiter'
]

{ #category : 'instance creation' }
LcsGtClientUtility class >> openTestPage [
	^ self openLcsBasePage: 'All S-Unit Tests And Examples'
]

{ #category : 'api' }
LcsGtClientUtility >> openPage: aName in: aDatabaseName [
	| page world |
	page := (LeDatabase databaseNamed: aDatabaseName)
			pageNamed: aName.
	world := GtWorld allInstances any.
	BlTaskAction enqueueElement: world root action: [
		BlSpace spawnPage: page from: world root ]
]
