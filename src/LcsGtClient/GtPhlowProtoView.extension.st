Extension { #name : 'GtPhlowProtoView' }

{ #category : '*LcsGtClient' }
GtPhlowProtoView >> lcsFilteredColumnedList [
	<return: #LcsGtPhlowColumnedListView>
	^ LcsGtPhlowColumnedListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]
