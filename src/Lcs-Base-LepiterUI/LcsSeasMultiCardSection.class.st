Class {
	#name : #LcsSeasMultiCardSection,
	#superclass : #GtHomeMultiCardSection,
	#category : #'Lcs-Base-LepiterUI-Lepiter'
}

{ #category : #accessing }
LcsSeasMultiCardSection >> aboutThisBookCard [
	"<gtSectionCard>"
	<gtExample>  
	<notest>
	^ GtHomeCard page
		priority: 20;
		pageName: 'About this book'; 
		databaseName: self gtBookName;
		yourself
		
]

{ #category : #accessing }
LcsSeasMultiCardSection >> defaultPriority [
	^ 5
]

{ #category : #accessing }
LcsSeasMultiCardSection >> gtBookCard [
	<gtSectionCard>
	<gtExample>
	<notest>
	"^ self homeCard " 
	| card |
	card := GtHomeCard lepiterBaseWithTableOfContents
		title: 'SEAS Knowledge Base';
		description: 'Explore your SEAS knowledge base';
		priority: 5;
		"primaryKnowledgebase;
		recentlyEditedPage;
		editableToolbar;"
		pageName: 'Lcs Table of Contents';
		databaseName: 'regkrock/seas/lepiter';
		editableToolbar;
		details: [ :db | 
			| snippets somePages |
			somePages := db pages select: #shouldAppearInIndexOrDailyNotes.
			snippets := somePages flatCollect: #allChildrenDepthFirst.
			'Your SEAS Knowledge Base includes '
				, somePages size asString , ' pages containing '
				, snippets size asString , ' snippets of '
				, (snippets groupedBy: #class) size asString , ' different kinds.' ]
				yourself.
	^ card
]

{ #category : #accessing }
LcsSeasMultiCardSection >> gtBookCardSection [
	<gtExample>
	<notest>
	^ self
]

{ #category : #accessing }
LcsSeasMultiCardSection >> gtBookName [
	^ 'SEAS Knowledge Base'
]

{ #category : #accessing }
LcsSeasMultiCardSection >> sectionTitle [
	^ 'Start'
]
