//
//  Writer.swift
//  SwiftyDB
//
//  Created by Øyvind Grimnes on 22/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation


class Writer: BaseMap {
    
    func getCurrentValue<T: StorableValue>() -> T? {
        guard let key = currentKey else {
            return nil
        }
        
        return storableValues[key] as? T
    }
    
    func getCurrentValue<T: StorableValue>() -> [T]? {
        guard let key = currentKey else {
            return nil
        }
        
        return storableValueArrays[key]?.map { $0 as! T }
    }
    
    func getCurrentValue<T: MapType>() -> T? {
        guard let key = currentKey else {
            return nil
        }

        return mappables[key] as? T
    }
    
    
    func getCurrentValue<T: MapType>() -> [T]? {
        guard let key = currentKey else {
            return nil
        }
        
        if let maps = mappableArrays[key] {
            return maps.matchType()
        }
        
        return nil
    }
}

extension Writer: MapType {
    subscript(key: String) -> MapType {
        currentKey = key
        
        return self
    }
}