Extension { #name : 'GtPhlowProtoView' }

{ #category : '*LcsGtClient' }
GtPhlowProtoView >> lcsFilteredColumnedList [
	<return: #GtPhlowColumnedListView>
	^ LcsGtPhlowColumnedListView new
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect
]
