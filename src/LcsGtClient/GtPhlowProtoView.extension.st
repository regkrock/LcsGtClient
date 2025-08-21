Extension { #name : #GtPhlowProtoView }

{ #category : #'*LcsGtClient' }
GtPhlowProtoView >> filteredColumnedList [
	<return: #GtPhlowColumnedListView>
	^ LcsGtPhlowColumnedListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]
