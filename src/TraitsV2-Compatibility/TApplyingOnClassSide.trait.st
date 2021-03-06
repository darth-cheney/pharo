"
Kernel trait for applying on the class side
"
Trait {
	#name : #TApplyingOnClassSide,
	#category : #'TraitsV2-Compatibility-Traits'
}

{ #category : #compiling }
TApplyingOnClassSide >> acceptsLoggingOfCompilation [
	"Answer whether the receiver's method submisions and class defintions should be logged to the changes file and to the current change set.  The metaclass follows the rule of the class itself."

	^ self instanceSide acceptsLoggingOfCompilation
]

{ #category : #'instance variables' }
TApplyingOnClassSide >> addInstVarNamed: aString [ 
	"Add the argument, aString, as one of the receiver's instance variables."

	| fullString |
	fullString := String streamContents: [:strm |
		self instVarNames do: [:aString2 | strm nextPutAll: aString2; space].
		strm nextPutAll: aString].
	self instanceVariableNames: fullString
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> addObsoleteSubclass: aClass [
	"Do nothing."
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> addSubclass: aClass [
	"Do nothing."
]

{ #category : #'initialize-release' }
TApplyingOnClassSide >> adoptInstance: oldInstance from: oldMetaClass [ 
	^self explicitRequirement.
]

{ #category : #compiling }
TApplyingOnClassSide >> binding [
	"return an association that can be used as the binding
	 To share it between methods, reuse an existing one if possible"
	^self methodDict 
		ifEmpty: [nil -> self]
		ifNotEmpty: [:dict | dict anyOne classBinding]
]

{ #category : #compiling }
TApplyingOnClassSide >> bindingOf: varName [

	^self instanceSide classBindingOf: varName
]

{ #category : #testing }
TApplyingOnClassSide >> canZapMethodDictionary [
	"Return true if it is safe to zap the method dictionary on #obsolete"
	self soleInstance == nil
		ifTrue:[^true]
		ifFalse:[^self soleInstance canZapMethodDictionary]
]

{ #category : #accessing }
TApplyingOnClassSide >> category [
	^ self instanceSide category
]

{ #category : #'pool variables' }
TApplyingOnClassSide >> classPool [
	"Answer the dictionary of class variables."

	^self instanceSide classPool
]

{ #category : #'accessing instances and variables' }
TApplyingOnClassSide >> classVarNames [
	"Answer a set of the names of the class variables defined in the receiver's instance."
	
	self instanceSide ifNil: [ ^ Set new ].
	^self instanceSide classVarNames
]

{ #category : #'fileIn/Out' }
TApplyingOnClassSide >> definition [
	^self explicitRequirement.
]

{ #category : #'accessing hierarchy protocol' }
TApplyingOnClassSide >> hasClassSide [
	^false
]

{ #category : #initialize }
TApplyingOnClassSide >> initializeFrom: anotherClassTrait [
	self traitComposition: self traitComposition copyTraitExpression.
	self methodDict: self methodDict copy.
	self localSelectors: self localSelectors copy.
	self basicOrganization: self organization copy.
]

{ #category : #'initialize-release' }
TApplyingOnClassSide >> instanceVariableNames: instVarString [
	^self explicitRequirement.
]

{ #category : #testing }
TApplyingOnClassSide >> isAnonymous [
	^self soleInstance isAnonymous 
]

{ #category : #testing }
TApplyingOnClassSide >> isMeta [
	^ true
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> isMetaclassOfClassOrNil [
	
	^ self instanceSide 
		ifNil: [ true ] 
		ifNotNil: [ :nonMetaClass | nonMetaClass == Class ] 
]

{ #category : #testing }
TApplyingOnClassSide >> isObsolete [
	"Return true if the receiver is obsolete"
	^self soleInstance == nil "Either no thisClass"
		or:[self soleInstance classSide ~~ self "or I am not the class of thisClass"
			or:[self soleInstance isObsolete]] "or my instance is obsolete"
]

{ #category : #testing }
TApplyingOnClassSide >> isSelfEvaluating [
	^self isObsolete not
]

{ #category : #testing }
TApplyingOnClassSide >> isUsed [
	"Metaclasses are used by default"
	^ true
]

{ #category : #accessing }
TApplyingOnClassSide >> name [
	^self explicitRequirement.
]

{ #category : #'instance creation' }
TApplyingOnClassSide >> new [
	^self explicitRequirement.
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> obsoleteSubclasses [
	"Answer the receiver's subclasses."

	self isMetaclassOfClassOrNil ifTrue: [ ^ #() ].
	^ self instanceSide obsoleteSubclasses collect: [ :aSubclass | aSubclass classSide ]
]

{ #category : #compiling }
TApplyingOnClassSide >> possibleVariablesFor: misspelled continuedFrom: oldResults [

	^ self instanceSide possibleVariablesFor: misspelled continuedFrom: oldResults

]

{ #category : #'instance variables' }
TApplyingOnClassSide >> removeInstVarNamed: aString [ 
	"Remove the argument, aString, as one of the receiver's instance variables."

	| newArray newString |
	(self instVarNames includes: aString)
		ifFalse: [self error: aString , ' is not one of my instance variables'].
	newArray := self instVarNames copyWithout: aString.
	newString := ''.
	newArray do: [:aString2 | newString := aString2 , ' ' , newString].
	self instanceVariableNames: newString
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> removeSubclass: aClass [
	"Do nothing."
]

{ #category : #'pool variables' }
TApplyingOnClassSide >> sharedPools [
	^OrderedCollection new.
]

{ #category : #'initialize-release' }
TApplyingOnClassSide >> slots: instVarString [
	^self explicitRequirement.
]

{ #category : #accessing }
TApplyingOnClassSide >> soleInstance [
	^self explicitRequirement.
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> subclasses [
	"Answer the receiver's subclasses."
	
	self isMetaclassOfClassOrNil ifTrue: [ ^ #() ].
	^ self instanceSide subclasses collect: [ :aSubclass | aSubclass classSide ].
]

{ #category : #'class hierarchy' }
TApplyingOnClassSide >> subclassesDo: aBlock [
	"Evaluate aBlock for each of the receiver's immediate subclasses."
	
	self isMetaclassOfClassOrNil ifTrue: [ ^ self ].
	self instanceSide subclasses do: [ :each | aBlock value: each classSide ]
]

{ #category : #composition }
TApplyingOnClassSide >> uses: aTraitCompositionOrArray [
	^self explicitRequirement.
]

{ #category : #'initialize-release' }
TApplyingOnClassSide >> uses: aTraitCompositionOrArray instanceVariableNames: instVarString [
	^ self explicitRequirement
]

{ #category : #'initialize-release' }
TApplyingOnClassSide >> uses: aTraitCompositionOrArray slots: slotArray [ 
	^self explicitRequirement.
]

{ #category : #compiling }
TApplyingOnClassSide >> wantsChangeSetLogging [
	"Answer whether code submitted for the receiver should be remembered by the changeSet mechanism.The metaclass follows the rule of the class itself."

	^ self instanceSide wantsChangeSetLogging
]

{ #category : #compiling }
TApplyingOnClassSide >> wantsRecompilationProgressReported [
	"The metaclass follows the rule of the class itself."

	^ self instanceSide wantsRecompilationProgressReported
]
