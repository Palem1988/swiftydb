//
//  Operators.swift
//  SwiftyDB
//
//  Created by Øyvind Grimnes on 19/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

infix operator <-

// MARK: - Storable properties

public func <- <T: StorableProperty>(left: inout T, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout T, right: Reader) {
    right.setCurrentValue(left.storableValue)
}

func <- <T: StorableProperty>(left: inout T, right: Writer) {
    if let storableValue: T.StorableValueType = right.getCurrentValue() {
        left = T.from(storableValue: storableValue)
    }
}


public func <- <T: StorableProperty>(left: inout T?, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout T?, right: Reader) {
    right.setCurrentValue(left?.storableValue)
}

func <- <T: StorableProperty>(left: inout T?, right: Writer) {
    if let storableValue: T.StorableValueType = right.getCurrentValue() {
        left = T.from(storableValue: storableValue)
    } else {
        left = nil
    }
}


public func <- <T: StorableProperty>(left: inout T!, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout T!, right: Reader) {
    right.setCurrentValue(left?.storableValue)
}

func <- <T: StorableProperty>(left: inout T!, right: Writer) {
    if let storableValue: T.StorableValueType = right.getCurrentValue() {
        left = T.from(storableValue: storableValue)
    } else {
        left = nil
    }
}

// MARK: Array of storable properties

public func <- <T: StorableProperty>(left: inout [T], right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout [T], right: Reader) {
    right.setCurrentValue( CollectionSerialization.stringFor(array: left)!, forType: [T].self  )
}

func <- <T: StorableProperty>(left: inout [T], right: Writer) {
    left = CollectionSerialization.arrayFor(string: right.getCurrentValue()!)
}


public func <- <T: StorableProperty>(left: inout [T]?, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout [T]?, right: Reader) {
    right.setCurrentValue( CollectionSerialization.stringFor(array: left), forType: [T].self  )
}

func <- <T: StorableProperty>(left: inout [T]?, right: Writer) {
    left = CollectionSerialization.arrayFor(string: right.getCurrentValue())
}


public func <- <T: StorableProperty>(left: inout [T]!, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout [T]!, right: Reader) {
    right.setCurrentValue( CollectionSerialization.stringFor(array: left), forType: [T].self )
}

func <- <T: StorableProperty>(left: inout [T]!, right: Writer) {
    left = CollectionSerialization.arrayFor(string: right.getCurrentValue() )
}


// MARK: Set of storable properties

public func <- <T: StorableProperty>(left: inout Set<T>, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout Set<T>, right: Reader) {
    right.setCurrentValue(CollectionSerialization.stringFor(collection: left)!, forType: Set<T>.self)
}

func <- <T: StorableProperty>(left: inout Set<T>, right: Writer) {
    let storableValues: [T.StorableValueType] = right.getCurrentValue()!
        
    left = Set( storableValues.map(T.from) )
}


public func <- <T: StorableProperty>(left: inout Set<T>?, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout Set<T>?, right: Reader) {
    right.setCurrentValue(CollectionSerialization.stringFor(collection: left), forType: Set<T>.self)
}

func <- <T: StorableProperty>(left: inout Set<T>?, right: Writer) {
    if let storableValues: [T.StorableValueType] = right.getCurrentValue() {
        left = Set( storableValues.map(T.from) )
    } else {
        left = nil
    }
}


public func <- <T: StorableProperty>(left: inout Set<T>!, right: Map) {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty>(left: inout Set<T>!, right: Reader) {
    right.setCurrentValue(CollectionSerialization.stringFor(collection: left), forType: Set<T>.self)
}

func <- <T: StorableProperty>(left: inout Set<T>!, right: Writer) {
    if let storableValues: [T.StorableValueType] = right.getCurrentValue() {
        left = Set( storableValues.map(T.from) )
    } else {
        left = nil
    }
}


// MARK: Storable value dicitonaries

public func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U], right: Map) where T.StorableValueType: Hashable {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U], right: Reader) where T.StorableValueType: Hashable {
    
    right.setCurrentValue( CollectionSerialization.stringFor(dictionary: Optional(left)), forType: [T: U].self  )
}

func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U], right: Writer) where T.StorableValueType: Hashable {
    left = CollectionSerialization.dictionaryFor(string: right.getCurrentValue()! )
}


public func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U]?, right: Map) where T.StorableValueType: Hashable {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U]?, right: Reader) where T.StorableValueType: Hashable {
    right.setCurrentValue( CollectionSerialization.stringFor(dictionary: left), forType: [T: U].self  )
}

func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U]?, right: Writer) where T.StorableValueType: Hashable {
    left = CollectionSerialization.dictionaryFor(string: right.getCurrentValue() )
}


public func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U]!, right: Map) where T.StorableValueType: Hashable {
    if let reader = right as? Reader {
        left <- reader
    } else if let writer = right as? Writer {
        left <- writer
    }
}

func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U]!, right: Reader) where T.StorableValueType: Hashable {
    right.setCurrentValue( CollectionSerialization.stringFor(dictionary: left), forType: [T: U].self )
}

func <- <T: StorableProperty, U: StorableProperty>(left: inout [T: U]!, right: Writer) where T.StorableValueType: Hashable {
    left = CollectionSerialization.dictionaryFor(string: right.getCurrentValue() )
}

