Extension { #name : #GtInspectorSlotNode }

{ #category : #'*Lcs-Base-LepiterUI' }
GtInspectorSlotNode >> changeValue [ 
	^ self hostObject changeValueForSlot: self slot name
]
